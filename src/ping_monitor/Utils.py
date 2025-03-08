import os
import json
from typing import List
from ping_monitor.NetworkNode import NetworkNode


USER_HOME_DIR = os.path.expanduser("~")
APP_DIR = USER_HOME_DIR + os.path.sep + ".ping_monitor"
NETWORK_NODE_FILE = APP_DIR + os.path.sep + "default.json"


def json_to_list(file):
    with open(file, "r") as file:
        hosts = json.load(file)
        node_list = []
        for host in hosts:
            node_list.append(NetworkNode(host["ip"], host["name"]))
    return node_list


def initial_setup():
    if not os.path.exists(APP_DIR):
        os.makedirs(APP_DIR)

    if not os.path.exists(NETWORK_NODE_FILE):
        with open(NETWORK_NODE_FILE, "w") as f:
            local_host = [{
                "name": "Localhost",
                "ip": "127.0.0.1"
            }]
            json.dump(local_host, f, indent=4)


def closing_handler(list: List[NetworkNode]):
    with open(NETWORK_NODE_FILE, "w") as f:
        node_list = []
        for node in list:
            node_list.append({"name": node.name, "ip": node.ip})
        json.dump(node_list, f, indent=4)
