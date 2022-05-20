%%%%%%%%%%%%%%%%%%%%%%%% Configuration Variables %%%%%%%%%%%%%%%%%%%%%%%%%%

% Ensure that this file path matches the file you want to process.
% Do not add the .tif file extension.
% Be sure to follow the naming convention of
% month_day_year_Project_subject_numOfBand.
baseImgName = '01_03_22_Multispectral_penbox_8Band'; 
 
% Define which colormap to use
cMap = jet;             

% Description variables
addDesc = false;           % Displays Band # and frequency on each quadrant
descFontSize = 10;         % Description font size


%%%%%%%%%%%%%%%%%%%%%%%% CONSTANTS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

numBands = str2num(baseImgName(end-4:end-4));

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

baseImageDirectory = append('./baseImages/', int2str(numBands), '/');
processedImageDirectory = './processedImages/';

tifExt = '.tif';
baseImgHeight = numRows * 256;           % In pixels, not including blank space
baseImgWidth = numCols * 256;           % In pixels, not including blank space

baseImg = imread(append(baseImageDirectory, baseImgName, tifExt));

descX = 11;
descY = 11;
bandCounter = 1;
horSliceIncrement = baseImgWidth / numCols;
vertSliceIncrement = baseImgHeight / numRows;


options.append = true;

% Description text band frequencies
bands = {'720nm' '760nm' '805nm' '830nm' '870nm' '905nm' '940nm' '980nm'};


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n=0; % Counter for numbering processedImage files
quadCellArray = {};
startVert = 1; endVert = vertSliceIncrement; startHor = 1; endHor = horSliceIncrement;
originalBaseName = baseImgName;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Insert description text for each quad
if addDesc
    for i = 1:numRows
        for j = 1:numCols
            baseImg = insertText(baseImg, [descX descY], append('Band ', int2str(bandCounter) ,' @ ', bands(bandCounter)), 'FontSize', descFontSize, BoxOpacity=0, TextColor='white');
            descX = descX + horSliceIncrement;
            bandCounter = bandCounter + 1;
        end
        descY = descY + vertSliceIncrement;
        endVert = endVert + vertSliceIncrement;
        descX = 11;
    end
end

% Reset values to prepare for next loop.
startVert = 1; endVert = vertSliceIncrement; startHor = 1; endHor = horSliceIncrement; 


% Capture each individual quad using their pixel coordinates, then add each
% quad to the quadCellArray.

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

while isfile(append(processedImageDirectory, baseImgName, tifExt))
    baseImgName = originalBaseName;
    n= int2str(n+1);
    baseImgName = append(baseImgName, n);
    n = str2double(n);
end
finalName = append(processedImageDirectory, baseImgName, tifExt);

% Save and append each quadrant to the processedImage.tif file.
% Allows for viewing in sliceViewer()

for i = 1:numBands
    imwrite(cell2mat(quadCellArray(i)),cMap, finalName, 'WriteMode','append');
end


% Load in processedImage.tif as result, then load the figure window,
% and subsequently view slices. Finally, apply selected colormap.

result = loadtiff(finalName);
figure('Name',append(baseImgName, tifExt),'NumberTitle','off')

if numBands == 1
    imshow(result, "Colormap", cMap)
end

if numBands ~= 1
    sliceViewer(result, "Colormap",cMap);
end
