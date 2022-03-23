#!/usr/bin/env python3

#Uses libraries python-rofi and pulsectl

from rofi import Rofi
import rofi_audio_set_default_sink as set_sink
import rofi_audio_set_default_source as set_source
import rofi_audio_set_bluetooth_profile as set_bt
import sys
import time

OPTIONS = ["sink", "source", "bluetooth"]

def run(index: str, rofi: Rofi):
    time.sleep(0.1)
    if index == 0:
        set_sink.main()
    elif index == 1:
        set_source.main()
    elif index == 2:
        set_bt.main()
    else:
        rofi.error("There was a problem with {}".format(OPTIONS[index]))

def main():
    rofi = Rofi()
    
    index, key = rofi.select("Audio: ", OPTIONS, select=0)
    if index == -1: 
        return
    
    run(index, rofi)

if __name__ == '__main__':
    main()
