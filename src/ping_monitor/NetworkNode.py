from datetime import datetime
from typing import Optional


class NetworkNode:
    def __init__(self, ip: str, name: Optional[str] = None) -> None:
        self.ip = ip
        self.name = ip if name is None else name
        self.is_reachable = False
        self.mac_address = ""
        self.history = []
        self.last_success_time = datetime.now()
        self.addition_info: str = "Never"

    def __str__(self) -> str:
        return f"Name: {self.name:<20},\
                 IP: {self.ip:<20},\
                 Is reachable: {self.is_reachable: <20},\
                 Last success time: {self.last_success_time},\
                 Addition info: {self.addition_info}"
