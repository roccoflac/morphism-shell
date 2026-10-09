for transparency, I used an LLM to port caelestias color palette engine to my interface.
I will eventually go through this manually and mess around with it, but right now it works fine.

# scripts/
Drop-in replacement for Matugen that reproduces **caelestia-cli's** palette
selection exactly, then writes `services/ThemeService.qml`.

## Why
Matugen and caelestia use different preprocessing, different quantizer
implementations (Rust vs C++ Celebi/Wsmeans) and different score logic, so the
same wallpaper yields different seeds. The extraction logic here is vendored
verbatim from caelestia-cli, so output matches caelestia-shell.

## Dependencies
The interpreter configured in `Config.theme.python` needs:

- `materialyoucolor`
- `pillow`


## Usage

```sh
python3 scripts/caelestia-theme.py <wallpaper> \
    --output services/ThemeService.qml \
    --mode smart --variant smart --flavour default
```

- `--mode`    `smart | dark | light`
- `--variant` `smart | tonalspot | content | expressive | fidelity | ...`
- `--flavour` `default | hard`
- `--json`    print the scheme JSON instead of writing QML
- Seed/variant/mode are noted in the generated file's header comment.

## How it is wired
`services/WallpaperService.qml` runs the script when a wallpaper is selected and
Quickshell hot-reloads the regenerated `ThemeService.qml` (no FileView watcher):

```sh
quickshell ipc call wallpaper set /abs/path/to/image.jpg
```

## Vendored sources
Copied verbatim from **caelestia-cli `82039823c0d538f8fcaf18a1636bf244bd583da7`**:

- `caelestia/colourfulness.py`  <- `utils/colourfulness.py`
- `caelestia/material/score.py` <- `utils/material/score.py`
- `caelestia/material/generator.py` <- `utils/material/generator.py`

`get_thumb()` / `get_smart_opts()` in `caelestia-theme.py` are copied from
`utils/wallpaper.py`. `caelestia/material/__init__.py` is intentionally empty
(upstream's pulls in `caelestia.utils.paths`, which is not needed here).
