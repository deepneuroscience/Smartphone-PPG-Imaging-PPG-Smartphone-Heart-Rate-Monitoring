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


% Extraction of HRV (Heart Rate Variability)/PRV metrics
function [LF, HF, LFHF, SDPP, RMSSD, pPP50] = extraction_HRVmetrics(IBI,locs)

        epsilon = 0.007;
        LF_band = [0.04, 0.15]; % Low-frequency band
        HF_band = [0.15, 0.4]; % High-frequency band (unit: hz)
        pp50_variable =0.05; % 50ms duration
        
        [periodogram, freq]=plomb(IBI, locs(2:length(locs)));
        
        LF=abs(sum(periodogram(find(abs(freq-LF_band(1))<epsilon):find(abs(freq-LF_band(2))<epsilon))));
        HF=abs(sum(periodogram(find(abs(freq-HF_band(1))<epsilon):find(abs(freq-HF_band(2))<epsilon))));
        LFHF=LF/HF;
        SDPP=std(IBI);
        RMSSD=rms(diff(IBI));
        pPP50=length(find(diff(IBI)>pp50_variable))/length(IBI);
        
        disp(['LF power:', num2str(LF)])
        disp(['HF power:', num2str(HF)])
        disp(['LF/HF ratio:', num2str(LFHF)])
        disp(['SDPP:', num2str(SDPP)])
        disp(['RMSSD:',num2str(RMSSD)])
        disp(['pPP50:', num2str(pPP50)])