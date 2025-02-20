# mapping.py

def map_gradient_name(gradient_pt: str) -> str:
    """
    Mapeia o nome do gradiente em português para inglês.
    Ajuste o mapeamento conforme necessário.
    """
    mapping = {
        "turquesa": "turquoise",
        "verde": "green",
        "vermelho": "red",
        "amarelo": "yellow",
        "rosa": "pink",
        "roxo": "purple",
        "azul": "blue",
        "preto": "black",
        "branco": "white"
    }
    
    return mapping.get(gradient_pt.lower(), gradient_pt)


def map_texture_name(texture_pt: str) -> str:
    """
    Mapeia o nome da textura em português para inglês.
    """
    mapping = {
        "triângulo": "triangles",
        "círculo": "circles",
        "retângulo": "rectangles",
    }

    return mapping.get(texture_pt.lower(), texture_pt)


def map_shift_name(shift_pt: str) -> str:
    """
    Mapeia o nome do turno em português para inglês.
    """
    mapping = {
        "manhã": "morning",
        "tarde": "afternoon",
        "integral": "integral"
    }

    return mapping.get(shift_pt.lower(), shift_pt)