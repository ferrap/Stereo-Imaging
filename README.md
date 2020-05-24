# Miscellaneous Matlab files for the analyis and capture of stereo images
## CameraGUI.m
CameraGUI creates a Graphical User Interface (GUI) for stereo imaging capture using the [Image Acquisition Toolbox Support Package for Point Grey Hardware](https://uk.mathworks.com/matlabcentral/fileexchange/45178-image-acquisition-toolbox-support-package-for-point-grey-hardware). Thi GUI can be used to capture **synchronised** stereo images from Point Grey Cameras (Flea2 13S2) and it allows to:
- Select cameras adaptor (only tested with IEEE-1394b connector)
- Select the video format (image resolution and bit depth)
- Select cameras Gain, Shutter Speed and Frame Rate
- Select the filename and file directory where to save the image pairs captured
- Select the number and format of the image pairs captured
## Euclidean_distance.m
Euclidean_distance can be used to check the quality of the camera calibration accuracy performed using the [Matlab Stereo Camera Calibrator](https://uk.mathworks.com/help/vision/ug/stereo-camera-calibrator-app.html) by allowing the user to select two set of corresponding points in the image pairs and compute the distance between their 3D reconstructed points and compared that to the known physical object distance.
