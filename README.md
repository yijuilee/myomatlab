# myomatlab

Myo MATLAB Data Streaming Interface. Version 1 (August 15, 2015)

Tested on Window 7, Windows 8

MATLAB 2013a, Python 2.7.9, myo-sdk-win-0.9.0

This is the simplified source code for the Myo Sphero MATLAB Interface (https://www.youtube.com/watch?v=E3m9V6yv0do)

The Myo MATLAB data streaming interface relies on real time data read from the text files updated by Python. Python is used to communicate with Myo Connect/Myo. Special thanks to NiklasRosenstein and the contributors to the Python interface (https://github.com/NiklasRosenstein/myo-python).

1.	Download Python 2.7.9 (Other version of Python have not been tested for the interface).
2.	Make sure to check include Python in your path during the installation.
3.	Download Myo Connect.
4.	Please follow the steps prompted on Myo Connect if Myo is not added to the application.
5.	Run the Myo interface (Refer to myo_workfile.m for the working examples and Myo.m for the source).

Important note:
- This version is tested on Python 2.7. If other versions of Python were used or the Python directory is installed in a custom directory, please update the python.m code in line 63 to match the appropriate directory of Python in your drive. (Other Python versions has not been tested for this interface.)
- Please ensure that Myo Connect is on and running while the interface is running.
- As of this version (Version 1), the MATLAB function, pyquit terminates all existing Python processes. 
