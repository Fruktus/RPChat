# RPGC-Client [![version](https://img.shields.io/badge/version-pre--alpha-red)]()
Client part of RPGChat project, server available [here](https://github.com/Fruktus/RPGC-Server). Built with Godot Engine.

## Installation and running
Not yet available.

## RPGChat Project
RPGChat is a messaging app with heavy emphasis on visual effects and overall immersion, built with role-playing games 
and visual novels in mind.

### Goals
- A central server, p2p and offline replay functions
- Support for standard file formats in messages:
	- pictures
	- gifs
	- music, shown when needed or stopped
	- videos
	and possibility to use them when needed, for example the music can start playing in the middle of the message or when someone joins

- Possibility to create presets, which will contain text effects:
    - speed of text (final fantasy character by character printing)
    - color
    - font size, type
    - color bleed
    - text glitching
    - tearing
    - sound effects like chirping voice (different modes, sounds), explosions, shakes, etc

- whisper: command to talk to player privately, may show to other present players as player1 whispers to player2 if desired

- special effects like window shake, bleed out of the window etc

- all of the possible actions will be available as simple scripting (styling) language:
    - ex: \{\{tfx: type s: slow vfx: p1}} Jon: You shouldn't have called \{\{bg: dark_red}}
    - result: all text types letter by letter slowly with voice effect p1, at the end the background changes

- gui option to highlight part of the text and select the effects you want on it, maybe with checkboxes (WYSIWYG)
