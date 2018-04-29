#!/bin/bash
python -m scripts.label_image \
    --graph=/home/jazyface/Neural-Network-Invasive-Species-Classifier-Mobile-App/tensorflow-for-poets-2/tf_files/retrained_graph.pb  \
    --image=/home/jazyface/Neural-Network-Invasive-Species-Classifier-Mobile-App/tensorflow-for-poets-2/tf_files/testjapknotweed.jpg 
