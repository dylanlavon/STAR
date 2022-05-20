%%%%%%%%%%%%%%%%%%%%%%%% Configuration Variables %%%%%%%%%%%%%%%%%%%%%%%%%%

% Base video file name. INCLUDE EXTENSION!
baseFileName = '03_16_22_Multispectral_face_8band.mp4';

% Define which colormap to use
cMap = jet; 


%%%%%%%%%%%%%%%%%%%%%%%% CONSTANTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Create a video reader object using the video's file path. 
baseFile = VideoReader(baseFileName);

numBands = str2num(baseFileName(end-8:end-8));
processedImageDirectory = './processedImages/';
tempDirectory = './temp/';
numOfBands = {'1' '2' '4' '8'}';
oneBand = {};
twoBand = {};
fourBand = {};
eightBand = {};
namesOfBands = {oneBand twoBand fourBand eightBand};
tifExt = '.tif';

% Create a variable for the video data
video = read(baseFile);

% Get number of frames from video
numFrames = baseFile.NumFrames;


%%%%%%%%%%%%%%%%%%%%% SLICE AND SAVE TO TEMP FOLDER %%%%%%%%%%%%%%%%%%%%%%%

% Create the temp folder
mkdir temp

% Slice and write each frame as its own tif image
for frame = 1 : numFrames

    % Convert iterator to string
    frameString = num2str(frame);

    % Concatenate the frame number and the file extension
    finalName = append(frameString, tifExt);
    slicedFrame = video(:, :, :, frame);

    % Exporting the frames
    imwrite(slicedFrame, append(tempDirectory, finalName));
end


%%%%%%%%%%%%%%%% PROCESS AND SAVE TO  PROCESSED DIRECTORY %%%%%%%%%%%%%%%%%

% Create timestamp in the format Year-Month_Day Hour.Minute.Second
timestamp = string(datetime("now","Format","MM-dd-yy HH.mm.ss"));

% Create new directory for this run.
mkdir(append('./processedImages/', timestamp));


for imageIndex = 1:numel(dir('./temp/')) - 2 % account for . and .. 
    slicePath = './temp/';
    sliceDir = dir(slicePath);
    sliceDir(1:2) = [];
    name = sliceDir(imageIndex).name;
    basePath = './temp/';

    % Capture each individual quad using their pixel coordinates, then add each
    % quad to the quadCellArray.

    
    baseImg = imread(string(append('./temp/', name)));
    originalBaseName = name(1:end-4);
    quadCellArray = {};
    n=0; % Counter for numbering processedImage files
    

    % Set up numRows and numCols for each amount of bands
    if numBands == 1
        numRows = 1;
        numCols = 1;
    end
    if numBands == 2
        numRows = 1;
        numCols = 2;
    end
    if numBands == 4
        numRows = 1;
        numCols = 4;
    end
    if numBands == 8
        numRows = 2;
        numCols = 4;
    end

    % Calculate additional variables to aid in slicing into quads
    baseImgHeight = numRows * 256;
    baseImgWidth = numCols * 256;
    horSliceIncrement = baseImgWidth / numCols;
    vertSliceIncrement = baseImgHeight / numRows;
    startVert = 1; endVert = vertSliceIncrement; startHor = 1; endHor = horSliceIncrement;

    % Slice each image into quads.
    for i = 1:numRows
        for j = 1:numCols
            quad = baseImg(startVert:endVert,startHor:endHor);
            quadCellArray{end + 1} = quad;
            startHor = startHor + horSliceIncrement;
            endHor = endHor + horSliceIncrement;
        end
        startVert = startVert + vertSliceIncrement;
        endVert = endVert + vertSliceIncrement;
        startHor = 1;
        endHor = horSliceIncrement;
    end

    

    % Check to see if a file already exists with the default name.
    % If so, begin iteratively looking for next possible filename.
    % Save decided file name as finalName.
    % Finish by appending the .tif file extension to the finalName

    strippedName = name(1:end-4);
    originalStrippedName = strippedName;
    
    while isfile(append(processedImageDirectory, timestamp, '/', strippedName, tifExt))
        strippedName = originalStrippedName;
        n= int2str(n+1);
        strippedName = append(strippedName, n);
        n = str2double(n);
    end
    finalName = append(processedImageDirectory, timestamp, '/', strippedName, tifExt);
    
    % Save and append each quadrant to the processedImages folder.      
    for i = 1:numBands
        imwrite(cell2mat(quadCellArray(i)),cMap, finalName, 'WriteMode','append');
    end
end

% Finally, clear the temp folder.
rmdir('temp', 's')

