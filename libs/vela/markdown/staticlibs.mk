
VELA_MARKDOWN_ML_CSOURCES=$(wildcard $(ROOPKOTHA_VELA_HOME)/libs/vela/markdown/vsrc/*.c)
VELA_MARKDOWN_ML_VSOURCE_BASE=$(basename $(notdir $(VELA_MARKDOWN_ML_CSOURCES)))
OBJECTS+=$(addprefix $(ROOPKOTHA_VELA_HOME)$(OBJDIR_COMMON)/, $(addsuffix .o,$(VELA_MARKDOWN_ML_VSOURCE_BASE)))

