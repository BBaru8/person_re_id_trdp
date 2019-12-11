function [imageOne, imageTwo] =MidWay(InIm1,InIm2)
u_midway_1 = zeros ( size (InIm1));
u_midway_2 = zeros ( size (InIm2));
[ u_sort_1 , index_u_1 ] = sort (InIm1 (:));
[ u_sort_2 , index_u_2 ] = sort (InIm2 (:));
u_midway_1 ( index_u_1 ) = ( u_sort_1 + u_sort_2 )/2;
u_midway_2 ( index_u_2 ) = ( u_sort_1 + u_sort_2 )/2;
imageOne = reshape ( u_midway_1 , size (InIm1 ))/255.;
imageTwo = reshape ( u_midway_2 , size (InIm2 ))/255.;
end