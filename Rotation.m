%%imageRotation
clc;clear;close all;

degree = input("Enter rotation degrees: "); %輸入旋轉角                 

%angle conversion
angle = degree;
angle = rem(angle, 360);
if angle < 0  
    angle = angle +360;
end

img = double(imread('onion.png'));          %輸入影像
[row, column, color] = size(img);

%rotation while loop
imgTemp = img;
while angle > 90
    newRow = size(imgTemp,1);
    newCol = size(imgTemp,2);
    R = [cosd(90),sind(90),0; -sind(90),cosd(90),0; 0,0,1]; 
    Shift = [1,0,0; 0,1,0; newCol*sind(90),0,1];

    imgOut = zeros(round(newRow*sind(90-90)+newCol*sind(90)), round(newRow*cosd(90-90)+newCol*cosd(90)), color);

    for i = 1:round(newRow*sind(90-90)+newCol*sind(90))
        for j = 1:round(newRow*cosd(90-90)+newCol*cosd(90))
            A = [i, j, 1]/(R*Shift);

            if A(1) < 1 || A(1) > newRow || A(2) < 1 || A(2) > newCol
                continue
            end

            imgOut(i, j, :) = imgTemp(round(A(1)), round(A(2)), :);
        end
    end
    angle = angle - 90;
    %figure();imshow(uint8(imgOut));title(['rotation image, degree : ',num2str(angle)]);
    imgTemp = imgOut;
end
%final rotation
newRow = size(imgTemp,1);
newCol = size(imgTemp,2);
R = [cosd(angle),sind(angle),0; -sind(angle),cosd(angle),0; 0,0,1];  
Shift = [1,0,0; 0,1,0; newCol*sind(angle),0,1];

imgOut = zeros(round(newRow*sind(90-angle)+newCol*sind(angle)), round(newRow*cosd(90-angle)+newCol*cosd(angle)), color);

for i = 1:round(newRow*sind(90-angle)+newCol*sind(angle))
    for j = 1:round(newRow*cosd(90-angle)+newCol*cosd(angle))
        A = [i, j, 1]/(R*Shift);

        if A(1) < 1 || A(1) > newRow || A(2) < 1 || A(2) > newCol
            continue
        end

        imgOut(i, j, :) = imgTemp(round(A(1)), round(A(2)), :);
    end
end

figure();imshow(uint8(img));title('original');
figure();imshow(uint8(imgOut));title(['rotation image, degree : ',num2str(degree)]);
