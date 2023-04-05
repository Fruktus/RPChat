# RPChat
[![platform](https://img.shields.io/badge/godot-4.0.1-blue)](https://godotengine.org/)
[![release](https://img.shields.io/github/v/release/Fruktus/RPChat?include_prereleases)](https://github.com/Fruktus/RPChat/releases)
[![GitHub last commit](https://img.shields.io/github/last-commit/Fruktus/RPChat)](https://github.com/Fruktus/RPChat/commits/master)
[![GitHub commit activity](https://img.shields.io/github/commit-activity/m/Fruktus/RPChat)](https://github.com/Fruktus/RPChat/graphs/commit-activity)
[![GitHub closed issues](https://img.shields.io/github/issues-closed-raw/Fruktus/RPChat)](https://github.com/Fruktus/RPChat/issues?q=is%3Aissue+is%3Aclosed)
[![GitHub all releases](https://img.shields.io/github/downloads/Fruktus/RPChat/total)](https://github.com/Fruktus/RPChat/releases)


Client part of RPChat project, server available [here](https://github.com/Fruktus/RPGC-Server). Built with Godot Engine.

## Installation and running
Not yet available.

## RPChat Project
RPChat is a messaging app with heavy emphasis on visual effects and overall immersion, built with role-playing games 
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
