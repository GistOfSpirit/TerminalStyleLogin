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

import "components"

Rectangle {
	id: terminalArea
	anchors.fill: parent

	color: config.background

	state: "login"

	states: [
		State {
			name: "login"
			PropertyChanges {
				target: loginForm
				visible: true
			}
		},
		State {
			name: "power"
			PropertyChanges {
				target: powerOptions
				visible: true
			}
		},
		State {
			name: "session"
			PropertyChanges {
				target: sessionSelector
				visible: true
			}
		}
	]

	Proxy {
		id: proxy
	}

	Column {
		id: terminalForm
		spacing: 0

		visible: false

		FKeyDesc {
			id: fKeyDesc
		}

		TermLabel {
			text: `${proxy.hostName} sddm\n`
		}

		Login {
			id: loginForm
			visible: false
		}

		PowerOptions {
			id: powerOptions
			visible: false
		}

		SessionSelector {
			id: sessionSelector
			visible: false
		}
	}

	Keys.onPressed: {
		if (terminalArea.state === "login")
		{
			if (event.key === Qt.Key_F1)
			{
				terminalArea.state = "power"
			}
			else if (event.key === Qt.Key_F2)
			{
				terminalArea.state = "session"
			}
		}
		else if (terminalArea.state === "power")
		{
			powerOptions.handleKey(event)
		}
		else if (terminalArea.state === "session")
		{
			sessionSelector.handleKey(event)
		}
	}

	Timer {
		// Initially the hostname didn't appear, giving it some time
		running: true
		repeat: true
		interval: 100
		property int timePassed: 0
		onTriggered: {
			timePassed += interval

			if (
				(proxy.hostName.length > 0)
				|| (timePassed >= 1000)
			)
			{
				terminalForm.visible = true
				setupFKeyDesc()
				stop()
			}
		}
	}

	function setupFKeyDesc()
	{
		fKeyDesc.setup({
			sessionIndex: sessionSelector.selectedIndex
		})
	}

	Connections {
		target: proxy
		function onLoginSucceeded()
		{
			terminalForm.visible = false
		}
	}

	Connections {
		target: loginForm
		function onCredentialsEntered(username, password)
		{
			proxy.login(username, password, sessionSelector.selectedIndex)
		}
	}

	Connections {
		target: powerOptions
		function onCancelled()
		{
			terminalArea.state = "login"
		}
	}

	Connections {
		target: sessionSelector
		function onSelectionMade()
		{
			setupFKeyDesc()
			terminalArea.state = "login"
		}
	}

	MouseArea {
		anchors.fill: parent
		enabled: false
		cursorShape: Qt.BlankCursor
	}
}
