
# Invasive Species Classifier 
A mobile application using the machine learning library Tensorflow. 

## About
The goal of this project is to create a mobile application that helps users to do the following: 

 1. Help Identify Invasive Species
 2. Report Invaisve Species to local council
 3. Be more concious of the environment

## Identifying  Invasive Species
The application will contain a clear guide on identifying invasive species. It will include the following: 

 - Pictures of the species 
 - Key features for Identification
 - Tips on how to prevent the spreading of the species
 
 ### Identification using Aritificial Intelligence
 If a user is unsure in the identification of a species they will have the option to use the **Species Classifier**. 
### Species Classifier
The species classifier is a Deep Neural Network running the Google's MobileNet model. [MobileNet](https://arxiv.org/abs/1704.04861) is an efficient convolutional neural networks designed specifically for mobile vision applications.

Transfer Learning using Tensorflow was applied to retrain this model to classify invasive species. 

####  Proccess  of Retrainng the Neural Network 

I used a Google Cloud VM for convenience to retrain this model. Transfer learning does not require extensive CPU/GPU power. Training  a model from scratch however, can take days/weeks on high end GPUs.

#### Setup 
OS: Ubuntu 16.04
HW: Intel Haswell 3CPUs + 10GB RAM

 1. Install Tensorflow. 
Instructions for various OS' can be found [here](https://www.tensorflow.org/install/).
2. Install OpenCV  *I had to also install libsm6*
```cmd
sudo apt-get install python-opencv
sudo apt update && sudo apt install -y libsm6 libxext6
```
3. Install Pip & Dependencies for later use
```cmd
pip install pillow
pip install lxml
pip install jupyter 
pip install matplotlib
```
4. Clone Tensorflow-for-poets  
```git
git clone https://github.com/googlecodelabs/tensorflow-for-poets-2
```
32 IMAGE_SIZE=124 ARCHITECTURE="mobilenet_0.50_${IMAGE_SIZE}"
