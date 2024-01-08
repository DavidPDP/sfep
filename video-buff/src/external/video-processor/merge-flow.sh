#!/bin/sh

# Locate .mp4 files in the specified directory that match the pattern '[0-9]*.mp4'
find "$inputVideoClipPath" -maxdepth 1 -type f -name '[0-9]*.mp4' -printf "%f\n" | \

# Filter .mp4 files based on start_range and end_range
awk -F'[.]' -v input_path="$inputVideoClipPath" -v start_range="$startRange" -v end_range="$endRange" \
  '$1 >= start_range && $1 <= end_range {print input_path "/" $1 ".mp4"}' | \

# Filter .mp4 files based on the integrity
xargs -P0 -I {} sh -c '
  if ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$1" > /dev/null 2>&1
  then
    echo "file file:'\''$1'\''"
  fi
' _ {} | \

# Sort .mp4 files to preserve the order
sort | \

# Merge .mp4 files avoiding decoding errors
ffmpeg -loglevel error -err_detect ignore_err -protocol_whitelist file,pipe \
  -f concat -safe 0 -i pipe: -c copy "$outputVideoClipPath"
