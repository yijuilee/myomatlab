%% Opens new MATLAB session and terminates all background Python scripts
% Does not force an error for catch block response
eval('!matlab -nodesktop -nosplash -minimize -r ", try, terminate, catch, exit, end" &')