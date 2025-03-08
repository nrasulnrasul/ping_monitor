import sys
from PyQt6.QtCore import QUrl, QThread
from PyQt6.QtGui import QGuiApplication
from PyQt6.QtQml import QQmlApplicationEngine

from ping_monitor.NetworkNodeListModel import NetworkNodeListModel
from ping_monitor.Executor import Executor
from ping_monitor import Utils


def main():
    app = QGuiApplication(sys.argv)
    ls_model = NetworkNodeListModel()

    executor = Executor(ls_model, interval=1000)
    executor_thread = QThread()

    executor.moveToThread(executor_thread)
    executor_thread.started.connect(executor.start)

    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("executor", executor)
    engine.rootContext().setContextProperty("ls_model", ls_model)
    engine.load(QUrl.fromLocalFile("resources/qml/Main.qml"))
    executor_thread.start()

    # stop the timer
    app.aboutToQuit.connect(executor.stop)
    # stop the QThread
    app.aboutToQuit.connect(executor_thread.exit)
    # Write current nodes in list to json
    app.aboutToQuit.connect(lambda: Utils.closing_handler(ls_model.cmds))
    sys.exit(app.exec())


if __name__ == "__main__":
    main()
