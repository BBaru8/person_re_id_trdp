function image=luminance_remap(ima1,ima2)

imageA=rgb2hsv(ima1);
imageB=rgb2hsv(ima2);

meanA=mean2(imageA(:,:,3));
meanB=mean2(imageB(:,:,3));

sigA=std(std(imageA(:,:,3)));
sigB=std(std(imageB(:,:,3)));

Y=imageB(:,:,3);

sigAB=sigA/sigB;

for h=1:size(imageA,1)
    Y(h,:)=sigAB.*(double(Y(h,:))-meanB) + meanA;
end

Y=cat(3, imageB(:,:,1), imageB(:,:,2),Y);
image=hsv2rgb(Y);
end
