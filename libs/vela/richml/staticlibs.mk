
VELATML_CSOURCES=$(wildcard $(ROOPKOTHA_VELA_HOME)/libs/vela/richml/vsrc/*.c)
VELATML_VSOURCE_BASE=$(basename $(notdir $(VELATML_CSOURCES)))
OBJECTS+=$(addprefix $(ROOPKOTHA_VELA_HOME)$(OBJDIR_COMMON)/, $(addsuffix .o,$(VELATML_VSOURCE_BASE)))

