#!/usr/bin/env bash
set -e

client_name="ARIUS"
output_file="output"

get_midi_port() {
  device_output=$(arecordmidi -l)
  local port;
  port=$(echo "$device_output" | grep "$client_name" | awk '{print $1}')
  if [ -n "$port" ]; then
      echo "$port"
  else
      echo "No MIDI client found with the name: $client_name"
      exit 1
  fi
}

start_recording() {
  local mid_file
  mid_file="$output_file.mid"
  if [ -e "$mid_file" ]; then
      rm "$mid_file"
  fi
  echo "Recording..."
  arecordmidi --port "$1" "$mid_file"
}

convert_midi_to_mp3() {
  local mp3_file
  mp3_file="$output_file.mp3"
  if [ -e "$mp3_file" ]; then
      rm "$mp3_file"
  fi
  echo "Converting MIDI to MP3..."
  timidity "$output_file.mid" -Ow -o - | ffmpeg -i - -acodec libmp3lame -ab 64k "$mp3_file"
  play "$mp3_file"
}
trap convert_midi_to_mp3 INT

play() {
  echo "Playing $1..."
  mpg123 "$1"
}

midi_port=$(get_midi_port)
start_recording "$midi_port"

echo "Done"
exit 0
