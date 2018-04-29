
# Invasive Species Classifier 
A mobile application using Tensorflow and [MobileNet](https://arxiv.org/abs/1704.04861) . MobileNet is an efficient convolutional neural network designed specifically for mobile vision applications. Tensorflow is an opensource machine learning library. 

## About
The goal of this project is to create a mobile application that helps users to do the following: 

 1.  Identify Invasive Species
 2. Report Invaisve Species to local council
 3. Be more concious of the environment


##  Neural Network
The neural network model I chose to use for this app is  MobileNet by Google. MobileNets are designed to effectively maximize accuracy while being mindful of the restricted resources for an on-device or embedded application. MobileNets are small, low-latency, low-power models parameterized to meet the resource constraints of a variety of use cases. They can be built upon for classification, which is exactly what I chose to do. 

*Resource : https://research.googleblog.com/2017/06/mobilenets-open-source-models-for.html*


## Identifying  Invasive Species
The application will contain a clear guide on identifying invasive species. It will include the following: 

 - Pictures of the species 
 - Key features for Identification
 - Tips on how to prevent the spreading of the species
 
 ### Identification using Aritificial Intelligence
 If a user is unsure in the identification of a species they will have the option to use the **Species Classifier**. 
### Species Classifier
The species classifier is a Deep Neural Network running Google's MobileNet model. Transfer Learning using Tensorflow was applied to retrain this model to classify invasive species. 

##  Developer Instructions for Creating your own custom Classifier

I used a Google Cloud VM for convenience to retrain this model. Transfer learning does not require extensive CPU/GPU power. Training a model from scratch however, can take days/weeks on high end GPUs.

You can following instructions here or for a more comprehensive guide by Google - [here](https://codelabs.developers.google.com/codelabs/tensorflow-for-poets-2/#1).

## Custom Data Set Creation
The quickest way I have found to create a data set of images for classification is by grabbing images from the web.  For this project, I used the Bing Images API. You could alternateively scrape images frome Google Images, however it's a manual & overall pretty tedious job. 

The cleanest solution is Bing's Image API.  

#### 1. Create an account & get yout API Key
This is the website [link](https://azure.microsoft.com/en-us/try/cognitive-services/?api=bing-image-search-api ).

Once you have your API key, create a folder named after what types of obejct you are classifying : 
```bash
mkdir plant_photos
```

Within that folder create a directory for each class of object you are classifying
```bash
mkdir japanese_knotweed
mkdir giant_rhubarb
```

Your directory structure should be as follows:
```bash
~/ -- plant_photos
		  |___ japanese_knotweed
		  |___ giant_rhubarb
```

Open the search_bing.py script & enter your API key  & number of images you wish to download. 
```python
# set your Microsoft Cognitive Services API key along with (1) the
# maximum number of results for a given search and (2) the group size
# for results (maximum of 50 per request)

API_KEY  =  "YOUR_API_KEY_GOES_HERE"

MAX_RESULTS  =  "NUMBER_OF_IMAGES_YOU_WANT_TO_DOWNLOAD"

GROUP_SIZE  =  50 
```
This is a really neat script created by Adrain from www.pyimagesearch.com. Every image is opened using OpenCV to ensure the image is not corrupt/broken. 

Run the script with your query *(what you want to search for & download)*: 
```bash
python search_bing_api.py  --query  "japanese knotweed"  --output plant_photos/japanese_knotweed
```
And Voilá! You should have a shiny new collection of images. 


*Resource & Script from : https://www.pyimagesearch.com/2018/04/09/how-to-quickly-build-a-deep-learning-image-dataset/*

####  Pruning your newly created image dataset
This is the only tedious part of the dataset creation process. Open up your folder of images downloaded using a file explorer. Delete any images Bing downloaded that don't quite fit into your class (I only had to delete 40 out of 1000 downloaded). Dependeding on the number of images downloaded/popularity & clarity of your search query, you may have to spend more/less time pruning your dataset. 

## Setup 

> OS: Ubuntu 16.04 HW: Intel Haswell 3CPUs + 10GB RAM

#### 1. Install Tensorflow. 
Instructions for various OS' can be found [here](https://www.tensorflow.org/install/).
#### 2. Install OpenCV  *I had to also install libsm6*
```bash
sudo apt-get install python-opencv
sudo apt update && sudo apt install -y libsm6 libxext6
```
#### 3. Install Pip & Dependencies for later use
```bash
pip install pillow
pip install lxml
pip install jupyter 
pip install matplotlib
```
#### 4. Clone Tensorflow-for-poets  
```bash
git clone https://github.com/googlecodelabs/tensorflow-for-poets-2
```

#### 5. Set environment variables
 ```git
IMAGE_SIZE=124
 ARCHITECTURE="mobilenet_0.50_${IMAGE_SIZE}"
 ```
#### 6. Training the Neural Network using you data set
Move your dataset of images into the  tf_files directory:
 tensorflow-for-poet/tf_files 
 ```bash
  mv ~/plant_photos ~/your-project-repo/tensorflow-for-poets-2/tf_files/
 ```

Run the retraining script making sure the --image_dir paramtere points to your images folder
 ```bash
  --image_dir=tf_files/plant_photos 
 ```


 ```bash
python -m scripts.retrain \
  --bottleneck_dir=tf_files/bottlenecks \
  --how_many_training_steps=1500 \
  --model_dir=tf_files/models/ \
  --summaries_dir=tf_files/training_summaries/"${ARCHITECTURE}" \
  --output_graph=tf_files/retrained_graph.pb \
  --output_labels=tf_files/retrained_labels.txt \
  --architecture="${ARCHITECTURE}" \
  --image_dir=tf_files/plant_photos 
 ```
If you're interested in tweaking your model, check out all the parameters & what they do by running:
 ```bash
python -m scripts.retrain -h
 ```
#### 7. Test your classifier 
You can test your classifier by feeding it a sample image and viewing the accuracy. 
 ```bash
python -m scripts.label_image \
    --graph=tf_files/retrained_graph.pb  \
    --image=you_sample_image.jpg
 ```
