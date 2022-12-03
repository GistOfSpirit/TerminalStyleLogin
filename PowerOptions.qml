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
	TermLabel {
		id: listLabel
		text: ""
	}

	TermLabel {
		id: confirmLabel
		visible: false
	}

	Proxy {
		id: proxy
	}

	property var options: []
	property var selection: undefined

	states: [
		State {
			name: "confirm"
			when: selection !== undefined
			PropertyChanges {
				target: confirmLabel
				text: `\nConfirm ${selection.text}? (y/n)`
				visible: true
			}
		}
	]

	onVisibleChanged: {
		if (visible)
		{
			options = []

			if (proxy.canPowerOff)
			{
				options.push({
					key: Qt.Key_1,
					number: 1,
					text: "Power Off",
					action: proxy.powerOff
				})
			}

			if (proxy.canReboot)
			{
				options.push({
					key: Qt.Key_2,
					number: 2,
					text: "Reboot",
					action: proxy.reboot
				})
			}

			if (proxy.canSuspend)
			{
				options.push({
					key: Qt.Key_3,
					number: 3,
					text: "Suspend",
					action: proxy.suspend
				})
			}

			if (proxy.canHibernate)
			{
				options.push({
					key: Qt.Key_4,
					number: 4,
					text: "Hibernate",
					action: proxy.hibernate
				})
			}

			if (proxy.canHybridSleep)
			{
				options.push({
					key: Qt.Key_5,
					number: 5,
					text: "Hybrid Sleep",
					action: proxy.hybridSleep
				})
			}

			const dispOptions = ["---POWER OPTIONS---"]

			options.forEach((o) => dispOptions.push(`${o.number} - ${o.text}`))

			dispOptions.push("Esc - Return to login")

			listLabel.text = dispOptions.join("\n")
		}
	}

	function handleKey(event)
	{
		if (state !== "confirm")
		{
			if (event.key === Qt.Key_Escape)
			{
				cancelled()
			}
			else
			{
				for (const option of options)
				{
					if (option.key === event.key)
					{
						selection = option
						return
					}
				}
			}
		}
		else
		{
			if (event.key === Qt.Key_Y)
			{
				selection.action()
			}
			else if (event.key === Qt.Key_N)
			{
				selection = undefined
			}
		}
	}

	signal cancelled()
}
