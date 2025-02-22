# firebase_client.py

import firebase_admin
import os
from firebase_admin import credentials, firestore, storage
from google.oauth2 import service_account
from googleapiclient.discovery import build
from google.cloud.firestore_v1.base_query import FieldFilter

# Configuração do Firebase Admin
FIREBASE_CRED_PATH = os.path.join(os.path.dirname(__file__), 'serviceAccountKey.json')
STORAGE_BUCKET_PATH = "adastra-84f2d.firebasestorage.app"

cred = credentials.Certificate(FIREBASE_CRED_PATH)
firebase_admin.initialize_app(cred, {
    'storageBucket': STORAGE_BUCKET_PATH
})

db = firestore.client()

# Configuração da Google Sheets API
SERVICE_ACCOUNT_FILE = os.path.join(os.path.dirname(__file__), 'serviceAccountKey.json')
SCOPES = ['https://www.googleapis.com/auth/spreadsheets.readonly']
sheets_creds = service_account.Credentials.from_service_account_file(
    SERVICE_ACCOUNT_FILE, scopes=SCOPES
)

sheets_service = build('sheets', 'v4', credentials=sheets_creds)


def user_already_exists(connection_password: str) -> list:
    """
    Verifica se já existe um ou mais documentos na coleção "users"
    com o mesmo connectionPassword.
    Retorna a lista de documentos encontrados.
    """
    query = db.collection("users").where(filter=FieldFilter("connectionPassword", "==", connection_password)).get()
    return query


def fetch_sheet_data(spreadsheet_id: str, range_name: str):
    """Lê os dados da planilha e retorna uma lista de linhas (lista de listas)."""
    result = sheets_service.spreadsheets().values().get(
        spreadsheetId=spreadsheet_id, range=range_name
    ).execute()
    values = result.get('values', [])
    return values


def add_user_to_firestore(user_data: dict):
    """
    Adiciona um documento na coleção 'users' com os dados fornecidos.
    Retorna o document reference.
    """
    doc_ref = db.collection("users").add(user_data)[1]
    return doc_ref


def upload_profile_picture(doc_id: str, image_bytes: bytes, user_name: str) -> str:
    """
    Faz o upload dos bytes de uma imagem para o Firebase Storage no caminho
    profile_pictures/{doc_id}/profile.jpg e retorna a URL pública da imagem.

    :param doc_id: O ID do documento do usuário, que será usado no caminho.
    :param image_bytes: Os dados da imagem em bytes.
    :return: A URL pública da imagem, se o blob for tornado público.
    """
    print(f"Uploading '{user_name}' picture to Firebase Storage...")

    bucket = storage.bucket()

    blob_path = f"profile_pictures/{doc_id}/profile.png"
    blob = bucket.blob(blob_path)

    blob.upload_from_string(image_bytes, content_type='image/png')

    print(f"'{user_name}'s picture uploaded successfully!")

    blob.make_public()
    return blob.public_url
