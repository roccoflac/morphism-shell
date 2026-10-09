from typing import Any, Protocol

from materialyoucolor.dynamiccolor.material_dynamic_colors import MaterialDynamicColors
from materialyoucolor.hct import Hct
from materialyoucolor.utils.math_utils import difference_degrees, rotation_direction, sanitize_degrees_double
from materialyoucolor.scheme.scheme_content import SchemeContent
from materialyoucolor.scheme.scheme_expressive import SchemeExpressive
from materialyoucolor.scheme.scheme_fidelity import SchemeFidelity
from materialyoucolor.scheme.scheme_fruit_salad import SchemeFruitSalad
from materialyoucolor.scheme.scheme_monochrome import SchemeMonochrome
from materialyoucolor.scheme.scheme_neutral import SchemeNeutral
from materialyoucolor.scheme.scheme_rainbow import SchemeRainbow
from materialyoucolor.scheme.scheme_tonal_spot import SchemeTonalSpot
from materialyoucolor.scheme.scheme_vibrant import SchemeVibrant

try:
    from materialyoucolor.dynamiccolor.dynamic_scheme import DynamicScheme
except ImportError:
    from materialyoucolor.scheme.dynamic_scheme import DynamicScheme


class SchemeConstructor(Protocol):
    def __call__(self, source_color_hct: Any, is_dark: bool, contrast_level: float) -> DynamicScheme: ...


def lighten(colour: Hct, amount: float) -> Hct:
    diff = (100 - colour.tone) * amount
    return Hct.from_hct(colour.hue, colour.chroma + diff / 5, colour.tone + diff)


def darken(colour: Hct, amount: float) -> Hct:
    diff = colour.tone * amount
    return Hct.from_hct(colour.hue, colour.chroma - diff / 5, colour.tone - diff)


def get_scheme(name: str) -> SchemeConstructor:
    schemes = {
        "content": SchemeContent,
        "expressive": SchemeExpressive,
        "fidelity": SchemeFidelity,
        "fruitsalad": SchemeFruitSalad,
        "monochrome": SchemeMonochrome,
        "neutral": SchemeNeutral,
        "rainbow": SchemeRainbow,
        "tonalspot": SchemeTonalSpot,
        "vibrant": SchemeVibrant,
    }
    return schemes.get(name, SchemeVibrant)


def gen_scheme(scheme, primary: Hct) -> dict[str, str]:
    is_light = scheme.mode == "light"
    primary_scheme = get_scheme(scheme.variant)(
        source_color_hct=primary,
        is_dark=not is_light,
        contrast_level=0.0,
    )

    colours = {}
    if hasattr(MaterialDynamicColors, "all_colors"):
        dynamic_colours = MaterialDynamicColors()
        for colour in dynamic_colours.all_colors:
            colours[colour.name] = colour.get_hct(primary_scheme)
    else:
        for name in vars(MaterialDynamicColors):
            colour = getattr(MaterialDynamicColors, name)
            if hasattr(colour, "get_hct"):
                colours[name] = colour.get_hct(primary_scheme)

    # Older materialyoucolor releases use snake_case palette-key names.
    if "primaryPaletteKeyColor" in colours:
        for name in ("primary", "secondary", "tertiary", "neutral"):
            colours[f"{name}_paletteKeyColor"] = colours[f"{name}PaletteKeyColor"]
        colours["neutral_variant_paletteKeyColor"] = colours["neutralVariantPaletteKeyColor"]

    # Preserve Caelestia's neutral variant adjustment for Material roles only.
    if scheme.variant == "neutral":
        for colour in colours.values():
            colour.chroma = max(0, colour.chroma - 15)

    # Optional Caelestia 'hard' flavour: increase surface contrast.
    if scheme.flavour == "hard":
        for name in ("background", *(key for key in colours if key.startswith("surface"))):
            if name in colours:
                colours[name] = lighten(colours[name], 0.4) if is_light else darken(colours[name], 0.8)

    return {name: f"{colour.to_int() & 0xFFFFFF:06x}" for name, colour in colours.items()}
