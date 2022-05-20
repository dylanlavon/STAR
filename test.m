baseImgPath = './baseImages/8/01_03_22_Multispectral_face_8Band.tif';
baseImg = imread(baseImgPath);



band1 = baseImg(1:256,1:256);
band2 = baseImg(1:256,257:512);
band3 = baseImg(1:256,513:768);
band4 = baseImg(1:256,769:1024);
band5 = baseImg(257:512,1:256);
band6 = baseImg(257:512,257:512);
band7 = baseImg(257:512,513:768);
band8 = baseImg(257:512,769:1024);

cube = cat(3,band1,band2,band3,band4,band5,band6,band7,band8);
imwrite(cube,'cube', fmt, Tiff)