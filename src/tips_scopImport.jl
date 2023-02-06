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
#*************************************************
function tips_scopImport_bs()
  #basic saving...
  #should perform the old saving function

  # extract datapath from config file
  configuration = TOML.parsefile("tips_config.toml")
  config_keys = collect(keys(configuration))
  config_values = collect(values(configuration))
  path = config_values[findall(x->x=="savingPath",config_keys)][1]
  if ~isdir(path)
    println("FATAL ERROR -> Saving path as in config file is invalid...")
    println(" ... you have to manually create it or fix config file :-( ")
    return
  end

  #see if today directory exits and create it if not
  todayDateDirName = lpad(string(Dates.year(tt)),4,"0")*"_"*
                    lpad(string(Dates.month(tt)),2,"0")*"_"*
                    lpad(string(Dates.day(tt)),2,"0")
  todayDateDirPath = path*todayDateDirName*"/"
  if ~isdir(todayDateDirPath)
    mkdir(todayDateDirPath)
    #create also run 1 subdir
    run1SubdirName = todayDateDirName*"_run_0001"
    run1SubdirPath = todayDateDirPath*run1SubdirName*"/"
    mkdir(run1SubdirPath)
    println("Today saving directory created - ", todayDateDirPath)
    println("Also, Run 1 subdirectrory created - ",run1SubdirPath)
    println("Ready to save shot 1 there ... ")
    #
    # fix run number and nex shot number
    currentRunNumber = 1
    nextShotNumber = 1
    #
  end
  if isdir(todayDateDirPath)
    # in this case the day saving directory already exists...
    # ... so we need to see what is the last run and the last shot number in it...
    # ... before we decide if we are going to add more shots in the last run ...
    # ... or starting a new run ...

    # find last run... in principle is the last directory
    allTodayRuns = readdir(todayDateDirPath)
    todayLastRunName = allTodayRuns[length(allTodayRuns)]
    todayLastRunPath = todayDateDirPath*todayLastRunName
    potentialLastRunNumber = parse(Int64,todayLastRunName[15:18])
    # find last shot inside last run (if not empty)
    allTodayLastRunContent = readdir(todayLastRunPath)
    # the correct length of a shot name is 42 characters if it is a subdir
    # example 2020_12_11_11_47_32_095_run_0001_sh_000001
    # or 42+4 = 46 charateres if it is a file
    # example 2022_03_11_11_14_08_095_run_0001_sh_000001.csv
    # if the length of last item is not 42 the run is empty from shots
    # if the length of last item is 42 or more..
    # the number of the shot is in charateres [37:42]
    potentialLastShot = allTodayLastRunContent[length(allTodayLastRunContent)]
    if length(potentialLastShot)>=42
      # there seems to be at leat a shot in the directory
      potentialLastShotNumberString = potentialLastShot[37:42]
      potentialLastShotNumberInt64 = parse(Int64,potentialLastShotNumberString)
      println("Today saving directory exists - ", todayDateDirPath)
      println("The last run on it is - ", todayLastRunPath)
      println("The last shot on it seems to be - ", potentialLastShot)
      println("The last shot number seems to be - ", potentialLastShotNumberString)
      println("To save in a this run incrementing the shot number press I ")
      println("To save in a new run press N ")
      answer = read(stdin, Char)
      #
      # fix run number and nex shot number
      #
      if answer == (I|i)
        # nextshot number if the incrment of potentialLastShotNumberInt64
        # by answering I or i
        # ...the user also confirms the last run was potentialLastRunNumber
        # ...and ...
        currentRunNumber = potentialLastRunNumber + 1
        nextShotNumber = 1

      elseif answer == (N|n)
        # create next run & nextshot number
        # by answering N or n...
        # ...the user also confirms the last run was potentialLastRunNumber
        # ...the user also confirms the last shot number was potentialLastShotNumberInt64
        # and ...
        currentRunNumber = potentialLastRunNumber
        nextShotNumber = potentialLastShotNumberInt64 + 1

      else
        println("FATAL ERROR -> invalid answer")
        return
      end
    end

    if length(potentialLastShot)<42
      # it seems today last run contains no shots with the correct name
      println("Today saving directory exists - ", todayDateDirPath)
      println("The last run on it is - ", todayLastRunPath)
      println("The last runs seems to be empty")
      println("To save in  this run incrementing the shot number press I ")
      println("To save in a new run press N ")
      answer = read(stdin, Char)
      #
      # fix run number and nex shot number
      #
      if answer == (I|i)
        # nextshot number if the incrment of potentialLastShotNumberInt64
        # by answering I or i
        # ...the user also confirms the last run was potentialLastRunNumber
        # ...and ...
        currentRunNumber = potentialLastRunNumber + 1
        nextShotNumber = 1

      elseif answer == (N|n)
        # create next run & nextshot number
        # by answering N or n...
        # ...the user also confirms the last run was potentialLastRunNumber
        # ...the user also confirms that yhere are no shots in the run
        # and ...
        currentRunNumber = potentialLastRunNumber
        nextShotNumber = 1
      else
        println("FATAL ERROR -> invalid answer")
        return
      end
    end

    # at this point we have defined...
    # ... currentRunNumber and nextShotNumber...
    # ... and we are ready to save the first shot

    println(" ")
    println(" ")
    println("CONGRATULATIONS ...  you are ready to save data ")
    println(" ")
    println("Current Run number is: ", currentRunNumber)
    println("Next Shot number is: ", nextShotNumber)
    println(" ")
    println("INSERT COMMAND -> Q(quit), R(raw data saving) , D(dual raw and picture saving ), E(educated saving)")
    userCommand1 = read(stdin, Char)
    if userCommand1 == (R|r)
      # save raw data only
      println("saving raw data only")
      #

      #
    elseif userCommand1 == (D|d)
      # save both raw data and scope picture
      println("saving raw data and scope picture")
      #

      #
    elseif userCommand1 == (E|e)
      # educated saving specal for interferometry
      println("Educated saving special for interferometry")
      #

      #
    elseif userCommand1 == (Q|q)
      # quiting
      println("quiting")
      return
      #
    else
      println("FATAL ERROR -> invalid userCommand1")
      return
    end
  end






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
  cc = a*aaa()+b*bbb()
  cc
end
