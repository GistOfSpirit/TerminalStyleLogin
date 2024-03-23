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
	property string hostName: "sddm-test"

	property bool canPowerOff: true
	property bool canReboot: true
	property bool canSuspend: true
	property bool canHibernate: true
	property bool canHybridSleep: true

	function login(user, password, sessionIndex)
	{
		console.log("Failing, test mode")
		loginFailed()
	}

	function powerOff()
	{
		console.log("Powering off")
	}

	function reboot()
	{
		console.log("Rebooting")
	}

	function suspend()
	{
		console.log("Suspending")
	}

	function hibernate()
	{
		console.log("Hibernating")
	}

	function hybridSleep()
	{
		console.log("Hybrid sleeping")
	}

	signal loginSucceeded()

	signal loginFailed()
}
