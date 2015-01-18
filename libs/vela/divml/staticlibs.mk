
VELADIV_CSOURCES=$(wildcard $(ROOPKOTHA_VELA_HOME)/libs/vela/divml/vsrc/*.c)
VELADIV_VSOURCE_BASE=$(basename $(notdir $(VELADIV_CSOURCES)))
OBJECTS+=$(addprefix $(ROOPKOTHA_VELA_HOME)$(OBJDIR_COMMON)/, $(addsuffix .o,$(VELADIV_VSOURCE_BASE)))

