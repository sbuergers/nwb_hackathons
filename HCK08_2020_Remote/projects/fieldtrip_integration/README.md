[:rewind: Back to the projects list](../../README.md#ProjectsList)

<!-- For information on how to write GitHub .md files see https://guides.github.com/features/mastering-markdown/ -->

# Fieldtrip Integration

## Key Investigators

Steffen Buergers (University of Birmingham)

Jens Klinzing (Princeton University)

Tara van Viegen (Princeton University)

## Project Description

Convert data structures in FieldTrip format to NWB format and vice versa. 

## Objectives

1. Read-in of NWB data in Fieldtrip
2. Export to NWB data format 

## Approach and Plan

1. Understand data formats properly 
2. Read in NWB Header information (ft_read_header)
3. Read in NWB LFP data (ft_read_data)
4. Read in NWB LFP metadata (ft_preprocessing, ft_read_event)
5. Read in NWB spike data (ft_read_spikes)
6. Write NWB data to Fieldtrip format

## Progress and Next Steps

<!--Populate this section as you are making progress before/during/after the hackathon-->
<!--Describe the progress you have made on the project,e.g., which objectives you have achieved and how.-->
<!--Describe the next steps you are planning to take to complete the project.-->

## Materials

<!--If available add links to the materials relevant to the project, e.g., the code generated for the project or data used-->
<!--If available add pictures and links to videos that demonstrate what has been accomplished.-->
<!--![Description of picture](Example2.jpg)-->

## Background and References

Example datasets: both ephys and calcium imaging
https://www.nwb.org/example-datasets/
...incl. a small reference dataset: https://drive.google.com/drive/folders/1g1CpnoMd9s9L-sHBWVyklp3-xJcLGeFt

NWB:N 2.0 Reference paper
https://www.biorxiv.org/content/10.1101/523035v1.full.pdf

NWB:N 2.0 Matlab API b
https://github.com/NeurodataWithoutBorders/matnwb

NWB:N 2.0 basic data usage
https://neurodatawithoutborders.github.io/matnwb/tutorials/html/basicUsage.html

NWB:N 2.0 schema
https://nwb-schema.readthedocs.io/en/latest/

Fieldtrip datatype: Raw data
http://www.fieldtriptoolbox.org/reference/ft_datatype_raw/

Fieldtrip datatype: Spike data
http://www.fieldtriptoolbox.org/reference/ft_datatype_spike/



## Potential issues
1
The Fieldtrip data format seems not to allow units shared across contacts (see https://github.com/fieldtrip/fieldtrip/issues/721#issuecomment-603080632). It allows several units per contact (described in spike.unit which contains one integer for each channel and spike in that channel.



## Data format overview
This is just a first attempt to try to make sense of the data formats in NWB and FieldTrip to see what needs to be converted into what. 

### NWB:
Assume the .nwb file is called nwb, then

__nwb.general_..__ contain lots of information specific to the experiment, recording, etc., which might not be that important for us, at least at the beginning. 

__nwb.acquisition__ contains a number of constrained sets that have information on the raw data. For example raw electrophys data might be saved in ElectricalSeries objects, but behavioural and other data can be included as BehavioralTimeSeries and TimeSeries objects. I had a quick look at some examples, where the set contained an ElectricalSeries object for each trial, plus two non-electrophys TimeSeries. You can access constrained sets using the keys=nwb.acquisition.keys() like so nwb.acquisition.get(keys(1)).

__nwb.intervals_trials__ contains potentially lots of trial related information that is not electrophys data, e.g. trial type, response time, etc.

__nwb.units__ is probably most relevant for us. It contains the spike times in nwb.units.spike_times.data.load() for example. 

__nwb.timestamps_reference_time__ is the time every other temporal information in the file is referenced against.



### FieldTrip

The FieldTrip data structure is comparatively simple compared to NWB, but also contains much less information. I believe that this tutorial is a great start.  
http://www.fieldtriptoolbox.org/tutorial/spike/







