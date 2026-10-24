GAME_NAME="horse-tower"
DIST_NAME="${DIST_NAME:-$GAME_NAME}"

ponies build -t "$TOOLCHAIN" -p release

[ -d "$DIST" ] && rm -r "$DIST"
mkdir -p "$DIST"

# Arguments: $1 = folder name, $2 = extension
function copy_resources() {
    if [[ -d "$1" ]]; then 
        mkdir -p "$DIST/$1"
        find "$1" -maxdepth 1  -name "*.$2" -exec cp {} "$DIST/$1" \;
    else
        echo "no resource directory $1"
    fi
}

copy_resources sound wav
copy_resources sound ogg
copy_resources tex   png
copy_resources fonts ttf
copy_resources level json
copy_resources level tmj

rm -f "$DIST/sound/music.wav"
rm -f "$DIST/sound/music_menu.wav"

rm -f "$DIST/level/test.json"
rm -f "$DIST/level/level_template.json"
rm -f "$DIST/level/level_testing.json"

cp ".build/$TOOLCHAIN-release/game${SRCEXT}" "$DIST/${DIST_NAME}${EXT}"

if [[ "$PLATFORM" == "web" ]]; then
    cp web/index.html      "$DIST"
    cp web/mq_js_bundle.js "$DIST"

    wasm-opt "$DIST/game.wasm" -o "$DIST/game-opt.wasm" -O3
    wc -c "$DIST/game.wasm"
    wc -c "$DIST/game-opt.wasm"
    mv -f "$DIST/game-opt.wasm" "$DIST/game.wasm"
fi

# When manually creating zip files, we can use this, but if we're
# pushing with butler, there's actually no reason to create zips.
#
# rm -f ".build/$PLATFORM.zip"
# (cd $DIST && zip -r "../$PLATFORM.zip" .)