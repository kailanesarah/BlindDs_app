@echo off
echo Formatando o código com black...
call venv\Scripts\python.exe -m black .
echo Organizando imports com isort...
call venv\Scripts\python.exe -m isort .
echo Formatação concluída!
pause

