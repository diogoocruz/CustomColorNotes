import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Dialogs 1.2
import MuseScore 3.0

MuseScore {
    description: qsTr("This plugin colors notes in the selection based on pitch according to an external color file.")
    title: "Custom Color Notes"
    categoryCode: "custom-color-notes"

    property variant colors: []
    property string black: "#000000"

    FileDialog {
        id: fileDialog
        title: qsTr("Select Color File")
        nameFilters: ["Text Files (*.txt)", "All Files (*)"]
        
        onAccepted: {
            loadColorsFromFile(fileDialog.fileUrl);
            applyToNotesInSelection(colorNote);
        }

        Component.onCompleted: {
            open(); 
        }
    }

    function loadColorsFromFile(fileUrl) {
        var colorMapping = {}; 

        var file = new XMLHttpRequest();
        file.open("GET", fileUrl, false);
        file.onreadystatechange = function () {
            if (file.readyState === 4 && (file.status === 200 || file.status == 0)) {
                var lines = file.responseText.split('\n');
                for (var i = 0; i < lines.length; i++) {
                    var line = lines[i].trim();
                    if (line) {
                        var parts = line.split(": ");
                        if (parts.length == 2) {
                            var note = parts[0].trim();
                            var color = parts[1].trim();
                            colorMapping[note] = color;
                        }
                    }
                }

                colors = [
                    colorMapping["C"] || black,       // C
                    colorMapping["C#/Db"] || black,   // C#/Db
                    colorMapping["D"] || black,       // D
                    colorMapping["D#/Eb"] || black,   // D#/Eb
                    colorMapping["E"] || black,       // E
                    colorMapping["F"] || black,       // F
                    colorMapping["F#/Gb"] || black,   // F#/Gb
                    colorMapping["G"] || black,       // G
                    colorMapping["G#/Ab"] || black,   // G#/Ab
                    colorMapping["A"] || black,       // A
                    colorMapping["A#/Bb"] || black,   // A#/Bb
                    colorMapping["B"] || black        // B
                ];
            } else {
                console.log("Error: Could not load the colors file.");
            }
        };
        file.send(null);
    }

    function applyToNotesInSelection(func) {
        var fullScore = !curScore.selection.elements.length;
        if (fullScore) {
            cmd("select-all");
        }
        curScore.startCmd();
        for (var i in curScore.selection.elements)
            if (curScore.selection.elements[i].pitch)
                func(curScore.selection.elements[i]);
        curScore.endCmd();
        if (fullScore) {
            cmd("escape");
        }
    }

    function colorNote(note) {
        if (note.color == black)
            note.color = colors[note.pitch % 12];
        else
            note.color = black;

        if (note.accidental) {
            if (note.accidental.color == black)
                note.accidental.color = colors[note.pitch % 12];
            else
                note.accidental.color = black;
        }

        if (note.dots) {
            for (var i = 0; i < note.dots.length; i++) {
                if (note.dots[i]) {
                    if (note.dots[i].color == black)
                        note.dots[i].color = colors[note.pitch % 12];
                    else
                        note.dots[i].color = black;
                }
            }
        }
    }

    onRun: {
        console.log("Running Color Notes Plugin with External Colors File");
        fileDialog.open();
    }
}
