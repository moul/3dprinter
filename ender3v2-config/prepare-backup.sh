#!/bin/sh

rm -f octoprint/basedir/data/PrintJobHistory/snapshots/*.jpg
find octoprint -name "*.cache" -delete
rm -f octoprint/basedir/config.backup
rm -f octoprint/basedir/users.yaml
rm -f octoprint/basedir/box-id
rm -rf octoprint/basedir/data/astroprint
rm -f octoprint/basedir/data/PrintJobHistory/printJobHistory.db.sql
rm -f octoprint/basedir/data/thespaghettidetective/.tunnel.cj.pickled
rm -f octoprint/basedir/data/appkeys/keys.yaml
rm -f octoprint/basedir/data/SpoolManager/spoolmanager.db.sql
rm -f octoprint/basedir/data/printhistory/history.db.sql
rm -f octoprint/basedir/data/filamentmanager/filament.db.sql
rm -f octoprint/basedir/data/preemptive_cache_config.yaml

for db in $(find octoprint -name "*.db"); do
    sqlite3 "$db" .dump > $db.sql
    rm -f "$db"
done

for json in $(find octoprint -name "*.json"); do
    cat "$json" | jq . > "$json.tmp"
    mv "$json.tmp" "$json"
done

#rm -f octoprint/basedir/data/filamentmanager/filament.db || true
#rm -f octoprint/basedir/data/print || true
