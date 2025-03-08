from PyQt6.QtCore import QAbstractListModel, Qt, QModelIndex, pyqtSlot
from ping_monitor.NetworkNode import NetworkNode
import ping_monitor.Utils as utils

type t_cmds = list[NetworkNode]


class NetworkNodeListModel(QAbstractListModel):
    def __init__(self):
        super().__init__()
        utils.initial_setup()
        self.cmds = utils.json_to_list(utils.NETWORK_NODE_FILE)

    def data(self, index, role):
        if role == Qt.ItemDataRole.DisplayRole:
            return self.cmds[index.row()].name

        if role == Qt.ItemDataRole.UserRole:
            return self.cmds[index.row()].ip

        if role == Qt.ItemDataRole.DecorationRole:
            if self.cmds[index.row()].is_reachable:
                return "Reachable, Last successful ping at: "\
                        + self.cmds[index.row()].addition_info
            else:
                return "Unreachable, Last successful ping at: "\
                        + self.cmds[index.row()].addition_info

        if role == Qt.ItemDataRole.UserRole+1:
            return self.cmds[index.row()].is_reachable

    def rowCount(self, parent=QModelIndex()):
        return len(self.cmds)

    def updateItem(self, index, item):
        self.cmds[index] = item
        self.dataChanged.emit(self.index(index, 0), self.index(index, 0))
        return True

    @pyqtSlot(str, str)
    def add_item(self, host_name: str, host_ip: str):
        self.beginInsertRows(QModelIndex(), len(self.cmds), 0)
        self.cmds.append(NetworkNode(host_ip, host_name))
        self.endInsertRows()
        self.layoutChanged.emit()

    @pyqtSlot(int)
    def remove_item(self, index: int):
        self.beginRemoveRows(QModelIndex(), index, index)
        self.cmds.pop(index)
        self.endRemoveRows()

    @pyqtSlot(dict)
    def update_item(self, item_dict: dict):
        index = item_dict["index"]
        item = item_dict["item"]
        self.updateItem(index, item)

    def roleNames(self):
        RoleNames = {
         Qt.ItemDataRole.DisplayRole: b"name",
         Qt.ItemDataRole.UserRole: b"ip",
         Qt.ItemDataRole.DecorationRole: b"info",
         Qt.ItemDataRole.UserRole+1: b"is_reachable"
        }
        return RoleNames
