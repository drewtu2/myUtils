#Undisort.py
#Created by Chris Rillahan
#Last Updated: 02/04/2016
#Written with Python 2.7.2, OpenCV 3.0.0 and NumPy 1.8.0

#This program takes a video file and removes the camera distortion based on the
#camera calibration parameters.  The filename and the calibration data filenames
#should be changed where appropriate.  Currently, the program is set to search for
#these files in the folder in which this file is located.

#This program first loads the calibration data.  Secondly, the video is loaded and
#the metadata is derived from the file.  The export parameters and file structure
#are then set-up.  The file then loops through each frame from the input video,
#undistorts the frame and then saves the resulting frame into the output video.
#It should be noted that the audio from the input file is not transfered to the
#output file.

from imutils import paths
from os.path import dirname, basename, splitext, exists
from os import makedirs 
import numpy as np
import cv2, time, sys

# Tweaks
folder = 'calib'
folder = 'images/gopro'
width  = 1920
height = 1080
crop = 0.6

# Load Calibration Coefficients
print('Loading data files')
npz_calib_file = np.load('calibration_data.npz')
distCoeff = npz_calib_file['distCoeff']
intrinsic_matrix = npz_calib_file['intrinsic_matrix']
npz_calib_file.close()
print('Finished loading files')
print(' ')


# Undistort Video
print('Starting to undistort the video....')

size = (int(width), int(height))
print(size)
#Initializes the frame counter
start = time.clock()

newMat, ROI = cv2.getOptimalNewCameraMatrix(intrinsic_matrix, distCoeff, size, alpha = crop, centerPrincipalPoint = 1)
mapx, mapy = cv2.initUndistortRectifyMap(intrinsic_matrix, distCoeff, None, newMat, size, m1type = cv2.CV_32FC1)
x,y,w,h = ROI 

for filename in paths.list_images(folder):
    fileBaseName, fileExtension = splitext(filename)
    
    image = cv2.imread(filename)
    dst = cv2.remap(image, mapx, mapy, cv2.INTER_LINEAR)
    #dst = cv2.undistort(image, intrinsic_matrix, distCoeff, None)
    
    # crop the image
    dst = dst[y:y+h, x:x+w]

    outFile = "output/" + fileBaseName + "_undistorted" + fileExtension
    
    if not exists(dirname(outFile)):
        makedirs(dirname(outFile))

    print(outFile)
    cv2.imwrite(outFile, dst)



duration = (time.clock()-float(start))/60

print(' ')
print('Finished undistorting the video')
print('This video took:' + str(duration) + ' minutes')
sys.exit()


