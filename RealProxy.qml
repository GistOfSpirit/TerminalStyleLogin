import QtQuick 2.15

Item {
	id: realProxy
	property string hostName: sddm.hostName

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
