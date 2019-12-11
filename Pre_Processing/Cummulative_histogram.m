function [image_1,image_2]=Cummulative_histogram(im1,im2)
I1=(im1);
NumPixel = compute_histogram(I1,'Histogram of Original Image',2);
% ProbPixel is the probability of an occurrence of each gray level
ProbPixel = compute_normalized_histogram(NumPixel,I1,'Normalized Histogram of Original Image',3);
% Cumupixel is the cumulative distribution function
CumuPixel = compute_cumulative_histogram(ProbPixel,'Cumulative Histogram of Original Image',4);

% The Cumupixel convert to new gray levels
Map = zeros(1,256);
for i = 1:256
    Map(i) = uint8(255 * CumuPixel(i)+0.5);
end
for i = 1:size(I1,1)
    for j = size(I1,2)
        I1(i,j)=Map(I1(i,j) + 1);
    end
end

I2=(im2);

NumPixel = compute_histogram(I2,'Histogram of Original Image',2);
% ProbPixel is the probability of an occurrence of each gray level
ProbPixel = compute_normalized_histogram(NumPixel,I2,'Normalized Histogram of Original Image',3);
% Cumupixel is the cumulative distribution function
CumuPixel = compute_cumulative_histogram(ProbPixel,'Cumulative Histogram of Original Image',4);

% The Cumupixel convert to new gray levels
Map = zeros(1,256);
for i = 1:256
    Map(i) = uint8(255 * CumuPixel(i)+0.5);
end
for i = 1:size(I2,1)
    for j = size(I2,2)
        I2(i,j)=Map(I2(i,j) + 1);
    end
end
image_1=I1;image_2=im2;
end