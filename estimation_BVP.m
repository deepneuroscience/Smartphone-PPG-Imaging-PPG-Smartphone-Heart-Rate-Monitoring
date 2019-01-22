%% Author Information
% 21-Janunary-2019
%
% Youngjun Cho
% * Lecturer (Assistant Professor), Department of Computer Science, UCL
% * Email: youngjun.cho@ucl.ac.uk
%
% Reference
%    Cho Y, Julier SJ, Bianchi-Berthouze N,
%    "Instant Automated Inference of Perceived Mental Stress through
%    Smartphone PPG and Thermal Imaging"
%    JMIR Mental Health - special issue on Computing and Mental Health (2018)(in press)
%    DOI: 10.2196/10140
%
% This code is a material for the lecture
% "Physiological Computing" as part of 
% "UCL Affective Computing and Human Robot Interaction" 


% Extraction of R-Channel Entropy (estimation of raw BVP signals)


function [time_info, estimated_BVP, framerate] = estimation_BVP(filename)
    % filename='yourfile.name';

    offset = 5;
    % Read RGB video frames. 
    obj=VideoReader(filename);

    img_height = obj.Height;
    img_width = obj.Width;

    s = struct('cdata',zeros(img_height,img_width,3,'uint8'),...
        'colormap',[]);

    framerate=obj.FrameRate;

    k=0;
    while hasFrame(obj)
        k=k+1;
        s(k).cdata = readFrame(obj);
    end

    estimated_BVP=zeros(length(s),1);
    for l=1:length(s)
%         estimated_BVP(l,1)=mean(mean(s(l).cdata(:,:,1))); % average from R-channel data
        estimated_BVP(l,1)=-entropy(s(l).cdata(:,:,1)); % Entropy from R-channel data
    end

    %% generation of time info.
    time_info=[1/framerate:1/framerate:length(s)/framerate]';

    plot(time_info,estimated_BVP);
    
    % remove the first []s data.
    time_info(1:round(framerate*offset),:)=[];
    estimated_BVP(1:round(framerate*offset),:)=[];
    