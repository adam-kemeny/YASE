@echo off
cecho {A0}YASE v1.1 2016 Sept{#}
echo.
cecho {06}#####################################{#}
echo.
set /P url=Right-click paste video URL, Enter:  
echo.
"%~dp0/youtube-dl/youtube-dl.exe" -F %url%
echo.
cecho {06}#####################################{#}
echo.
cecho CHOOSE FORMAT CODE {lime on black}(default: 140) {#}
set /P format=""
cecho {06}#####################################{#}
echo.
::ask (or) statement to set type m4a(mp4) for filename output, else original filename
if '%format%'=='m4a' set type=m4a
if '%format%'=='140' set type=m4a
if '%format%'=='36' set type=m4a
if '%format%'=='22' set type=m4a
if '%format%'=='18' set type=m4a
if '%format%'=='17' set type=m4a

if '%format%'=='opus' set type=opus
if '%format%'=='251' set type=opus
if '%format%'=='250' set type=opus
if '%format%'=='249' set type=opus

if '%format%'=='ogg' set type=vorbis
if '%format%'=='171' set type=vorbis
if '%format%'=='43' set type=vorbis

if defined type (goto audio_only) else (goto download_other)

:download_m4a
echo initialize download mp4
"%~dp0/youtube-dl/youtube-dl.exe" -f %format% -o input.mp4 %url%
goto mux_m4a

:download_opus
echo initialize download webm
"%~dp0/youtube-dl/youtube-dl.exe" -f %format% -o input.webm %url%
goto mux_opus

:download_vorbis
echo initialize download webm
"%~dp0/youtube-dl/youtube-dl.exe" -f %format% -o input.webm %url%
goto mux_vorbis

:download_other
echo download
"%~dp0/youtube-dl/youtube-dl.exe" -f %format% %url%
goto end

:audio_only
cecho AUDIO ONLY? (Y/N) {lime on black}(default: Y) {#}
set /P inputao=""
cecho {06}#####################################{#}
echo.
echo.
if '%inputao%'=='y' set ao=1
if '%inputao%'=='Y' set ao=1
if '%inputao%'=='1' set ao=1
if defined inputao goto ao_sort 

:ao_sort

if '%ao%'=='1' (
if %type%==m4a goto download_m4a
if %type%==vorbis goto download_vorbis
if %type%==opus goto download_opus
) else (goto download_other)

:mux_m4a
echo.
cecho {06}#####################################{#}
echo.
cecho {0A}MP4BOX MUX PROCESS TO LEGACY CONTAINER (DE-DASH){#}
echo.
cecho {0A}extension:.M4A container:MP4 codec:AAC{#}
echo.
cecho {06}#####################################{#}
echo.
echo.
if exist song.m4a del song.m4a
"%~dp0/mp4box/mp4box.exe" -add "input.mp4#audio" "song.m4a"
goto end

:end
echo.
cecho {06}#####################################{#}
echo.
cecho {05}EXITING!{#}
echo.
cecho {06}#####################################{#}
echo.
echo.
if exist input.webm del input.webm
if exist input.mp4 del input.mp4
pause
exit


:mux_opus
echo.
cecho {06}#####################################{#}
echo.
cecho {0A}FFMPEG MUX PROCESS TO LEGACY CONTAINER (DE-DASH){#}
echo.
cecho {0A}extension:.OPUS container:OGG codec:OPUS{#}
echo.
cecho {06}#####################################{#}
echo.
echo.
"%~dp0/ffmpeg/ffmpeg.exe" -i "input.webm" -vn -acodec copy "song.opus"
goto end

:mux_vorbis
echo.
cecho {06}#####################################{#}
echo.
cecho {0A}FFMPEG MUX PROCESS TO LEGACY CONTAINER (DE-DASH){#}
echo.
cecho {0A}extension:.OGG container:OGG codec:VORBIS{#}
echo.
cecho {06}#####################################{#}
echo.
echo.
"%~dp0/ffmpeg/ffmpeg.exe" -i "input.webm" -vn -acodec copy "song.ogg"
goto end