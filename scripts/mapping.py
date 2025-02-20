# mapping.py

def map_gradient_name(gradient_pt: str) -> str:
    """
    Mapeia o nome do gradiente em português para inglês.
    Ajuste o mapeamento conforme necessário.
    """
    mapping = {
        "Turquesa": "turquoise",
        "Verde": "green",
        "Vermelho": "red",
        "Amarelo": "yellow",
        "Rosa": "pink",
        "Roxo": "purple",
        "Azul": "blue",
        "Preto": "black",
        "Branco": "white"
    }
    
    return mapping.get(gradient_pt.lower(), gradient_pt)

def map_texture_name(texture_pt: str) -> str:
    """
    Mapeia o nome da textura em português para inglês.
    """
    mapping = {
        "Triângulo": "triangles",
        "Círculo": "circles",
        "Retângulo": "rectangles",
    }
    return mapping.get(texture_pt.lower(), texture_pt)
