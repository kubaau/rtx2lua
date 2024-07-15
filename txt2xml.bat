@ECHO OFF
FOR /F %%l IN ('DIR /B TXT') DO ( FOR /F %%f IN ('DIR /B TXT\%%l') DO TextEditor\TextEditor.exe -x TXT\%%l\%%f 1> XML\%%l\%%~nf.XML 2> NUL )