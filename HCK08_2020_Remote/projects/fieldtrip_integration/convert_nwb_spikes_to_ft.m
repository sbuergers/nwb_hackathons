%
% to do: Include useful header...
%
% sb, sbuergers@gmail.com


% Navigate to NWB folder
cd('D:/NWB')

% Add matNWB to search path (this is the newest release as of a beginning
% of May 2020)
addpath(genpath('matnwb-2.2.4'))

% Add hackathon folder to search path 
addpath(genpath('hackathon_may_2020'))

% Add fieldtrip to Matlab search path (we should all use the same version,
% which one?)
addpath('../fieldtrip-20190922')
ft_defaults



% Load example nwb file (from Steinmetz dataset)
% Can be found here:
% https://figshare.com/articles/Datasets_from_Steinmetz_et_al_2019_in_NWB_format/11274968
% (it's the first one)
nwb = nwbRead('data/Steinmetz2019_Cori_2016-12-14.nwb');
nwb.acquisition
nwb.units



% The following is adapted from:
% https://neurodatawithoutborders.github.io/matnwb/tutorials/html/basicUsage.html


% Also see 
% http://www.fieldtriptoolbox.org/reference/ft_datatype_spike/
% http://www.fieldtriptoolbox.org/tutorial/spike/



% Trial info from NWB
%
nwb_trial_ids = nwb.intervals_trials.id.data.load();
% start and end time of trials
nwb_trial_stime = nwb.intervals_trials.start_time.data.load();
nwb_trial_etime = nwb.intervals_trials.stop_time.data.load();
Ntrials = length(nwb_trial_ids);


% Get unit IDS, spike times and indeces from NWB file
%
nwb_unit_ids = nwb.units.id.data.load();
% spike times in s(?)
nwb_spike_times = nwb.units.spike_times.data.load();
% Index of start of unit in spike_times
nwb_spike_times_idx = nwb.units.spike_times_index.data.load();
Nunits = length(nwb_unit_ids);


% Get NWB sampling rate for each unit (in Hz, but might have to check)
sampFs = nwb.units.vectordata.get('sampling_rate').data.load();


% Initialize FT fields for ft_datatype_spike
label = cell(Nunits,1);         % unit labels
timestamp = cell(Nunits,1);     % spike samples
time = cell(Nunits,1);          % spike times
trial = cell(Nunits,1);         % trial index (for each spike)
trialtime = [];     % time of start and end of trial


% Go through NWB units and fill in FT fields
fprintf('\nConverting spikes from NWB to FieldTrip:\n')
last_idx = 0;
for i = 1:Nunits

    if i == 1 || i == Nunits || mod(i, round(Nunits/10)) == 0
        fprintf('Processing unit %i \n', i)
    end
    
    unit_id = nwb_unit_ids(i);
    
    % Add label
    if isa(unit_id, 'int64') || isa(unit_id, 'int32') || isa(unit_id, 'int8') % | ...
        label{i} = num2str(unit_id);
    elseif isa(unit_id, 'char')
        label{i} = unit_id;
    end
    
    % Determine start and end of unit in nwb_spike_times
    start_idx = last_idx + 1;
    end_idx = nwb_spike_times_idx(i);
    
    % Add spike times for each unit
    time{i} = nwb_spike_times(start_idx:end_idx);
    
    % Add spike samples for each unit. 
    timestamp{i} = nwb_spike_times(start_idx:end_idx) * sampFs(i);
    
    % Determine trial of each spike time
    trial{i} = nan(size(time{i}));
    for itrial = 1:Ntrials
        % find all spike times in trial itrial
        trl_idx = time{i}>=nwb_trial_stime(itrial) & time{i}<nwb_trial_etime(itrial);
        trial{i}(trl_idx) = itrial;        
    end
    
    % Delete spikes that are not in trials? Otherwise filled with NaNs.
    % ...
    
    % Add trial times
    % ...
    
end






% eof













