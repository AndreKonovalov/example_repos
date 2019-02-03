import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id: oView

    state: "appsView"
    onVisibleChanged: { if (visible) state = "appsView"; }

    AppName {
        id: oAppName
        onShowSignIn: oView.state = "signInView"
        onShowSignUp: oView.state = "signUpView"
        onShowProjects: oView.state = "showProjects"
    }
    SignIn {
        id: oSignIn
        onExit: { console.log('si: ' + o1text + ' ' + o3text); oView.state = "appsView"; }
    }
//    SignUp {
//        id: oSignUp
//        onExit: oView.state = "appsView"
//    }
    RequestList {
        id: oList
        onExit: oView.state = "appsView"
        onAdd: {
            oRequest.show(listModel, true)
            oView.state = "showRequestEdit"
        }
    }
    RequestEdit {
        id: oRequest
        onExit: oView.state = "showProjects"
    }

    states: [
        State {
            name: "appsView"
            PropertyChanges { target: oAppName; visible: { console.log('appsView'); true; } }
        },
        State {
            name: "signInView"
            PropertyChanges { target: oSignIn; visible: true }
        },
//        State {
//            name: "signUpView"
//            PropertyChanges { target: oSignUp; visible: true }
//        },
        State {
            name: "showProjects"
            PropertyChanges { target: oList; visible: true }
        },
        State {
            name: "showRequestEdit"
            PropertyChanges { target: oRequest; visible: true }
        }
    ]
}

