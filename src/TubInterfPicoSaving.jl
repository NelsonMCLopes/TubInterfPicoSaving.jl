#= module TubInterfPicoSaving.jl

the short for "TubInterfPicoSaving" is "tips"

official description:
Educated saving of interferometry data
for AWAKE DPS tubes using Picoscope oscilloscopes

intended use:
Save and display data relevant for DPS testing in 2023 in IST and CERN

features:
(intended 2023_02_04)
aquire data from USB picoscopes (one or two picoscopes)
store run data in an efficient way...
... e.g. ... supress current traces data in non interesting times
         ... have interferometry trace with reduced sampling frequency in the seismic zone
         ... have interferometry trace with highest sampling frequency in the plasma zone
         ... save just one time vector per run per osciloscope (since they are the same for different shots)
         ... use NEXUS format with all the relevant features to save data
         ... use our time stamp strategy
=#
module TubInterfPicoSaving

# include all modules
include("tips_scopImport.jl")
include("tips_dataSaving.jl")
include("tips_dataTreatm.jl")

# export all funtions
export tips_scopImport_testsum
export tips_dataSaving_testsum
export tips_dataTreatm_testsum

end #module
