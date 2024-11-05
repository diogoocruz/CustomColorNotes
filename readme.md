# Custom Color Notes

Modification of Color Notes plugin from MuseScore that allows the users to use a custom pallet of colors from an external file.

## Installation
Download the version in [Releases](https://github.com/diogoocruz/CustomColorNotes/releases)
Unzip the files and copy the folder to the plugins folder of MuseScore.
Inside the folder there should be another folder named `templates` with the templates for the colors in hexadecimal format, one per line.
Inside MuseScore go to Plugins > Plugin Manager and enable the plugin.


## How to Use?
Select a note or a group of notes and run the plugin. A window will appear. You should choose a file with the colors (with the format described above) and the colors will be applied to the notes.

## Changing Colors
To change the colors, edit the file `colors.txt` in the plugin folder. The file should contain the colors in hexadecimal format, one per line. You can use the templates provided in the `templates` folder.
You can also use the application [Custom Color Notes Picker](https://customcolornotespicker.streamlit.app/) to pick the colors and generate a file. There's also a few templates on the app.
