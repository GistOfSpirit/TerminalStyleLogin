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

Column {
	id: loginForm
	spacing: 0

	Proxy {
		id: proxy
	}

	TermLabel {
		id: loginFailedLabel
		text: "Login incorrect"

		visible: false
	}

	Row {
		spacing: 0

		TermLabel {
			text: `${proxy.hostName} login: `
		}

		TermInput {
			id: usernameInput

			focus: true

			text: ""

			onAccepted: {
				loginForm.setState("password")
			}
		}
	}

	Row {
		id: passwordRow
		spacing: 0

		visible: false

		TermLabel {
			text: "Password: "
		}

		TermInput {
			id: passwordInput

			echoMode: TextInput.NoEcho
			text: ""

			onAccepted: {
				passwordInput.readOnly = true
				credentialsEntered(usernameInput.text, passwordInput.text)
			}
		}
	}

	Timer {
		// Ensuring the input box is always focused, as in a terminal.
		// If neither box visible, ensure they DON'T have focus
		// to prevent typing
		running: true
		repeat: true
		interval: 100
		onTriggered: {
			if (passwordInput.visible)
			{
				passwordInput.forceActiveFocus()
			}
			else if(usernameInput.visible)
			{
				usernameInput.forceActiveFocus()
			}
			else
			{
				loginForm.forceActiveFocus()
			}
		}
	}

	function setState(state)
	{
		// Using QML states prevented me from affecting only certain objects
		switch (state) {
			case "loginFailed":
			loginFailedLabel.visible = true
			//fallthrough

			case "username":
			loginForm.visible = true
			passwordRow.visible = false
			usernameInput.readOnly = false
			usernameInput.text = ""
			break

			case "password":
			loginForm.visible = true
			passwordRow.visible = true
			usernameInput.readOnly = true
			passwordInput.readOnly = false
			passwordInput.text = ""
			break
		}
	}

	Connections {
		target: proxy
		function onLoginFailed()
		{
			loginForm.setState("loginFailed")
		}
	}

	Connections {
		target: Qt.inputMethod
		function onVisibleChanged()
		{
			// Prevent virtual keyboard from showing
			Qt.inputMethod.hide()
		}
	}

	signal credentialsEntered(string username, string password)
}
