#= module tips_dataSaving.jl

the short for "TubInterfPicoSaving" is "tips"

official description of TubInterfPicoSaving:
Educated saving of interferometry data
for AWAKE DPS tubes using Picoscope oscilloscopes

this module... tips_dataSaving...
... aim to contain suport functions for saving data from the oscilloscopes...
    ... into computer disk and eventually other locations for posterior treatment

features:
(intended 2023_02_04)
  ...save data from USB picoscopes (one or two picoscopes)
  ...data should be saved in NEXUS format with cleaver sampling...
     ... and avoiding repetitions

=#


#*************************************************
function tips_dataSaving_testsum(x,y)
  c=x+y
  c
end
# testcode
# tips_dataSaving_testsum(a,b)=a+b
#*************************************************
