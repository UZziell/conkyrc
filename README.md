# conkyrc
**Conky** is a free, light-weight system monitor for X.
This is a onky config file that beside system information shows playing song's lyrics and jalali calendar. To get the lyric or calendar it will execute **lyric_cal.sh**. lyric_cal.sh first checks if any song is playing, if so returns the lyrics otherwise shows calendar.

### Screenshots
* Lyrics:
![Alt text](screenshots/lyric.png?raw=true "Lyrics")
* Calendar:
![Alt text](screenshots/jcal.png?raw=true "Calendar")

### Prerequisites
* conky package itself should be installed.
* playerctl package to find the current playing song info.
* jcal package to show the calendar.

In debian based distros you can install them with:
```
sudo apt update && sudo apt install conky playerctl jcal
```
also clone the repo or download  the zip:
```
git clone https://github.com/UZziell/conkyrc.git
```

### Using

Just tell conky to use this config file instead of the default config:

```
conky -c /path/to/conkyrc/conkyrc
```
