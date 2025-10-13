# BlindDS

## Descrição
**BlindDS** é um aplicativo desenvolvido para **ajudar alunos com deficiência visual** a estudarem e aplicarem a disciplina de Estrutura de Dados.  
O projeto tem como foco proporcionar acessibilidade e aprendizado prático, usando tecnologias modernas de desenvolvimento mobile e web.

## Estrutura do Projeto
O projeto é dividido em duas partes principais:

- **[API Backend](./api/README.md)** → Desenvolvido em **Django**, responsável por gerenciar dados, endpoints e toda a lógica do servidor.  
- **[Frontend](./frontend/README.md)** → Desenvolvido em **Flutter**, responsável pela interface do usuário, navegação, interações e acessibilidade no aplicativo.

### Sobre as Tecnologias

#### Django
- Framework web em Python, rápido e seguro.  
- Responsável pelo **backend** da aplicação, incluindo:
  - Criação de APIs REST para consumo pelo app Flutter  
  - Gestão de usuários e dados da aplicação  
  - Autenticação e autorização  

#### Flutter
- Framework da Google para desenvolvimento de aplicativos **cross-platform** (Android e iOS).  
- Permite criar interfaces acessíveis e interativas, garantindo boa experiência para alunos com deficiência visual.  
- Consome a API Django para exibir dados, interagir com atividades e atualizar informações em tempo real.

---

## Como acessar cada parte do projeto

- **Backend (Django)**: [Clique aqui](./api/README.md)  
- **Frontend (Flutter)**: [Clique aqui](./frontend/README.md)

---

## Contribuição
- Todos os colaboradores devem seguir boas práticas de código, padronização e acessibilidade.  
- Antes de enviar PRs, teste o projeto para garantir que todas as funcionalidades estejam funcionando corretamente.  

### Pre-commit e formatação de código
O projeto utiliza **pre-commit hooks** para manter o padrão de código com as seguintes ferramentas:

- **black** → formatação de código Python  
- **isort** → organização de imports  
- **flake8** → verificação de lint  

#### Como usar os comandos de pre-commit

1. **Verificar o código antes de commitar (sem modificar arquivos automaticamente):**

```bash
pre-commit run --all-files
```

2. **Formatar o código automaticamente (Windows):**

```bash
format_code.bat || 
.\format_code.bat

```
---

## Licença e uso

- Este projeto **não deve ser comercializado**, vendido ou usado para fins lucrativos.  
- É destinado **apenas para fins educacionais e de pesquisa**.  
- Qualquer contribuição deve respeitar a missão de acessibilidade do BlindDS.
