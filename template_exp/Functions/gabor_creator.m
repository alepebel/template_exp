function [imageMatrix] = gabor_creator(freq, tilt, contrast, black, white, gabor,radius,phase)

%% You can output directy grayscaleImageMatrix as a function of your needs.
% Gabor creator
% Created by modifying GratingDemo.m by Alexis Perez Bellido 10/2016

% This function can create gabor matrices with different SF, contrast, tilt and phase. 
% SCREEN greys.
% 
% *** To rotate the grating, set tiltInDegrees to a new value.
tiltInDegrees = tilt; % The tilt of the grating in degrees.
tiltInRadians = tiltInDegrees * pi / 180; % The tilt of the grating in radians.

% *** To lengthen the period of the grating, increase pixelsPerPeriod.
pixelsPerPeriod = 33; % How many pixels will each period/cycle occupy?
spatialFrequency = freq / pixelsPerPeriod; % How many periods/cycles are there in a pixel?
radiansPerPixel = spatialFrequency * (2 * pi); % = (periods per pixel) * (2 pi radians per period)

% *** To enlarge the gaussian mask, increase periodsCoveredByOneStandardDeviation.
% The parameter "periodsCoveredByOneStandardDeviation" is approximately
% equal to
% the number of periods/cycles covered by one standard deviation of the radius of
% the gaussian mask.
periodsCoveredByOneStandardDeviation = 4.5;
% The parameter "gaussianSpaceConstant" is approximately equal to the
% number of pixels covered by one standard deviation of the radius of
% the gaussian mask.
gaussianSpaceConstant = periodsCoveredByOneStandardDeviation  * pixelsPerPeriod;

% *** If the grating is clipped on the sides, increase widthOfGrid.
widthOfGrid = 600;
halfWidthOfGrid = widthOfGrid / 2;
widthArray = (-halfWidthOfGrid) : halfWidthOfGrid;  % widthArray is used in creating the meshgrid.


% For an explanation of the try-catch block, see the section "Error Handling"
% at the end of this document.
try
    	  
	% ---------- Color Setup ----------
	% Gets color values.

	gray = (black + white) / 2;  % Computes the CLUT color code for gray.
	if round(gray)==white
		gray=black;
    end
	 
	% Taking the absolute value of the difference between white and gray will
	% help keep the grating consistent regardless of whether the CLUT color
	% code for white is less or greater than the CLUT color code for black.
	absoluteDifferenceBetweenWhiteAndGray = abs(white - gray);


	% ---------- Image Setup ----------
	% Stores the image in a two dimensional matrix.

	% Creates a two-dimensional square grid.  For each element i = i(x0, y0) of
	% the grid, x = x(x0, y0) corresponds to the x-coordinate of element "i"
	% and y = y(x0, y0) corresponds to the y-coordinate of element "i"
	[x y] = meshgrid(widthArray, widthArray);
    
    % Replaced original method of changing the orientation of the grating
    % (gradient = y - tan(tiltInRadians) .* x) with sine and cosine (adapted from DriftDemo). 
    % Use of tangent was breakable because it is undefined for theta near pi/2 and the period
    % of the grating changed with change in theta.  

    a=cos(tiltInRadians)*radiansPerPixel;
	b=sin(tiltInRadians)*radiansPerPixel;
	 
	% Converts meshgrid into a sinusoidal grating, where elements
	% along a line with angle theta have the same value and where the
	% period of the sinusoid is equal to "pixelsPerPeriod" pixels.
	% Note that each entry of gratingMatrix varies between minus one and
	% one; -1 <= gratingMatrix(x0, y0)  <= 1
    gratingMatrix = contrast*sin(a*x+b*y+phase);
    
	 
	% Creates a circular Gaussian mask centered at the origin, where the number
	% of pixels covered by one standard deviation of the radius is
	% approximately equal to "gaussianSpaceConstant."
	% For more information on circular and elliptical Gaussian distributions, please see
	% http://mathworld.wolfram.com/GaussianFunction.html
	% Note that since each entry of circularGaussianMaskMatrix is "e"
	% raised to a negative exponent, each entry of
	% circularGaussianMaskMatrix is one over "e" raised to a positive
	% exponent, which is always between zero and one;
	% 0 < circularGaussianMaskMatrix(x0, y0) <= 1
	circularGaussianMaskMatrix = exp(-((x .^ 2) + (y .^ 2)) / (gaussianSpaceConstant ^ 2));
	 
	% Since each entry of gratingMatrix varies between minus one and one and each entry of
	% circularGaussianMaskMatrix vary between zero and one, each entry of
	% imageMatrix varies between minus one and one.
	% -1 <= imageMatrix(x0, y0) <= 1
    
    %% Creates a circular mask and then it is applie to the grating grid.
     
        [rr cc] = meshgrid(widthArray, widthArray);
        C = sqrt((rr-0).^2+(cc-0).^2)<=radius;  %in pixels
        
    if gabor
        imageMatrix = C.*gratingMatrix.* circularGaussianMaskMatrix;
        
    else    %grating      
        imageMatrix = C.*gratingMatrix;
    end
    
    %%
    
	% Since each entry of imageMatrix is a fraction between minus one and
	% one, multiplying imageMatrix by absoluteDifferenceBetweenWhiteAndGray
	% and adding the gray CLUT color code baseline
	% converts each entry of imageMatrix into a shade of gray:
	% if an entry of "m" is minus one, then the corresponding pixel is black;
	% if an entry of "m" is zero, then the corresponding pixel is gray;
	% if an entry of "m" is one, then the corresponding pixel is white.
	grayscaleImageMatrix = gray + absoluteDifferenceBetweenWhiteAndGray * imageMatrix;
    
	

catch
   
	% ---------- Error Handling ---------- 
	% If there is an error in our code, we will end up here.
	% We throw the error again so the user sees the error description.
	psychrethrow(psychlasterror);
    
end
