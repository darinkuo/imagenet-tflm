# Tensorflow Lite for Microcontrollers Squeezenet

Tensorflow lite for microcontrollers for SqueezeNet.

###  Getting the sources
This repository uses submodules. You need the --recursive option to fetch the submodules automatically

    $ git clone --recursive https://github.com/darinkuo/imagenet-tflm.git

Run the download.sh script to download the associated tflite model and convert the script to the flatbuffer model. You will need to edit the model variables in model_data.h header and main_function.cc to fit the downloaded model.

To Do List
* Add third-party libraries to preprocess the ImageNet dataset
* Add Alexnet to download.sh (after finding tensorflow model)