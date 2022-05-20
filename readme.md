# Spectral Training and Acquisition Replacement

![star](https://user-images.githubusercontent.com/44561221/169567653-cabdb0d7-2310-4621-a6a9-0b6d004c780f.png)

<hr>

This MATLAB project provides multiple ways to process multispectral data, including:
<ul>
  <li> Processing single 1, 2, 4, and 8 band multispectral images
  <li> Processing single 1, 2, 4, and 8 band multispectral videos
  <li> Slicing single 1, 2, 4, and 8 band multispectral videos into frames for further processing
  <li> Processing multiple directories of 1, 2, 4, and 8 band multispectral images at once
  <li> Capturing and tagging image data, training categories, and predicting images categories based on a <i>Visual Bag of Words</i> algorithm.
</ul>


# Getting Started

### Important Things to Mention

<ul>
  <li> All scripts expect 1024 x 512 px source images/videos to operate as expected. 
  <li> For our testing, we used the MSC2-NIR8-1-A Camera from <a href="https://www.spectraldevices.com/">Spectral Devices</a>.
  <li> Images/Videos captured for use with the <i>processAllDirectories.m, processSingleImage.m, and sliceVideo.m</i> scripts were collected with Spectral Device's <i><a href="https://www.spectraldevices.com/products/2ndlook-camera-software">2nd Look</a></i> software.
  <li> Make sure to delete the <i>___here.txt</i> files in each folder. These were put in place to maintain the folder structure when uploading to GitHub.
</ul>

### MATLAB Version and Required Toolkits
During our development, we used MATLAB R2021B. Using this project with other releases of MATLAB is untested.

The use of this project requires multiple toolkits to function properly. You'll need:
<ul>
  <li><a href="https://www.mathworks.com/products/image-acquisition.html">Image Acquisition Toolbox</a>
  <li><a href="https://www.mathworks.com/products/image.html">Image Processing Toolbox</a>
  <li><a href="https://www.mathworks.com/matlabcentral/fileexchange/76796-image-processing-toolbox-hyperspectral-imaging-library">Image Processing Toolbox - Hyperspectral Library</a>
  <li><a href="https://www.mathworks.com/products/computer-vision.html">Computer Vision Toolbox</a>
  <li><a href="https://www.mathworks.com/products/statistics.html">Statistics and Machine Learning Toolbox</a>
  <li><a href="https://www.mathworks.com/matlabcentral/fileexchange/35684-multipage-tiff-stack?s_tid=srchtitle_multipage%20tiff%20stack_1">Multipage TIFF Stack</a>
</ul>

<hr>

<h2> Using the Basic Image Processing Scripts

<h3> Using <i>processSingleImage.m</i></h3>
  Use this script to process a preexisting 1024x512 px multispectral image and save it as a colormapped multipage TIFF file.
  
  <ol>
    <li> Be sure that your image is the base level directory alongside the scripts and that you follow the correct naming convention presented at the top of the script file. 
    <li> Choose your color map. You can see all available colormap variants <a href="https://www.mathworks.com/help/matlab/ref/colormap.html">here</a>.
    <li> Configure your description settings.
    <li> Once your settings are configured, you are free to run the script. Your resulting image will populate within the <i>processedImages</i> folder.
  </ol>

<h3> Using <i>processSingleVideo.m</i></h3>
  Use this script to process a preexisting 1024x512 px multispectral video and save it as multiple colormapped multipage TIFF files.
  
  <ol>
    <li> Be sure that your video is the base level directory alongside the scripts and that you follow the correct naming convention presented at the top of the script file. 
    <li> Choose your color map. You can see all available colormap variants <a href="https://www.mathworks.com/help/matlab/ref/colormap.html">here</a>.
    <li> Once your settings are configured, you are free to run the script. Your resulting processed frames will populate within the <i>processedImages</i> folder.
  </ol>
  
<h3> Using <i>sliceVideo.m</i></h3>
  Use this script to slice a preexisting 1024x512 px multispectral video and save each frame into the <i>resultingFrames</i> folder.
  
  <ol>
    <li> Be sure that your video is the base level directory alongside the scripts and that you include the file exntension for the <i>video</i> variable. 
    <li> Once your file name is set, you are free to run the script. The resulting frames will populate within the <i>resultingFrames</i> folder.
  </ol>
  
<h3> Using <i>processAllDirectories.m</i></h3>
  Use this script to process all preexisting image files inside the <i>1, 2, 4, and 8</i> folders inside the <i>baseImages</i> folder and save each iamge into the <i>processedImages</i> folder.
  
  <ol>
    <li> Begin by selecting the colormap that you would like to use. You can see all available colormap variants <a href="https://www.mathworks.com/help/matlab/ref/colormap.html">here</a>.
    <li> Make sure that each file is place in the folder corresponding to the correct number of bands inside the <i>baseImages</i> folder.
    <li> Running this script will process every image inside of the <i>baseImages</i> folder and place them in the <i>processedImages</i> folder.
  </ol>
  
  <hr>
  
<h2> Using the Computer Vision & Image Processing Scripts </h2>
  The use of the following scripts must be conducted in order to function properly. Use these scripts capture and tag new data, train categories, and test against the tagged data - all within MATLAB.
  
  <h3>Using <i>CaptureNewTrainingData.mlx</i></h3>
  <ol>
    <li> Start by opening the <i>CaptureNewTrainingData.mlx</i> script. You can adjust the amount of captured frames and frequency of capture by adjusting the <i>nMaxNumberOfFileToWrite</i> and <i>nReportingFrequency</i> variables.
    <li> Further more, you can adjust the tag of the new data by adjusting the <i>sSign</i> variable.
    <li> You can now go ahead and run the script. Repeat this process as many times as you'd like to create more tags to compare to.
  </ol>
  
  <h3>Using <i>TrainEvaluateAndApplyAnImageClassifierExample.mlx</i></h3>
  <ol>
    <li> Next, open the <i>TrainEvaluateAndApplyAnImageClassifierExample.mlx</i> script.
    <li> There are not any variables to edit in this script, so you can go ahead and run it and process the data from the last step.
  </ol>
  
  <h3>Using <i>ShowImageResults.mlx</i></h3>
  <ol>
    <li> Finally, open the <i>ShowImageResults.mlx</i> script.
    <li> The only variable to edit here is <i>maxIterations</i>, which determines how many frames of new data the camera will capture to propose a tag prediction.
    <li> After running the script, you will be presented with a predicted tag.
  </ol>
  
<hr>
  
<h2>Known issues</h2>

<ol>
<li> When capturing data in any of the CV/DL scripts, you may occasionally get an error saying <i>"An exveption occurred. There is no available devices."</i> Start by entering <i>stop</i> in the console to stop video capture from all devices. If that doesn't work, try restarting MATLAB, reconnecting the camera physically, etc.
<li> On higher settings, the image capture of <i>CaptureNewTrainingData.mlx</i> can sometimes skip over frames when capturing.
  </ol>

 <hr>
  
<h2>Credits and other helpful links</h2>
<b>Francisco Delgado, Original CV and Deep Learning Scripts -</b> <a href="https://www.linkedin.com/in/frank-delgado-78759449/">LinkedIn</a>
  
<b>Dylan Britain, Image Processing and Further Development -</b> <a href="https://www.linkedin.com/in/dylan-britain-962046167/">LinkedIn</a>

<b>Demo -</b> <a href="https://www.youtube.com/watch?v=_BO1DY1SMv0">NASA Hybrid Reality Lab YouTube Channel</a> 
