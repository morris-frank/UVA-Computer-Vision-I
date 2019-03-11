function [matches, scores, fa, fb] = keypoint_matching(image1, image2)

I1 = single(imread(image1));
I2 = single(imread(image2));

[fa, da] = vl_sift(I1) ;
[fb, db] = vl_sift(I2) ;
[matches, scores] = vl_ubcmatch(da, db);

%h1 = vl_plotframe(fa) ;
%h2 = vl_plotframe(fa) ;
%Na = size(fa);
%Nb = size(fb);
%min(Na(1), Nb(1))
%set(h1,'color','k','linewidth',3) ;
%set(h2,'color','y','linewidth',2) ;

end