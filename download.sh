#!/bin/bash
#Name: Download
#Description: Download pre-trained tensorflow models and generate protobuff file

# URL for Tensorflow's Model Zoo
model_zoo="https://storage.googleapis.com/download.tensorflow.org/models/tflite/model_zoo"
google_models="https://storage.googleapis.com/download.tensorflow.org/models"

help()
{
   # Display Help
   echo "Download pre-trained tflite model and generates protobuff file"
   echo
   echo "Syntax: download [-h] [squeeze|google|resnet]"
   echo "options:"
   echo "h     Print this Help."
   echo
}

get_model()
{
    dir='./model'
    # Get model and generate protobuff
    mkdir -p model
    wget --directory-prefix='./model' "$1$2"
    tar -xvzf "$dir/$2" -C $dir
    echo "Generating Protobuff"
    xxd -i "$dir/$3.tflite" > src/model_data.cc
}

model_name="squeezenet"
file_name="squeezenet_2018_04_27.tgz"
download_link="https://storage.googleapis.com/download.tensorflow.org/models/tflite/model_zoo/upload_20180427/squeezenet_2018_04_27.tgz"
directory="./model"

result=$(echo "$download_link" | grep -o '[^/]+(?=/$|$)')
echo $result

if [[ -z "$1" ]]
then
   help
   exit
else
    case $1 in
      squeeze)
         echo "Downloading Squeezenet"
         get_model "$model_zoo/upload_20180427/" squeezenet_2018_04_27.tgz squeezenet
         exit
         ;;
      google)
         echo "Downloading Inception V1 (GoogleNet)"
         get_model "$google_models/" inception_v1_224_quant_20181026.tgz inception_v1_224_quant
         exit
         ;;
      resnet)
         echo "Downloading Resnet101 V2"
         get_model "$google_models/tflite_11_05_08/" resnet_v2_101.tgz resnet_v2_101_299
         exit
         ;;
      *)
         echo "Invalid argument: $1; must be [squeeze|google|resnet]"
         help
         exit
         ;;
   esac
fi


while getopts ":h" option; do
   case $option in
      h) # display Help
         help
         exit;;
      g)
   esac
done

mkdir -p model
wget --directory-prefix=$directory $download_link
tar -xvzf "$directory/$file_name" -C $directory
xxd -i "$directory/$model_name.tflite" > src/model_data.cc