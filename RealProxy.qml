/*
TerminalStyleLogin - An SDDM theme that looks like a terminal
Copyright (C) 2022-2024 Rea Klairi Tasopoulou

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

Item {
	id: realProxy

	property string hostName: sddm.hostName

	property bool canPowerOff: sddm.canPowerOff
	property bool canReboot: sddm.canReboot
	property bool canSuspend: sddm.canSuspend
	property bool canHibernate: sddm.canHibernate
	property bool canHybridSleep: sddm.canHybridSleep

	function powerOff() { sddm.powerOff() }
	function reboot() { sddm.reboot() }
	function suspend() { sddm.suspend() }
	function hibernate() { sddm.hibernate() }
	function hybridSleep() { sddm.hybridSleep() }

	function login(user, password, sessionIndex)
	{
		sddm.login(user, password, sessionIndex)
	}

	signal loginSucceeded()

	signal loginFailed()

	Connections {
		target: sddm

		function onLoginFailed()
		{
			realProxy.loginFailed()
		}

		function onLoginSucceeded()
		{
			realProxy.loginSucceeded()
		}
	}
}
