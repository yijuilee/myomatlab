# Copyright (C) 2015  Niklas Rosenstein, MIT License
# Last modified by Yi Jui Lee (August 15 2015)

from __future__ import division
import sys
from sys import exit
import myo
from myo.lowlevel import pose_t, stream_emg
from myo.six import print_
import random
import time

open('Acceleration.txt', 'w').close()
open('Gyroscope.txt','w').close()
open('Orientation.txt', 'w').close()
open('Emg.txt', 'w').close()
open('Pose.txt', 'w').close()

temp = []
with open('PythonVars.txt') as f:
    for val in f:
        temp.append(int(val))

samplerate = temp[0]
t_s = 1/samplerate
print "\n\nSample rate is adjusted to %.0f Hz" % (samplerate)
print "Collecting all data every %.3f seconds" % (t_s)

T = temp[1]
print "\n\nThis program will terminate in %.1f seconds\n" %(T)    

myo.init()
r"""
There can be a lot of output from certain data like acceleration and orientation.
This parameter controls the percent of times that data is shown.
"""

class Listener(myo.DeviceListener):
    # return False from any method to stop the Hub

    def on_connect(self, myo, timestamp):
		print_("Connected to Myo")
		myo.vibrate('short')
		myo.set_stream_emg(stream_emg.enabled)
		myo.request_rssi()
		global start
		global start2
		global start3
		global start4
		start = time.time()
		start2 = time.time()
		start3 = time.time()
		start4 = time.time()
			
    def on_rssi(self, myo, timestamp, rssi):
		print_("RSSI:", rssi)


    def on_event(self, event):
        r""" Called before any of the event callbacks. """

    def on_event_finished(self, event):
        r""" Called after the respective event callbacks have been
        invoked. This method is *always* triggered, even if one of
        the callbacks requested the stop of the Hub. """

    def on_pair(self, myo, timestamp):
        print_('Paired')
        print_("If you don't see any responses to your movements, try re-running the program or making sure the Myo works with Myo Connect (from Thalmic Labs).")
        print_("Double tap enables EMG.")
        print_("Spreading fingers disables EMG.\n")

    def on_disconnect(self, myo, timestamp):
        print_('on_disconnect')

    def on_pose(self, myo, timestamp, pose):
		#print_('on_pose', pose)
		r = 'Pose.txt'
		with open("Pose.txt", "a") as text_file:
			text_file.write("{0}\n".format(pose))

    def on_orientation_data(self, myo, timestamp, orientation):
	r = "Orientation.txt"
        global start
        global t_s
        current = time.time()
        tdiff = current - start
        global t2
        t2 = timestamp
        if 't1' not in globals():
            global t1
            t1 = timestamp
        if tdiff > t_s:
            start = time.time()
            show_output('orientation', orientation, r)

    def on_accelerometor_data(self, myo, timestamp, acceleration):
	r = 'Acceleration.txt'
	global start2
	global t_s
        current2 = time.time()
        tdiff2 = current2 - start2
        if tdiff2 > t_s:
            start2 = time.time()
            #print_(acceleration)
            show_output('acceleration', acceleration, r)

    def on_gyroscope_data(self, myo, timestamp, gyroscope):
        r = 'Gyroscope.txt'
        global start3
        global t_s
        current3 = time.time()
        tdiff3 = current3 - start3
        if tdiff3 > t_s:
            start3 = time.time()
            show_output('gyroscope', gyroscope, r)

    def on_unlock(self, myo, timestamp):
        print_('unlocked')

    def on_lock(self, myo, timestamp):
        print_('locked')

    def on_sync(self, myo, timestamp):
        print_('synced')

    def on_unsync(self, myo, timestamp):
        print_('unsynced')
        
    def on_emg(self, myo, timestamp, emg):
	r = 'Emg.txt'
	global start4
	global t_s
        current4 = time.time()
        tdiff4 = current4 - start4
        if tdiff4 > t_s:
            start4 = time.time()
            show_output('emg', emg, r)

def show_output(message, data, r):
	global t2
	global t1
	if t2 - t1 < (T*1000000): 
		with open(r, "a") as text_file:
			text_file.write("{0}\n".format(data))
	else:  
		exit()


def main():
    hub = myo.Hub()
    hub.set_locking_policy(myo.locking_policy.none)
    hub.run(1000, Listener())

    # Listen to keyboard interrupts and stop the
    # hub in that case.
    try:
        while hub.running:
            myo.time.sleep(0.2)
    except KeyboardInterrupt:
        print_("Quitting ...")
        hub.stop(True)

if __name__ == '__main__':
    main()

