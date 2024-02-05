INC=snippets
CPP=cpp
MAKED=make.d
PAGED=pages
OUTPUT=build

PAGES=$(wildcard $(PAGED)/**/*.html $(PAGED)/*html)

RES=$(PAGES:$(PAGED)/%=$(OUTPUT)/%)
DEPS=$(PAGES:$(PAGED)/%.html=$(MAKED)/%.d)

all: deps $(RES)
deps: $(DEPS)
clean:
	rm -fr ./$(OUTPUT)/*
	rm -fr ./$(MAKED)/*

$(MAKED)/%.d: $(PAGED)/%.html
	mkdir -p `dirname $@`
	$(CPP) -I $(INC) -MM -MQ $@ -MQ $(@:$(MAKED)/%.d=$(OUTPUT)/%.html) -MF $@ $<

-include $(DEPS)

$(OUTPUT)/%.html: $(PAGED)/%.html
	mkdir -p `dirname $@`
	$(CPP) -CC -P -nostdinc -I $(INC) $< -o $@
.PHONY: all deps clean
