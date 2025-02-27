# mapping.py

def map_user_role(keyword: str) -> str:
    keyword = keyword.lower()
    
    jrMentorKeywords = ["besouro", "kuma", "gibraltar", "mayhem", "chuvinha", "chocomenta", "infinito-1", "minas gerais", "gatos e sopas", "matcha gelado", "embraer 195"]
    mentorKeywords = ["vermelho", "banana", "cthulhu", "urubu", "artesão"]
    
    if keyword in mentorKeywords:
        return "mentor"
    if keyword in jrMentorKeywords:
        return "jrMentor"
        
    return "student"

def verify_and_map_user_shift(currentShift: str, keyword: str) -> str:
    keyword = keyword.lower()
    
    integralKeywords = ["cthulhu", "banana", "vermelho", "infinito-1", "urubu", "artesão"]
    
    if keyword in integralKeywords:
        return "integral"
        
    return currentShift
    

def map_gradient_name(gradient_pt: str) -> str:
    """
    Mapeia o nome do gradiente em português para inglês.
    Ajuste o mapeamento conforme necessário.
    """
    mapping = {
        "turquesa": "planetTurquoise",
        "verde": "planetGreen",
        "vermelho": "planetRed",
        "amarelo": "planetYellow",
        "rosa": "planetPink",
        "roxo": "planetPurple",
        "azul": "planetBlue",
        "preto": "planetBlack",
        "branco": "planetWhite"
    }
    
    return mapping.get(gradient_pt.lower(), gradient_pt)


def map_texture_name(texture_pt: str) -> str:
    """
    Mapeia o nome da textura em português para inglês.
    """
    mapping = {
        "triângulo": "triangles",
        "círculo": "circles",
        "quadrado": "rectangles",
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
