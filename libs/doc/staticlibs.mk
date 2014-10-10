
ROOPDOC_CSOURCES=$(wildcard $(ROOPKOTHA_VELA_HOME)/libs/doc/vsrc/*.c)
ROOPDOC_VSOURCE_BASE=$(basename $(notdir $(ROOPDOC_CSOURCES)))
OBJECTS+=$(addprefix $(ROOPKOTHA_VELA_HOME)$(OBJDIR_COMMON)/, $(addsuffix .o,$(ROOPDOC_VSOURCE_BASE)))

