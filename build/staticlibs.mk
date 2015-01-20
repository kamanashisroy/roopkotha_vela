
PROJECT_OBJDIR=$(ROOPKOTHA_VELA_HOME)$(OBJDIR_COMMON)/
#LIBS+=-lm
include $(ROOPKOTHA_HOME)/$(PLATFORM)/platform_gui/staticlibs.mk
include $(ROOPKOTHA_HOME)/libs/gui/staticlibs.mk
include $(ROOPKOTHA_HOME)/libs/listview/staticlibs.mk
include $(ROOPKOTHA_HOME)/libs/rtree/staticlibs.mk
include $(ROOPKOTHA_VELA_HOME)/libs/doc/staticlibs.mk
include $(ROOPKOTHA_VELA_HOME)/libs/vela/staticlibs.mk
include $(ROOPKOTHA_VELA_HOME)/libs/vela/richml/staticlibs.mk
include $(ROOPKOTHA_VELA_HOME)/libs/vela/divml/staticlibs.mk
include $(ROOPKOTHA_VELA_HOME)/libs/vela/markdown/staticlibs.mk
include $(ROOPKOTHA_VELA_HOME)/libs/vela/coordinator/staticlibs.mk
include $(ROOPKOTHA_VELA_HOME)/libs/vela/handler/staticlibs.mk
include $(ROOPKOTHA_VELA_HOME)/libs/vela/menu/staticlibs.mk
include $(ONUBODH_HOME)/transform/strtrans/staticlibs.mk
include $(ONUBODH_HOME)/libs/xmlparser/staticlibs.mk
include $(ONUBODH_HOME)/libs/markdownparser/staticlibs.mk
include $(SHOTODOL_HOME)/libs/spinningwheel/staticlibs.mk
include $(SHOTODOL_HOME)/libs/iterator/staticlibs.mk
include $(SHOTODOL_HOME)/$(PLATFORM)/platform_fileutils/staticlibs.mk
include $(SHOTODOL_SCRIPT_HOME)/build/staticlibs.mk
#include $(SHOTODOL_HOME)/$(PLATFORM)/lua/staticlibs.mk
