# populate_database.py

import csv
from firebase_client import fetch_sheet_data, add_user_to_firestore
from mapping import map_gradient_name, map_texture_name

SPREADSHEET_ID = '1LFtRnYaITaICjULZewEhB4DEv6EBMHGewfjIqCtFbDY'
RANGE_NAME = 'Sheet1!A1:Z100'

def map_row_to_user(row, headers: list) -> dict:
    """
    Mapeia uma linha do CSV (ou da planilha) para o dicionário do usuário.
    """
    data = dict(zip(headers, row))
    
    name = data.get("Como você gostaria de ser chamado na Academy?", "").strip()
    pronouns = data.get("Quais são seus pronomes?", "").strip()
    shift = data.get("Qual turno você está?", "").strip()
    age = int(data.get("Qual sua idade?", "0").strip())
    geometric_shape = data.get("Se você fosse uma forma geométrica, qual seria?", "").strip()
    
    gradient_pt = data.get("Qual dessas cores você prefere?", "").strip()
    texture_pt = data.get("Nome da textura", "").strip()
    
    gradient_en = map_gradient_name(gradient_pt)
    texture_en = map_texture_name(texture_pt)
    
    course = data.get("Qual sua formação?", "").strip()
    interests_raw = data.get("Quais são seus interesses?", "")
    interests = {i.strip() for i in interests_raw.split(',') if i.strip()}
    secret_fact = data.get("Compartilhe um fato curioso seu.", "").strip()
    connection_password = data.get("Escolha uma palavra-chave", "").strip()
    
    role = "student"
    connection_count = 0

    planet = {
        "name": "Planeta sem nome",
        "gradientName": gradient_en,
        "textureName": texture_en
    }
    
    user_data = {
        "name": name,
        "age": age,
        "course": course,
        "shift": shift,
        "role": role,
        "interests": list(interests),
        "pronouns": pronouns,
        "connectionPassword": connection_password,
        "connectionCount": connection_count,
        "connectedUsers": [],
        "secretFact": secret_fact,
        "planet": planet
    }
    
    return user_data

def main():
    sheet_values = fetch_sheet_data(SPREADSHEET_ID, RANGE_NAME)
    if not sheet_values:
        print("Nenhum dado encontrado na planilha.")
        return

    headers = sheet_values[0]
    rows = sheet_values[1:]
    
    for row in rows:
        try:
            user_data = map_row_to_user(row, headers)
            doc_ref = add_user_to_firestore(user_data)
            doc_id = doc_ref.id
            print(f"User '{user_data['name']}' added with docId: {doc_id}")
        except Exception as e:
            print(f"Error processing row {row}: {e}")

if __name__ == "__main__":
    main()
