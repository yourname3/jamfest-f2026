ITCH_USER=some-games-by-bee
ITCH_GAME=case-of-the-haunted-carrots

butler push .build/web-dist     "$ITCH_USER/$ITCH_GAME:web-jam"
butler push .build/windows-dist "$ITCH_USER/$ITCH_GAME:windows-jam"
#butler push .build/linux-dist   "$ITCH_USER/$ITCH_GAME:linux-jam"
