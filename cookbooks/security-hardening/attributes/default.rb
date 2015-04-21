default["authorization"]["sudo"]["groups"] = [ "wheel","fspadmin"]
default["authorization"]["sudo"]["users"]  = [ "fspadmin"]

default["authorization"]["firewall"]["ip_allow"] = ["182.72.224.130","115.254.92.121","141.138.14.186"]
default["authorization"]["firewall"]["ip_deny"] = ["0.0.0.0"]
default["authorization"]["firewall"]["ports"] = ["80","443","3306","8891","3690"]