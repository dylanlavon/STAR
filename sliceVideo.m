tic


% Create a video reader object using the video's file path
baseFile = VideoReader('video.mp4');
% Create a variable for the video data
video = read(baseFile);

% Get number of frames from video
numFrames = baseFile.NumFrames;

tifExt = '.tif';

% Slice and write each frame as its own tif image
for frame = 1 : numFrames

    % Convert iterator to string
    frameString = num2str(frame);

    % Concatenate the frame number and the file extension
    finalName = append(frameString, tifExt);
    slicedFrame = video(:, :, :, frame);
    cd resultingFrames

    % Exporting the frames
    imwrite(slicedFrame, finalName);
    cd ..
end
    
toc
