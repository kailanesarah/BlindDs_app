# users/utils.py

import random
import re
import string


def generate_username(name: str, max_length: int = 30) -> str:
    """
    Gera um username único a partir do nome fornecido.
    Remove espaços e caracteres especiais, adiciona números aleatórios.
    """
    # Remove espaços e caracteres não alfanuméricos
    base_username = re.sub(r"[^a-zA-Z0-9]", "", name).lower()

    # Adiciona um sufixo aleatório para evitar duplicidade
    suffix = "".join(random.choices(string.digits, k=4))

    username = f"{base_username}{suffix}"

    # Garante que não ultrapasse max_length
    return username[:max_length]
