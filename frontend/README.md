
## 2️⃣ `frontend/README.md` (Flutter Frontend)

# BlindDS - Frontend (Flutter)

## Descrição
O frontend do **BlindDS** é desenvolvido em **Flutter**, criando uma interface acessível e interativa para alunos com deficiência visual.  
Ele consome a **API Django** para exibir dados, atividades e progresso do aluno.

## Pré-requisitos
- Flutter SDK (estável)  
- Android Studio ou VS Code com extensão Flutter  
- Emulador Android ou dispositivo físico conectado  

## Instalação e configuração

1. Clone o repositório e vá para a pasta `frontend/`:

```bash
cd frontend
```
## Instale as dependências do Flutter:

```bash
flutter pub get
```
## Verifique se tudo está correto:

```bash
Copiar código
flutter doctor
```

## Rodando o aplicativo

### Para Android:

```bash
flutter run
```

### Para iOS (MacOS):

```bash
flutter run
```

## O aplicativo irá compilar e abrir no emulador ou dispositivo conectado.

## Estrutura do Frontend

- `lib/` → código Dart do app
  - `screens/` → telas do aplicativo
  - `widgets/` → widgets reutilizáveis
  - `services/` → chamadas à API Django
  - `models/` → modelos de dados
  - `core/` → constantes, temas e configuração global

## Boas práticas

- Seguir padrões de código e nomenclatura do Dart/Flutter
- Criar widgets pequenos e reutilizáveis
- Testar funcionalidades no emulador ou dispositivo real

## Licença

- Projeto apenas para fins educacionais e de pesquisa.
- Não comercializar ou distribuir.

---