#= module tips_scopImport.jl

the short for "TubInterfPicoSaving" is "tips"

official description of TubInterfPicoSaving:
Educated saving of interferometry data
for AWAKE DPS tubes using Picoscope oscilloscopes

this module... tips_scopImport...
... aim to contain suport functions for aquiring data from the oscilloscopes...
    ... into computer memory for posterior saving of reduced information

features:
(intended 2023_02_04)
  ...aquire data from USB picoscopes (one or two picoscopes)

=#


#*************************************************
function tips_scopImport_testsum(x,y)
  c=x+y
  c
end
# testcode
# tips_scopImport_testsum(a,b)=a+b
#*************************************************
function aaa()
  aa = 23
  aa
end

function bbb()
  bb = 24
  bb
end

function ccc(a,b)
  cc = aa*aaa+bb*bbb
  cc
end
