# midi-record-playback

- Connect your MIDI device such as a digital piano to your computer and record then convert it to mp3.

## Installation

```bash
sudo apt-get install arecordmidi timidity ffmpeg mpg123 -y
```

## Usage 

```
Usage: ./record.sh [--client client_name] [--output output_file] [--countdown countdown]
Options:
  --client: Client name (default: ARIUS)
  --output: Output file (default: output)
  --countdown: Countdown value (default: 5s)
```

- Stop the Recording

```
CTRL+C
```

