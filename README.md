# OpenCV library build for esp-idf

This component used to build and include OpenCV library into the esp-idf as a component for esp32, esp32s2 and esp32s3 CPUs.
Now the opencv could be build with IDF version >= 4.4. 
This component was tested with opencv V 4.7.0.

More details about OpenCV can be found [here](https://opencv.org/).
The project has next folders:

opencv - OpenCV source code directory, added as git submodule
opencv_contrib - additional modules for OpenCV, added as git submodule
opencv_patch - folder with patch files for opencv and opencv_contrib
examples - directory with opencv examples running on Esp32-cam board.

## The examples:

feature2d - extraction of 2d features form the camera image.
motion_detection - example detect the motion on the picture from camera and print the coordinates of the object to the console.
object_tracking - track the object located on center of the camera.
people_detection - the example has to detect people on the image.
text_area_detection - detect area on the image where text expected.

