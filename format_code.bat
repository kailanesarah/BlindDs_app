@echo off
echo Formatando o código com black...
call venv\Scripts\python.exe -m black .
echo Organizando imports com isort...
call venv\Scripts\python.exe -m isort .

echo ------------------------------------------
echo Verificando a conformidade do código com flake8...
REM O Flake8 lerá automaticamente o 'setup.cfg' na raiz do projeto.
call venv\Scripts\python.exe -m flake8 .
REM Adicionado o 'if errorlevel 1' para parar o script se o Flake8 encontrar erros.
if errorlevel 1 (
    echo.
    echo ❌ ERROS ENCONTRADOS PELO FLAKE8! Corrija antes de prosseguir.
    pause
    exit /b 1
)

echo.
echo ✅ Formatação e Verificação de Linting concluídas com sucesso!
pause