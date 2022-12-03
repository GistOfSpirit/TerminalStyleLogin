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

TermLabel {
	text: ""

	Proxy {
		id: proxy
	}

	property var sessions: []
	property int selectedIndex: sessionModel.lastIndex

	onVisibleChanged: {
		if (visible)
		{
			sessions = []

			const optionCount = Math.min(sessionModel.rowCount(), 9)

			for (let i = 0; i < optionCount; ++i)
			{
				sessions.push({
					index: i,
					key: 0x31 + i, //starting at Qt::Key_1
					text: sessionModel.data(
						sessionModel.index(i, 0),
						Qt.UserRole + 4
					)
				})
			}

			const dispOptions = ["---SESSIONS---"]

			sessions.forEach(
				(o) => dispOptions.push(`${o.index + 1} - ${o.text}`))

			dispOptions.push("Esc - Return to login")

			text = dispOptions.join("\n")
		}
	}

	function handleKey(event)
	{
		if (event.key === Qt.Key_Escape)
		{
			selectionMade()
		}
		else
		{
			for (const sessionData of sessions)
			{
				if (sessionData.key === event.key)
				{
					selectedIndex = sessionData.index
					selectionMade()
					return
				}
			}
		}
	}

	signal selectionMade()
}
