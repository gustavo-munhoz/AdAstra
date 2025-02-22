# drive_utils.py

import io
import os
import face_recognition
from urllib.parse import urlparse, parse_qs
from google.oauth2 import service_account
from googleapiclient.discovery import build
from googleapiclient.http import MediaIoBaseDownload
from PIL import Image, ImageDraw
from firebase_client import upload_profile_picture

SERVICE_ACCOUNT_FILE = os.path.join(os.path.dirname(__file__), 'serviceAccountKey.json')
SCOPES = ['https://www.googleapis.com/auth/drive.readonly']

creds = service_account.Credentials.from_service_account_file(
    SERVICE_ACCOUNT_FILE, scopes=SCOPES
)
drive_service = build('drive', 'v3', credentials=creds)


def extract_file_id(url: str) -> str:
    parsed = urlparse(url)
    qs = parse_qs(parsed.query)
    return qs.get("id", [None])[0]


def download_profile_picture(url: str) -> bytes:
    """
    Baixa um arquivo do Google Drive dado o file ID e retorna seu conteúdo em bytes.

    Parâmetros:
      - file_id: O ID do arquivo no Google Drive (obtido da planilha).

    Retorna:
      - Os dados do arquivo (imagem) em formato de bytes.

    Caso o download falhe, uma exceção será lançada.
    """
    file_id = extract_file_id(url)

    request = drive_service.files().get_media(fileId=file_id)
    fh = io.BytesIO()
    downloader = MediaIoBaseDownload(fh, request)
    done = False
    while not done:
        status, done = downloader.next_chunk()
        print(f"Downloading file {file_id}: {int(status.progress() * 100)}%")
    fh.seek(0)
    return fh.read()


def crop_face_to_circle_from_bytes(image_bytes: bytes, marginFactor: float = 0.5) -> bytes:
    """
    Detecta o rosto na imagem, recorta com uma margem extra e aplica uma máscara circular.

    :param image_bytes: Dados da imagem em bytes.
    :param marginFactor: Fração para expandir o retângulo detectado em cada direção (ex: 0.2 aumenta 20%).
    :return: Imagem recortada em bytes (PNG).
    """
    pil_image = Image.open(io.BytesIO(image_bytes)).convert("RGB")
    width, height = pil_image.size

    image_np = face_recognition.load_image_file(io.BytesIO(image_bytes))
    face_locations = face_recognition.face_locations(image_np)

    if not face_locations:
        with io.BytesIO() as output:
            pil_image.save(output, format="PNG")
            return output.getvalue()

    top, right, bottom, left = face_locations[0]

    face_width = right - left
    face_height = bottom - top

    marginX = int(face_width * marginFactor)
    marginY = int(face_height * marginFactor)

    new_left = max(0, left - marginX)
    new_top = max(0, top - marginY)
    new_right = min(width, right + marginX)
    new_bottom = min(height, bottom + marginY)

    face_image = pil_image.crop((new_left, new_top, new_right, new_bottom))

    mask = Image.new("L", face_image.size, 0)
    draw = ImageDraw.Draw(mask)
    draw.ellipse((0, 0, face_image.size[0], face_image.size[1]), fill=255)

    circular_face = Image.new("RGBA", face_image.size)
    circular_face.paste(face_image, (0, 0), mask=mask)

    with io.BytesIO() as output:
        circular_face.save(output, format="PNG")
        return output.getvalue()


def save_image_locally(image_bytes: bytes, output_filename: str) -> None:
    """
    Salva os bytes da imagem em um arquivo local.

    Parâmetros:
      - image_bytes: os dados da imagem (por exemplo, retornados por crop_face_to_circle_from_bytes)
      - output_filename: o nome do arquivo para salvar (ex: "profile_123.png")
    """
    # Define o diretório de saída relativo ao arquivo atual
    output_dir = os.path.join(os.path.dirname(__file__), "output_images")
    os.makedirs(output_dir, exist_ok=True)

    output_path = os.path.join(output_dir, output_filename)

    with open(output_path, "wb") as f:
        f.write(image_bytes)

    print(f"Image saved at: {output_path}")


def save_user_profile_picture(doc_id: str, url: str):
    image_bytes = download_profile_picture(url)
    cropped_image = crop_face_to_circle_from_bytes(image_bytes)
    # save_image_locally(cropped_image, f"{doc_id}.png")
    upload_profile_picture(doc_id, cropped_image)
