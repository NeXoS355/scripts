REM sync one Folder with a Source Folder without using robocopy

@echo off
SETLOCAL EnableDelayedExpansion

REM Anpassbare Pfade zur Überwachung
SET quelle=Z:\
SET ziel=C:\WNC\home\d_xnc\p_p\prog\Auftraege\

REM "\" am Pfadende sicherstellen
if NOT "%ziel:~-1%" == "\" SET ziel=%ziel%\
if NOT "%quelle:~-1%" == "\" SET ziel=%quelle%\

REM Quelle spiegeln
xcopy %quelle% %ziel% /d /i /s /e

REM zu löschende Ordner bestimmen
for /f  "tokens=*" %%i IN ('dir /s /b /a:d %ziel%') do (
	SET temp1=%%i
	SET comp1=!temp1:%ziel%=!
	SET present=0
	for /f  "tokens=*" %%j IN ('dir /s /b %quelle%') do (
		SET temp2=%%j
		SET comp2=!temp2:%quelle%=!
		if !comp1! EQU !comp2! SET present=1
	)
	
	REM In der Quelle nicht vorhandene Ordner löschen
	if !present!==0	(
	echo Ordner "%%i" geloescht!
	rmdir "%%i" /q /s
	)
)

REM zu löschende Dateien bestimmen
for /f  "tokens=*" %%i IN ('dir /s /b /a:-d %ziel%') do (
	SET temp1=%%i
	SET comp1=!temp1:%ziel%=!
	SET present=0
	for /f  "tokens=*" %%j IN ('dir /s /b %quelle%') do (
		SET temp2=%%j
		SET comp2=!temp2:%quelle%=!
		if !comp1! EQU !comp2! SET present=1
	)
	
	REM In der Quelle nicht vorhandene Dateien löschen
	if !present!==0	(
	echo Datei "%%i" geloescht!
	del "%%i" /q /f
	)
)
pause
