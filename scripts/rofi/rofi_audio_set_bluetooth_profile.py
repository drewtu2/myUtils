#!/usr/bin/env python3
# Taken from https://gist.github.com/smoser/46bc23907a0f4db00a41088d912386dd

#Uses libraries python-rofi and pulsectl

from rofi import Rofi
import pulsectl, sys


def main():
    smap = {'a2dp': 'a2dp_sink', 'headset': 'headset_head_unit', 'off': 'off'}
  
    rofi = Rofi()

    with pulsectl.Pulse('local-smoser-pulse') as pulse:
        devs = [d for d in pulse.card_list() if
                d.name.startswith('bluez')]
        
        if len(devs) == 0:
            status = "No bluetooth devices?\n"
            sys.stderr.write(status)
            rofi.error(status)
            index = -1
        elif len(devs) > 1:
            sys.stderr.write("Too many matches: %s\n" % devs)
            for d in devs:
                sys.stderr.write(
                    "%s %s\n" % (d.name, d.proplist['device.description']))
            index, _ = rofi.select("Select default sink", smap.keys(), select=1)
        else:
            index == 0

        if index == -1:
            return

        headset = devs[index]

        #for prof in headset.profile_list:
        #    print("%s: %s" % (prof.name, prof.description))

        index, _ = rofi.select("Select default sink", smap.keys(), select=1)
        if index == -1:
          return

        profile_mode = smap.keys()[index]

        print("Setting %s [%s] to %s" % (headset.proplist['device.description'], 
            headset.name, profile_mode))
        try:
            pulse.card_profile_set(headset, smap[profile_mode])
        except pulsectl.PulseOperationFailed as e:
            status = "Failed to set %s on %s: %s" % (profile_mode, 
                    headset.proplist['device.description'], e)
            print(status)
            rofi.error(status)
            if profile_mode == 'a2dp':
                print("Push the button on the headset!")
            sys.exit(1)
        sys.exit(0)

if __name__ == '__main__':
  main()
