# firebase_client.py

import firebase_admin
import os
from firebase_admin import credentials, firestore
from google.oauth2 import service_account
from googleapiclient.discovery import build

# Configuração do Firebase Admin
FIREBASE_CRED_PATH = os.path.join(os.path.dirname(__file__), 'serviceAccountKey.json')
cred = credentials.Certificate(FIREBASE_CRED_PATH)
firebase_admin.initialize_app(cred)
db = firestore.client()

# Configuração da Google Sheets API
SERVICE_ACCOUNT_FILE = os.path.join(os.path.dirname(__file__), 'serviceAccountKey.json')
SCOPES = ['https://www.googleapis.com/auth/spreadsheets.readonly']
sheets_creds = service_account.Credentials.from_service_account_file(
    SERVICE_ACCOUNT_FILE, scopes=SCOPES
)

sheets_service = build('sheets', 'v4', credentials=sheets_creds)


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
