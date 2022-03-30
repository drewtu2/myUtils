#!/usr/bin/env python3

#Uses libraries python-rofi and pulsectl

import notify2
from rofi import Rofi
import rofi_audio_set_default_sink as set_sink
import rofi_audio_set_default_source as set_source
import rofi_audio_set_bluetooth_profile as set_bt
import rofi_audio_toggle_mute as input_mute
import sys
import time

def get_options():
    return [input_mute.name(), set_sink.name(), set_source.name(), set_bt.name()]

def run(index: str, rofi: Rofi):
    time.sleep(0.1)
    try:
        if index == 0:
            input_mute.main()
        elif index == 1:
            set_sink.main()
        elif index == 2:
            set_source.main()
        elif index == 3:
            set_bt.main()
        else:
            rofi.error("There was a problem with {}".format(OPTIONS[index]))
    except Exception as e:
        notify2.init('Audio Rofi')
        n = notify2.Notification('Audio Rofi Error', "an error occurred...")
        n.show()
        rofi.error("An error occured: {}".format(e.what()))

def main():
    rofi = Rofi()
    
    index, key = rofi.select("Audio: ", get_options(), select=0)
    if index == -1: 
        return
    
    run(index, rofi)

if __name__ == '__main__':
    main()
