import pytest
from ping_monitor.Executor import Executor
from ping_monitor.NetworkNodeListModel import NetworkNodeListModel


@pytest.mark.parametrize("ip, expected_result",
                         [
                            ("127.0.0.0", True),
                            ("localhost", True),
                            ("300.0.0.0", False),
                         ]
                        )
def test_basic_ping(ip: str, expected_result: bool):
    ls_model = NetworkNodeListModel()
    ex = Executor(ls_model)
    result = ex.check_ping(ip)
    assert result == expected_result
