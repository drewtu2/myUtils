#!/usr/bin/env python3

#Uses libraries pulsectl and notify2

import notify2
import pulsectl

def name():
    pulse = pulsectl.Pulse()
    server_info = pulse.server_info()
    default_source = pulse.get_source_by_name(server_info.default_source_name)
    state = "🔇" if bool(default_source.mute) else "🎤"
    return "toggle input mute ({})".format(state)

def main():
    pulse = pulsectl.Pulse()
    server_info = pulse.server_info()
    default_source = pulse.get_source_by_name(server_info.default_source_name)
    
    msg = "default src: {}: {}".format(
            default_source.name, 
            "UNmuted" if bool(default_source.mute)  else "MUTED")
    
    pulse.source_mute(default_source.index, not default_source.mute)

    notify2.init('Mute Controller')
    n = notify2.Notification('Mute Source', msg)
    n.show()

if __name__ == '__main__':
    main()
