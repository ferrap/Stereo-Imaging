%This script allows to pick up points (you must take the same) on the image pair and then calculate the
%distance between them
cam1 = uigetfile('*', 'Select Camera 1 Image')
imshow(cam1)
[x y] = ginput(2)%2 is the number of points
x_first_camera = vertcat(x',y')'

cam2 = uigetfile('*', 'Select Camera 2 Image');
imshow(cam2)
[x y] = ginput(2)%2 is the number of points
x_second_camera = vertcat(x',y')'

%Compute the Euclidean distance in 3-D after having found the value(s) of
%Xc_1_left (Xc_1_right) from the stereo_triangulation function present
%within the Bouguet Toolbox

% load('Calib_Results_stereo.mat')
% [Xc_1_left,Xc_1_right] = stereo_triangulation(x_first_camera,x_second_camera,om,T,fc_left,cc_left,kc_left,alpha_c_left,fc_right,cc_right,kc_right,alpha_c_right)

%Load the Calibration mat file obtained from Stereo Camera Calibrator
load('calibrationSession.mat')

%Reconstruct 3D cordinates of the corresponding points
X_world = triangulate(x_first_camera,x_second_camera,calibrationSession.CameraParameters)';

X = cell(size(X_world,2),1);
Y = cell(size(X_world,2),1);
Z = cell(size(X_world,2),1);

for n = 1:size(X_world,2);

    X{n,1} = X_world(1,n);
    Y{n,1} = X_world(2,n);
    Z{n,1} = X_world(3,n);

end

distance = cell(size(X_world,2)-1,1);
% distance computes the euclidean distance which can be compared to the
% known physical object distance
for i = 1:size(X_world,2)-1;
    
    distance{i,1} = sqrt((X{i+1} - X{i})^2 + (Y{i+1} - Y{i})^2 + (Z{i+1} -Z{i})^2)
    
end 
close all