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

convert_midi_to_mp3() {
  echo "Converting MIDI to MP3..."
  timidity "$output_file.mid" -Ow -o - | ffmpeg -i - -acodec libmp3lame -ab 64k "$output_file.mp3"
  mpg123 "$output_file.mp3"
  exit 0
}
trap convert_midi_to_mp3 INT

main() {
  midi_port=$(get_midi_port)
  arecordmidi --port "$midi_port" "$output_file.mid"
}

main
