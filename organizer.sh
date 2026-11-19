#!/usr/bin/env bash
# organizer.sh
#
# Archives the current grades.csv with a timestamp, starts a fresh empty
# grades.csv for the next batch, and logs every run to organizer.log.
#
# Usage: ./organizer.sh

ARCHIVE_DIR="archive"
SOURCE="grades.csv"
LOG_FILE="organizer.log"

# Make sure the archive directory exists.
if [ ! -d "$ARCHIVE_DIR" ]; then
	mkdir -p "$ARCHIVE_DIR"
	echo "Created directory: $ARCHIVE_DIR"
fi

# There must be a grades file to archive.
if [ ! -f "$SOURCE" ]; then
	echo "Error: $SOURCE not found in $(pwd). Nothing to archive." >&2
	exit 1
fi

timestamp="$(date +%Y%m%d-%H%M%S)"
archived_name="grades_${timestamp}.csv"

# Archive: rename with the timestamp and move into the archive directory.
if ! mv "$SOURCE" "$ARCHIVE_DIR/$archived_name"; then
	echo "Error: could not archive $SOURCE." >&2
	exit 1
fi

# Workspace reset: create a new, empty grades.csv for the next batch.
: > "$SOURCE"

# Log the operation (appends, so every run is kept).
echo "$timestamp | original: $SOURCE | archived: $ARCHIVE_DIR/$archived_name" >> "$LOG_FILE"

echo "Archived $SOURCE -> $ARCHIVE_DIR/$archived_name"
echo "Created a new empty $SOURCE"
echo "Logged to $LOG_FILE"
