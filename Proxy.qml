import QtQuick 2.15

Item {
	property string hostName: "sddm-test"

	function login(user, password, sessionIndex)
	{
		loginFailed()
	}

	signal loginSucceeded()

	signal loginFailed()
}
