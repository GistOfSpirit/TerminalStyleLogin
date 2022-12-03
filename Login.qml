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

Column {
	id: loginForm
	spacing: 0

	Proxy {
		id: proxy
	}

	Label {
		id: loginFailedLabel
		text: "Login incorrect"

		visible: false

		font.family: "monospace"
		color: "white"
	}

	Row {
		spacing: 0

		Label {
			text: `${proxy.hostName} login: `

			font.family: "monospace"
			color: "white"
		}

		TextInput {
			id: usernameInput

			focus: true

			font.family: "monospace"
			color: "white"
			width: 100

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

		Label {
			text: "Password: "

			font.family: "monospace"
			color: "white"
		}

		TextInput {
			id: passwordInput

			font.family: "Hack"
			color: "white"
			width: 100
			echoMode: TextInput.NoEcho

			text: ""

			onAccepted: {
				passwordInput.readOnly = true
				proxy.login(usernameInput.text, passwordInput.text, sessionModel.lastIndex)
			}
		}
	}

	Timer {
		// Ensuring the input box is always focused, as in a terminal
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
		}
	}

	function setState(state)
	{
		// Using QML states prevented me from affecting only certain objects
		switch (state){
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
}
