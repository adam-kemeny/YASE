# Youtube Audio Stream Extractor
1.1 Sept 2016

## Intro:
The goal of this script is to exract youtube audio without quality loss.

Most of the available tools convert/reencode the audio stream which is harmful to quality especially since most of the
content on youtube has already be reencoded multiple times even before it was uploaded.

`#DeepFriedJpg.jpg`

## Usage:

`RUN.bat`
1. Specify youtube video URL
2. In this step choose the `FORMAT CODE` with the highest bitrate audio.
   * `AAC` (`MP4/M4A DASH `to `MP4/M4A` container): Usually `FORMAT CODE` `22` or `140` with 192kbit/s or 128kbit/s respectively.
   * `OPUS` (`WEBM DASH` to `OGG` container): Usually `FORMAT CODE` `251` with ~160kbit/s.
3. In this step you can choose to discard the video stream and remux to the container specified above. This is necessary
 for most audio players as they expect a non-dash standard containers.
4. The file `song.{container}` is generated within the same folder as `RUN.bat`.


## Dependencies:

* `ffmpeg/ffmpeg.exe`
* `mp4box/mp4box.exe`
* `youtube-dl/youtube-dl.exe`
* `cecho.exe`
* `cecho_x64.exe`
* `js.dll`
* `js32.dll`
