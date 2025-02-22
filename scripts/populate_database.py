# populate_database.py

import csv
from firebase_client import fetch_sheet_data, add_user_to_firestore
from mapping import map_gradient_name, map_texture_name, map_shift_name
from drive_utils import save_user_profile_picture

SPREADSHEET_ID = '1wBv5_KGGOy_fpbPI5Z6jMFfo8GlIDupWtpdD_WDAaZo'
RANGE_NAME = 'Respostas!A1:Z100'


def map_row_to_user(row, headers: list) -> (dict, str):
    """
    Mapeia uma linha do CSV (ou da planilha) para o dicionário do usuário.
    """
    data = dict(zip(headers, row))
    
    name = data.get("Como você gostaria de ser chamado na Academy?", "").strip()
    pronouns = data.get("Quais são seus pronomes?", "").strip()

    age_str = data.get("Qual sua idade?", "0").strip()
    if age_str == "??":
        age_str = "0"

    age = int(age_str)

    shift_pt = data.get("Qual turno você está?", "").strip()
    texture_pt = data.get("Se você fosse uma forma geométrica, qual seria?", "").strip()
    gradient_pt = data.get("Qual dessas cores você prefere?", "").strip()

    shift_en = map_shift_name(shift_pt)
    gradient_en = map_gradient_name(gradient_pt)
    texture_en = map_texture_name(texture_pt)

    profile_picture_url = data.get("Insira aqui uma foto que você usaria como foto de perfil").strip()

    course = data.get("Qual sua formação?", "").strip()
    interests_raw = data.get("Quais são seus interesses?", "")
    interests = {i.strip() for i in interests_raw.split(',') if i.strip()}
    secret_fact = data.get("Compartilhe um fato curioso seu.", "").strip()
    connection_password = data.get("Escolha uma palavra-chave", "").strip().lower()
    
    role = "jrMentor"
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
        "shift": shift_en,
        "role": role,
        "interests": list(interests),
        "pronouns": pronouns,
        "connectionPassword": connection_password,
        "connectionCount": connection_count,
        "connectedUsers": [],
        "secretFact": secret_fact,
        "planet": planet
    }

    return user_data, profile_picture_url


def main():
    print("Connecting to Google Sheets...")
    sheet_values = fetch_sheet_data(SPREADSHEET_ID, RANGE_NAME)

    print("Connected to Google Sheets!")

    if not sheet_values:
        print("No data found inside the sheet.")
        return

    print("Reading data...")

    headers = sheet_values[0]
    rows = sheet_values[1:]
    
    for row in rows:
        try:
            user_data, profile_picture_url = map_row_to_user(row, headers)
            doc_ref = add_user_to_firestore(user_data)
            doc_id = doc_ref.id

            save_user_profile_picture(doc_id, profile_picture_url)

            print(f"User '{user_data['name']}' added with docId: {doc_id}")
        except Exception as e:
            print(f"Error processing row {row}: {e}")

    print("Done!")


if __name__ == "__main__":
    main()
