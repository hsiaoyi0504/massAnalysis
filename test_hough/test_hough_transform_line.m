clear;
clc;
close all;
numPeaks=30;
img=imread('spectrums/Healthy.png');
[m n l]=size(img);
I=img(:,:,1)-img(:,:,3);
I=I(100:m-100,100:n-100);
imshow(I);
figure;
BW = edge(I,'canny');
[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;
P  = houghpeaks(H,numPeaks,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');
lines = houghlines(BW,T,R,P,'FillGap',numPeaks,'MinLength',7);
figure, imshow(img(100:m-100,100:n-100,:)), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   if (xy(1,1)<xy(2,1) && xy(1,2)>xy(2,2)) || (xy(1,1)>xy(2,1) && xy(1,2)<xy(2,2))
      plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

      % Plot beginnings and ends of lines

      plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
      %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','yellow');
      plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
   end
   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
      xy_long = xy;
   end
end