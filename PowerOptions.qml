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

	onVisibleChanged: {
		const options = ["---POWER OPTIONS---"]

		if (proxy.canPowerOff)
		{
			options.push("1 - Power Off")
		}

		if (proxy.canReboot)
		{
			options.push("2 - Reboot")
		}

		if (proxy.canSuspend)
		{
			options.push("3 - Suspend")
		}

		if (proxy.canHibernate)
		{
			options.push("4 - Hibernate")
		}

		if (proxy.canHybridSleep)
		{
			options.push("5 - Hybrid Sleep")
		}

		options.push("Esc - Return to login")

		text = options.join("\n")
	}

	function handleKey(event)
	{
		switch (event.key)
		{
			case Qt.Key_1:
				proxy.powerOff()
				break
			case Qt.Key_2:
				proxy.reboot()
				break
			case Qt.Key_3:
				proxy.suspend()
				break
			case Qt.Key_4:
				proxy.hibernate()
				break
			case Qt.Key_5:
				proxy.hybridSleep()
				break
		}
	}
}
