#!../../bin/linux-x86_64/pie621

epicsEnvSet("ENGINEER",  "C. Engineer")
epicsEnvSet("LOCATION",  "740 HXN RGA 1")

epicsEnvSet("IOCNAME",   "pi-vms")
epicsEnvSet("SYS",       "XF:09IDA-OP:1")
epicsEnvSet("PI_PORT",   "PI_VMS")
epicsEnvSet("IOC_SYS",   "XF:09IDA-OP:1")
epicsEnvSet("IOC_DEV",   "{IOC:$(IOCNAME)}")

< envPaths
< /epics/common/xf09id1-ioc1-netsetup.cmd

## Register all support components
dbLoadDatabase("../../dbd/pie621.dbd",0,0)
pie621_registerRecordDeviceDriver(pdbbase) 

drvAsynIPPortConfigure("P0", "xf09id1-tsrv6.nsls2.bnl.gov:4001")
# asynSetTraceMask("P0", -1, 0x9)
# asynSetTraceIOMask("P0", -1, 0x2)

E816CreateController("$(PI_PORT)", "P0", 1, 50)

## Load record instances
dbLoadTemplate("${TOP}/db/motors.substitutions", "PP=$(SYS),PI_PORT=$(PI_PORT)")
dbLoadRecords("$(TOP)/db/asynComm.db","P=$(IOC_SYS)$(IOC_DEV),PORT=P0,ADDR=0")

dbLoadRecords("$(DEVIOCSTATS)/db/iocAdminSoft.db", "IOC=$(IOC_SYS)$(IOC_DEV)")
dbLoadRecords("$(AUTOSAVE)/db/save_restoreStatus.db", "P=$(IOC_SYS)$(IOC_DEV)")
dbLoadRecords("${RECCASTER}/db/reccaster.db", "P=${IOC_SYS}$(IOC_DEV)RecSync")

## autosave/restore machinery
save_restoreSet_Debug(0)
save_restoreSet_IncompleteSetsOk(1)
save_restoreSet_DatedBackupFiles(1)

set_savefile_path("${TOP}/as","/save")
set_requestfile_path("${TOP}/as","/req")

system("install -m 777 -d ${TOP}/as/save")
system("install -m 777 -d ${TOP}/as/req")

set_pass0_restoreFile("info_positions.sav")
set_pass0_restoreFile("info_settings.sav")
set_pass1_restoreFile("info_settings.sav")

save_restoreSet_status_prefix("$(IOC_SYS)$(IOC_DEV)")

iocInit()

# caPutLogInit("ioclog.cs.nsls2.local:7004", 1)

## more autosave/restore machinery
cd ${TOP}/as/req
makeAutosaveFiles()
create_monitor_set("info_positions.req", 5 , "")
create_monitor_set("info_settings.req", 15 , "")

cd ${TOP}
dbl > ./records.dbl
