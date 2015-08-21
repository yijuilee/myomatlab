% #######################################################################
%
% Authored by Yi Jui Lee
%
% Tested on MATLAB 2013a, Python 2.7
%
% ***********************************************************************
% Filename : Myo.m
%
% Version 1 (15 August 2015)
% ***********************************************************************


%% Official Myo MATLAB Interface
classdef Myo < handle
    properties
        acceleration = [];
        gyroscope = [];
        orientation = [];
        pose = [];
        emg = [];
    end
    %%
    methods
        function m = Myo()
            disp('###########################################################################');
            disp('# Myo Object Created                                                      #');
            disp('# Please make sure that Myo Connect is running and Myo is connected       #');
            disp('###########################################################################');
            disp(' ');
        end
        %%
        function a1 = getAcceleration(m)
            clc;
            a1 = [0 0 0];
            FileID1 = fopen('Acceleration.txt','w');
            FileID2 = fopen('PythonVars.txt','wt');
            SampleRate = input('Please type in desired sample rate (0-50Hz): ');
            T = input('Please indicate the duration of program (seconds): ');
            pythonvars = [SampleRate, T];
            fprintf(FileID2,'%d\n',pythonvars);
            fclose(FileID2);
            eval('!matlab -nodesktop -nosplash -minimize -r "r1 = 1, try, terminate, catch, try, init_python, catch, exit, end, end" &');
            t_initial = clock; ii = 0; t = 0;
            while t < T
                ii = ii+1;
                t2 = clock;
                t(ii) = etime(t2,t_initial);
                disp(['Progress: ',num2str(((t(ii))/T)*100,'% .0f'),' % done...']);
                FileID1 = fopen('Acceleration.txt');
                Acceleration = textscan(FileID1,'%s %s %s');
                fclose(FileID1);
                if length(a1) < length(Acceleration{1})
                    FileID1 = fopen('Acceleration.txt');
                    Acceleration = textscan(FileID1,'%s %s %s','HeaderLines',length(a1));
                    fclose(FileID1);
                    for i = 1:length(Acceleration{1})
                        s = {Acceleration{1,1}{i,1} Acceleration{1,2}{i,1} Acceleration{1,3}{i,1}};
                        temp = strtok(s,'[ ]');
                        a1(end+1,:) = str2double(temp);
                        plot(a1)
                        drawnow
                    end
                end
            end
            m.acceleration = a1;
            pyquit;
        end
        %%
        function a2 = getGyroscope(m)
            clc
            close all
            a2 = [0 0 0];
            FileID1 = fopen('Gyroscope.txt','w');
            FileID2 = fopen('PythonVars.txt','wt');
            SampleRate = input('Please type in desired sample rate (0-50Hz): ');
            T = input('Please indicate the duration of program (seconds): ');
            pythonvars = [SampleRate, T];
            fprintf(FileID2,'%d\n',pythonvars);
            fclose(FileID2);
            eval('!matlab -nodesktop -nosplash -minimize -r "r2 = 1, try, terminate, catch, try, init_python, catch, exit, end, end" &')
            t_initial = clock;
            ii = 0;
            t = 0;
            while t < T
                ii = ii+1;
                t2 = clock;
                t(ii) = etime(t2,t_initial);
                disp(['Progress: ',num2str(((t(ii))/T)*100,'% .0f'),' % done...']);
                FileID1 = fopen('Gyroscope.txt');
                Gyroscope = textscan(FileID1,'%s %s %s');
                fclose(FileID1);
                if length(a2) < length(Gyroscope{1})
                    FileID1 = fopen('Gyroscope.txt');
                    Gyroscope = textscan(FileID1,'%s %s %s','HeaderLines',length(a2));
                    fclose(FileID1);
                    for i = 1:length(Gyroscope{1})
                        s = {Gyroscope{1,1}{i,1} Gyroscope{1,2}{i,1} Gyroscope{1,3}{i,1}};
                        temp = strtok(s,'[ ]');
                        a2(end+1,:) = str2double(temp);
                        
                        plot(a2)
                        drawnow
                    end
                end
            end
            m.gyroscope = a2;
            pyquit
        end
        %%
        function a3 = getOrientation(m)
            clc;
            a3 = [0 0 0 0]; roll = 0; pitch = 0; yaw = 0; a3_e = [roll pitch yaw];
            FileID3 = fopen('Orientation.txt','w');
            FileID2 = fopen('PythonVars.txt','wt');
            SampleRate = input('Please type in desired sample rate (0-50Hz): ');
            T = input('Please indicate the duration of program (seconds): ');
            pythonvars = [SampleRate, T];
            fprintf(FileID2,'%d\n',pythonvars);
            fclose(FileID2);
            eval('!matlab -nodesktop -nosplash -minimize -r "r3 = 1, try, terminate, catch, try, init_python, catch, exit, end, end" &')
            t_initial = clock;
            ii = 0;
            t = 0;
            
            while t < T
                ii = ii+1;
                t2 = clock;
                t(ii) = etime(t2,t_initial);
                disp(['Progress: ',num2str(((t(ii))/T)*100,'% .0f'),' % done...']);
                FileID3 = fopen('Orientation.txt');
                Orientation = textscan(FileID3,'%s %s %s %s');
                fclose(FileID3);
                [p1,q1] = size(a3);
                [p2] = length(Orientation{1});
                if (p1 < p2);
                    FileID3 = fopen('Orientation.txt');
                    Orientation = textscan(FileID3,'%s %s %s %s','HeaderLines',p1);
                    fclose(FileID3);
                    for i = 1:length(Orientation{1});
                        s = {Orientation{1,1}{i,1} Orientation{1,2}{i,1} Orientation{1,3}{i,1}, Orientation{1,4}{i,1}};
                        temp = strtok(s,'[ ]');
                        a3(end+1,:) = str2double(temp);
                        
                        [roll, pitch, yaw] = quat2angle(a3(end,:));
                        a3_e(end+1,:) = [roll pitch yaw];
                        plot(a3_e);
                        drawnow
                    end
                end
            end
            m.orientation = a3_e;
            pyquit
        end
        %%
        function a4 = getPose(m)
            clc;
            FileID2 = fopen('PythonVars.txt','wt');
            SampleRate = 50; % assign random number
            T = input('Please indicate the duration of program (seconds): ');
            pythonvars = [SampleRate, T];
            fprintf(FileID2,'%d\n',pythonvars);
            fclose(FileID2);
            eval('!matlab -nodesktop -nosplash -minimize -r "r4 = 1, try, terminate, catch, try, init_python, catch, exit, end, end" &')
            t_initial = clock;
            ii = 0;
            t = 0;
            a4{1,1} = 'rest>';
            FileID4 = fopen('Pose.txt','w');
            pin = 0;
            while t < T
                ii = ii+1;
                t2 = clock;
                t(ii) = etime(t2,t_initial);
                disp(['Progress: ',num2str(((t(ii))/T)*100,'% .0f'),' % done...']);
                FileID4 = fopen('Pose.txt');
                Pose = textscan(FileID4,'%s %s');
                fclose(FileID4);
                if pin < length(Pose{1,2})
                    FileID4 = fopen('Pose.txt');
                    Pose = textscan(FileID4,'%s %s','HeaderLines',pin);
                    fclose(FileID4);
                    pin = pin + length(Pose{1,2});
                    
                    for i = 1:length(Pose{1,2})
                        p = char([Pose{1,2}{i,1}])
                        a4{end+1,1} = p;
                    end
                end
                
            end
            m.pose = a4;
            pyquit
        end
        %%
        function a5 = getEmg(m)
            clc;
            FileID2 = fopen('PythonVars.txt','wt');
            SampleRate = input('Please type in desired sample rate (0-200Hz): ');
            T = input('Please indicate the duration of program (seconds): ');
            pythonvars = [SampleRate, T];
            fprintf(FileID2,'%d\n',pythonvars);
            fclose(FileID2);
            eval('!matlab -nodesktop -nosplash -minimize -r "r5 = 1, try, terminate, catch, try, init_python, catch, exit, end, end" &')
            t_initial = clock;
            ii = 0;
            t = 0;
            a5 = [0 0 0 0 0 0 0 0];
            FileID5 = fopen('Emg.txt','w');
            
            while t < T
                ii = ii+1;
                t2 = clock;
                t(ii) = etime(t2,t_initial);
                disp(['Progress: ',num2str(((t(ii))/T)*100,'% .0f'),' % done...']);
                FileID5 = fopen('Emg.txt');
                Emg = textscan(FileID5,'%s %s %s %s %s %s %s %s');
                fclose(FileID5);
                [p1,q1] = size(a5);
                [p2] = length(Emg{1});
                if (p1 < p2);
                    FileID5 = fopen('Emg.txt');
                    Emg = textscan(FileID5,'%s %s %s %s %s %s %s %s','HeaderLines',p1);
                    fclose(FileID5);
                    for i = 1:length(Emg{1});
                        s = {Emg{1,1}{i,1} Emg{1,2}{i,1} Emg{1,3}{i,1} Emg{1,4}{i,1} Emg{1,5}{i,1} Emg{1,6}{i,1} Emg{1,7}{i,1} Emg{1,8}{i,1}};
                        temp = strtok(s,'[ ]');
                        a5(end+1,:) = str2double(temp);
                        plot(a5)
                        drawnow
                    end
                end
            end
            m.emg = a5;
            pyquit
        end
        %%
        function [a1, a2, a3, a4, a5] = getAllData(m)
            clc;
            FileID7 = fopen('PythonVars.txt','wt');
            SampleRate = input('Please type in desired sample rate (0-50Hz): ');
            T = input('Please indicate the duration of program (seconds): ');
            pythonvars = [SampleRate, T];
            fprintf(FileID7,'%d\n',pythonvars);
            fclose(FileID7);
            eval('!matlab -nodesktop -nosplash -minimize -r "r6 = 1, try, terminate, catch, try, init_python, catch, exit, end, end" &')
            t_initial = clock;
            ii = 0;
            t = 0;
            a1 = [0 0 0];
            a2 = [0 0 0];
            a3 = [0 0 0 0];
            a3_e = [0 0 0];
            roll = 0; pitch = 0; yaw = 0; a3_e(end+1,:) = [roll pitch yaw];
            a4{1,1} = 'rest>';
            a5 = [0 0 0 0 0 0 0 0];
            FileID1 = fopen('Acceleration.txt','w');
            FileID2 = fopen('Gyroscope.txt','w');
            FileID3 = fopen('Orientation.txt','w');
            FileID4 = fopen('Pose.txt','w');
            FileID5 = fopen('Emg.txt','w');
            
            while t < T
                ii = ii+1;
                t2 = clock;
                t(ii) = etime(t2,t_initial);
                disp(['Progress: ',num2str(((t(ii))/T)*100,'% .0f'),' % done...']);
                FileID1 = fopen('Acceleration.txt');
                FileID2 = fopen('Gyroscope.txt');
                FileID3 = fopen('Orientation.txt');
                FileID4 = fopen('Pose.txt');
                FileID5 = fopen('Emg.txt');
                Acceleration = textscan(FileID1,'%s %s %s');
                Gyroscope = textscan(FileID2,'%s %s %s');
                Orientation = textscan(FileID3,'%s %s %s %s');
                Pose = textscan(FileID4,'%s %s');
                Emg = textscan(FileID4,'%s %s %s %s %s %s %s %s');
                fclose(FileID1);
                fclose(FileID2);
                fclose(FileID3);
                fclose(FileID4);
                fclose(FileID5);
                [p1,q1] = size(a1);
                [p2] = length(Acceleration{1});
                if (p1 < p2);
                    FileID1 = fopen('Acceleration.txt');
                    FileID2 = fopen('Gyroscope.txt');
                    FileID3 = fopen('Orientation.txt');
                    FileID4 = fopen('Pose.txt');
                    FileID5 = fopen('Emg.txt');
                    [p3,q3] = size(a1);
                    [p4,q4] = size(a2);
                    [p5,q5] = size(a3);
                    [p6,q6] = size(a4);
                    [p7,q7] = size(a5);
                    Acceleration = textscan(FileID1,'%s %s %s','HeaderLines',p3);
                    Gyroscope = textscan(FileID2,'%s %s %s','HeaderLines',p4);
                    Orientation = textscan(FileID3,'%s %s %s %s','HeaderLines',p5);
                    Pose = textscan(FileID4,'%s %s','HeaderLines',p6);
                    Emg = textscan(FileID5,'%s %s %s %s %s %s %s %s','HeaderLines',p7);
                    fclose(FileID1);
                    fclose(FileID2);
                    fclose(FileID3);
                    fclose(FileID4);
                    fclose(FileID5);
                    
                    for i = 1:length(Acceleration{1});
                        s = {Acceleration{1,1}{i,1} Acceleration{1,2}{i,1} Acceleration{1,3}{i,1}};
                        temp = strtok(s,'[ ]');
                        a1(end+1,:) = str2double(temp);
                        plot(a1)
                        drawnow
                    end
                    
                    for i = 1:length(Gyroscope{1});
                        s = {Gyroscope{1,1}{i,1} Gyroscope{1,2}{i,1} Gyroscope{1,3}{i,1}};
                        temp = strtok(s,'[ ]');
                        a2(end+1,:) = str2double(temp);
                        
                    end
                    
                    for i = 1:length(Orientation{1});
                        s = {Orientation{1,1}{i,1} Orientation{1,2}{i,1} Orientation{1,3}{i,1}, Orientation{1,4}{i,1}};
                        temp = strtok(s,'[ ]');
                        a3(end+1,:) = str2double(temp);
                        
                        [roll, pitch, yaw] = quat2angle(a3(end,:));
                        a3_e(end+1,:) = [roll pitch yaw];
                        
                    end
                    
                    for i = 1:length(Pose{1,2});
                        a4{end+1,1} = [char([Pose{1,2}{i,1}])];
                    end
                    
                    for i = 1:length(Emg{1});
                        s = {Emg{1,1}{i,1} Emg{1,2}{i,1} Emg{1,3}{i,1} Emg{1,4}{i,1} Emg{1,5}{i,1} Emg{1,6}{i,1} Emg{1,7}{i,1} Emg{1,8}{i,1}};
                        temp = strtok(s,'[ ]');
                        a5(end+1,:) = str2double(temp);
                    end
                end
                
            end
            m.acceleration = a1;
            m.gyroscope = a2;
            m.orientation = a3_e;
            m.pose = a4;
            m.emg = a5;
            pyquit
        end
        %%
        function [a1, a2, a3_e, a4, a5] = getPostData(m)
            % Data is processed and shown in the workspace (not in real time)
            a1 = [0 0 0];
            a2 = [0 0 0];
            a3 = [0 0 0 0];
            a4{1,1} = 'rest>';
            a5 = [0 0 0 0 0 0 0 0];
            a3_e = [0 0 0];
            while 1
                FileID1 = fopen('Acceleration.txt');
                FileID2 = fopen('Gyroscope.txt');
                FileID3 = fopen('Orientation.txt');
                FileID4 = fopen('Pose.txt');
                FileID5 = fopen('Emg.txt');
                Acceleration = textscan(FileID1,'%s %s %s');
                Gyroscope = textscan(FileID2,'%s %s %s');
                Orientation = textscan(FileID3,'%s %s %s %s');
                Pose = textscan(FileID4,'%s %s');
                Emg = textscan(FileID5,'%s %s %s %s %s %s %s %s');
                fclose(FileID1);
                fclose(FileID2);
                fclose(FileID3);
                fclose(FileID4);
                fclose(FileID5);
                [p1,q1] = size(a1);
                
                [p2] = length(Gyroscope{1});
                if (p1 < p2);
                    FileID1 = fopen('Acceleration.txt');
                    FileID2 = fopen('Gyroscope.txt');
                    FileID3 = fopen('Orientation.txt');
                    FileID4 = fopen('Pose.txt');
                    FileID5 = fopen('Emg.txt');
                    [p3,q3] = size(a1);
                    [p4,q4] = size(a2);
                    [p5,q5] = size(a3);
                    [p6,q6] = size(a4);
                    [p7,q7] = size(a5);
                    %         Read data from the last retrieved row
                    Acceleration = textscan(FileID1,'%s %s %s','HeaderLines',p3);
                    Gyroscope = textscan(FileID2,'%s %s %s','HeaderLines',p4);
                    Orientation = textscan(FileID3,'%s %s %s %s','HeaderLines',p5);
                    Pose = textscan(FileID4,'%s %s','HeaderLines',p6);
                    Emg = textscan(FileID5,'%s %s %s %s %s %s %s %s','HeaderLines',p7);
                    fclose(FileID1);
                    fclose(FileID2);
                    fclose(FileID3);
                    fclose(FileID4);
                    fclose(FileID5);
                    
                    %         Convert to real numbers
                    for i = 1:length(Acceleration{1});
                        a1(end+1,:) = str2num([Acceleration{1,1}{i,1} Acceleration{1,2}{i,1} Acceleration{1,3}{i,1}]);
                    end
                    
                    for i = 1:length(Gyroscope{1});
                        a2(end+1,:) = str2num([Gyroscope{1,1}{i,1} Gyroscope{1,2}{i,1} Gyroscope{1,3}{i,1}]);
                    end
                    
                    for i = 1:length(Orientation{1});
                        a3(end+1,:) = str2num([Orientation{1,1}{i,1} Orientation{1,2}{i,1} Orientation{1,3}{i,1}, Orientation{1,4}{i,1}]);
                        % % quaternion conversion
                        [roll, pitch, yaw] = quat2angle(a3(end,:));
                        a3_e(end+1,:) = [roll pitch yaw];
                    end
                    
                    for i = 1:length(Pose{1,2});
                        a4{end+1,1} = [char([Pose{1,2}{i,1}])];
                    end
                    
                    for i = 1:length(Emg{1});
                        a5(end+1,:) = str2num([Emg{1,1}{i,1} Emg{1,2}{i,1} Emg{1,3}{i,1} Emg{1,4}{i,1} Emg{1,5}{i,1} Emg{1,6}{i,1} Emg{1,7}{i,1} Emg{1,8}{i,1}]);
                    end
                    
                    
                end
                
                if [p1,q1] == size(a1);
                    break
                end
                
            end
            m.acceleration = a1;
            m.gyroscope = a2;
            m.orientation = a3_e;
            m.pose = a4;
            m.emg = a5;
        end
    end
end

