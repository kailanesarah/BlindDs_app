api/README.md (Django Backend)
# BlindDS - Backend (Django)

## Descrição
O backend do **BlindDS** é desenvolvido em **Django** e é responsável por toda a lógica do servidor, incluindo:

- Criação de APIs REST para o app Flutter consumir  
- Gestão de usuários e dados da aplicação  
- Autenticação e autorização  
- Controle de atividades e progresso dos alunos  

## Pré-requisitos
- Python 3.10+  
- pip  
- Virtualenv (recomendado)  

## Instalação e configuração

1. Clone o repositório 

## Crie um ambiente virtual:

```bash

python -m venv venv

```

## Ative o ambiente virtual:

### Windows:

```bash

venv\Scripts\activate

```

### Linux/Mac:

```bash

source venv/bin/activate

```
## Navegue para o repositório:

```bash

cd api

```

## Instale as dependências:

```bash

pip install -r requirements.txt

```

## Configure as variáveis de ambiente disponíveis em .env.example

## Execute as migrations do Django:

```bash

python -m manage.py makemigrations
python -m manage.py migrate

```

## Crie um superusuário para acesso ao admin (opcional):

```bash

python manage.py createsuperuser

```

## Rodando o servidor
```bash

python manage.py runserver

```

O backend ficará disponível localmente em [http://127.0.0.1:8000/](http://127.0.0.1:8000/),.

## Estrutura da API

- `models/` → modelos de dados
- `views/` → lógica de endpoints
- `serializers/` → transformação de dados para JSON
- `urls.py` → rotas da API

## Contribuição

- Seguir padrões de código, boas práticas de Django e Django REST Framework.
- Sempre testar os endpoints antes de enviar PR.

## Licença

- Projeto apenas para fins educacionais e de pesquisa.
- Não comercializar ou distribuir.
