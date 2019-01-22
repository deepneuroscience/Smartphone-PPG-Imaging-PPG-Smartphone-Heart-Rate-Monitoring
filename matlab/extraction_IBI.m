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


% Extraction of IBI(Inter-beat Interval)

function [IBI,locs] = extraction_IBI(time_info, BVP, framerate)

    findpeaks(BVP-smooth(BVP,round(framerate)+1),time_info,'MinPeakDistance', 0.5);
    [~, locs]=findpeaks(BVP-smooth(BVP,round(framerate)+1),time_info,'MinPeakDistance', 0.5)
    IBI = diff(locs);
%     plot(locs(2:length(locs)), IBI);
