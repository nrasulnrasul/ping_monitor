from PyQt6.QtCore import QTimer, QObject
from datetime import datetime
import subprocess as sp


class Executor(QObject):
    """
    Executor class to periodically execute a task using a QTimer.

    Attributes:
        interval (int): The interval in milliseconds for the timer.

    Methods:
        start():
            Starts the timer.
        stop():
            Stops the timer.
        do_work():
            Executes the task for each item in the model.
        check_ping(host):
            Checks the reachability of a host using the ping command.
    """
    def __init__(self, ls_model, interval: int = 5000) -> None:
        super().__init__()
        self.ls_model = ls_model
        self.interval = interval

        self.timer = QTimer(self)
        self.timer.setInterval(self.interval)
        self.timer.timeout.connect(self.do_work)

    def start(self):
        self.timer.start()

    def stop(self):
        self.timer.stop()

    def do_work(self):
        for index in range(self.ls_model.rowCount()):

            item = self.ls_model.cmds[index]
            result = self.check_ping(item.ip)

            if result:
                item.is_reachable = True
                item.last_success_time = datetime.now().strftime(
                    "%H:%M:%S on %d-%m-%Y")
                item.addition_info = item.last_success_time

            else:
                item.is_reachable = False

            self.ls_model.dataChanged.emit(self.ls_model.index(index, 0),
                                           self.ls_model.index(index, 0))

    def check_ping(self, host):
        p = sp.Popen(["ping", host, "-c", "1", "-W", "1", "-s", "1"],
                     stdout=sp.PIPE, stderr=sp.PIPE, text=True)
        stdout, stderr = p.communicate()

        if p.returncode:
            return False
        else:
            return True
