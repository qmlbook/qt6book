import QtQuick
import QtQuick.Controls

ApplicationWindow {

    // ...

    visible: true
    width: 640
    height: 480

    title: qsTr("Side-by-side")

    SwipeView {
        id: swipeView
        anchors.fill: parent

        Current {
        }

        UserStats {
        }

        TotalStats {
        }

        // ...

    }

    PageIndicator {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter

        currentIndex: swipeView.currentIndex
        count: swipeView.count
    }

    // ...

}
