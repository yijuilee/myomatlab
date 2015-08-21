% #######################################################################
%
% Authored by Yi Jui Lee
% 
% Tested on MATLAB 2013a, Python 2.7
% 
% ***********************************************************************
% Filename : init_python.m
% Depends on Myo.m official development version
% 
% Version 1 (15 August 2015)
% ***********************************************************************

%% Execute Python script corresponding to the call function

if exist('r1','var')
    if r1 == 1
        r1 = 0;
        python('getAccel.py')
        exit
    end
elseif exist('r2','var')
    if r2 == 1
        r2 = 0; 
        python('getGyro.py')
        exit
    end
elseif exist('r3','var')
    if r3 == 1
        r3 = 0;
        python('getOrient.py')
        exit
    end
elseif exist('r4','var')
    if r4 == 1
        r4 = 0;
        python('getPose.py')
        exit
    end
elseif exist('r5','var')
    if r5 == 1
        r5 = 0;
        python('getEmg.py')
        exit
    end
elseif exist('r6','var')
    if r6 == 1
        r6 = 0;
        python('getAllData.py')
        exit
    end
end
exit