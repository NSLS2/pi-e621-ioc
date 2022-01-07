TOP=../..

include $(TOP)/configure/CONFIG
#----------------------------------------
#  ADD MACRO DEFINITIONS AFTER THIS LINE
#=============================

#=============================
# Build the IOC application

PROD_IOC = pie621
# pie621.dbd will be created and installed
DBD += pie621.dbd

# pie621.dbd will be made up from these files:
pie621_DBD += base.dbd

# Include dbd files from all support applications:
pie621_DBD += asyn.dbd
pie621_DBD += drvAsynIPPort.dbd
pie621_DBD += drvAsynSerialPort.dbd # in case we need to go without a terminal server
pie621_DBD += motorSupport.dbd
pie621_DBD += motorRecord.dbd
pie621_DBD += pi3.dbd
pie621_DBD += asSupport.dbd

pie621_DBD += devIocStats.dbd
pie621_DBD += caPutLog.dbd
pie621_DBD += system.dbd
pie621_DBD += busySupport.dbd
pie621_DBD += calcSupport.dbd

pie621_LIBS += devIocStats
pie621_LIBS += caPutLog
pie621_LIBS += busy
pie621_LIBS += calc
pie621_LIBS += stream
# Add all the support libraries needed by this IOC
pie621_LIBS += motor pi3 asyn autosave

# pie621_registerRecordDeviceDriver.cpp derives from pie621.dbd
pie621_SRCS += pie621_registerRecordDeviceDriver.cpp

# Build the main IOC entry point on workstation OSs.
pie621_SRCS_DEFAULT += pie621Main.cpp
pie621_SRCS_vxWorks += -nil-

# Add support from base/src/vxWorks if needed
#pie621_OBJS_vxWorks += $(EPICS_BASE_BIN)/vxComLibrary

# Finally link to the EPICS Base libraries
pie621_LIBS += $(EPICS_BASE_IOC_LIBS)

#===========================

include $(TOP)/configure/RULES
#----------------------------------------
#  ADD RULES AFTER THIS LINE

