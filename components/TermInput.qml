/*
TerminalStyleLogin - An SDDM theme that looks like a terminal
Copyright (C) 2022 Rea-Klairi Tasopoulou

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import QtQuick 2.15
import QtQuick.Controls 2.15

TextInput {
	id: control
	font.family: config.fontFamily
	font.pointSize: config.fontSize
	color: config.foreground

	width: 500

	cursorDelegate: Label {
		id: cursor
		font.family: config.fontFamily
		font.pointSize: config.fontSize
		color: config.foreground
		text: "▁" // U+2521, lower one eighth block

		Timer {
			running: true
			repeat: true
			interval: 200
			onTriggered: cursor.visible = !cursor.visible && !control.readOnly
		}
	}
}
