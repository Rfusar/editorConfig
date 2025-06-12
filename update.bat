@echo off

echo ### INIZIO AGGIORNAMENTO
cls
git clone https://github.com/Rfusar/editorConfig.git EditorConfig

REM Cancella tutte le cartelle tranne "EditorConfig"
for /d %%D in (*) do (
    if /I not "%%D"=="EditorConfig" (
        echo Eliminazione cartella: %%D
        rmdir /s /q "%%D"
    )
)


REM Elimina tutti i file tranne update.bat, keep.txt e config.ini
for %%F in (*) do (
    if /I not "%%F"=="update.bat" if /I not "%%F"=="notes.txt" if /I not "%%F"=="tasks.txt" (
        echo Eliminazione file: %%F
        del /f /q "%%F"
    )
)

REM Sposta tutti i file da EditorConfig nella directory corrente
pushd EditorConfig
for /f "delims=" %%F in ('dir /b') do (
    move "%%F" ..
)
popd

REM Elimina la cartella EditorConfig
rmdir /s /q EditorConfig

echo ### AGGIORNAMENTO COMPLETATO
endlocal
pause
