INSTALL_DIR ?= $(CURDIR)/install
BUILD_DIR   ?= $(CURDIR)/build

all: install
	
gen:
	./generators/pulp_usecase_gen --configs=$(CURDIR)/configs                     > configs/usecases/jtag.json

	./generators/pulp_soc_gen    --configs=$(CURDIR)/configs --chip=pulp          > configs/chips/pulp/soc.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=pulp --usecase=usecases/jtag.json         > configs/systems/pulp.json

	./generators/pulp_soc_gen     --configs=$(CURDIR)/configs --chip=wolfe   > configs/chips/wolfe/soc.json
	./generators/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=wolfe   > configs/chips/wolfe/chip.json
	./generators/pulp_system_gen  --configs=$(CURDIR)/configs --chip=wolfe   > configs/chips/wolfe/system.json
	./generators/pulp_top_gen     --configs=$(CURDIR)/configs --system=wolfe --usecase=usecases/jtag.json > configs/systems/wolfe.json

	./generators/pulp_soc_gen     --configs=$(CURDIR)/configs --chip=pulpissimo   > configs/chips/pulpissimo/soc.json
	./generators/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo   > configs/chips/pulpissimo/chip.json
	./generators/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo   > configs/chips/pulpissimo/system.json
	./generators/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json > configs/systems/pulpissimo.json

	./generators/pulp_soc_gen     --configs=$(CURDIR)/configs --chip=pulpissimo --fc-core=zeroriscy                   > configs/chips/pulpissimo/soc-zeroriscy.json
	./generators/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo --soc-file=soc-zeroriscy.json         > configs/chips/pulpissimo/chip-zeroriscy.json
	./generators/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo --chip-file=chip-zeroriscy.json       > configs/chips/pulpissimo/system-zeroriscy.json
	./generators/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json --system-file=system-zeroriscy.json > configs/systems/pulpissimo-zeroriscy.json

	./generators/pulp_soc_gen     --configs=$(CURDIR)/configs --chip=pulpissimo --fc-core=microriscy                   > configs/chips/pulpissimo/soc-microriscy.json
	./generators/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo --soc-file=soc-microriscy.json         > configs/chips/pulpissimo/chip-microriscy.json
	./generators/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo --chip-file=chip-microriscy.json       > configs/chips/pulpissimo/system-microriscy.json
	./generators/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json --system-file=system-microriscy.json > configs/systems/pulpissimo-microriscy.json

	./generators/pulp_soc_gen     --configs=$(CURDIR)/configs --chip=pulpissimo --fc-core=ri5ky_v2                 > configs/chips/pulpissimo/soc-riscy.json
	./generators/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo --soc-file=soc-riscy.json         > configs/chips/pulpissimo/chip-riscy.json
	./generators/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo --chip-file=chip-riscy.json       > configs/chips/pulpissimo/system-riscy.json
	./generators/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json --system-file=system-riscy.json > configs/systems/pulpissimo-riscy.json

	./generators/pulp_soc_gen --configs=$(CURDIR)/configs --chip=oprecompkw    > configs/chips/oprecompkw/soc.json

	./generators/pulp_soc_gen --configs=$(CURDIR)/configs --chip=vega          > configs/chips/vega/soc.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=vega        > configs/systems/vega.json

	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=gap         --usecase=usecases/jtag.json > configs/systems/gap.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=wolfe       --usecase=usecases/jtag.json > configs/systems/wolfe.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=vivosoc3    > configs/systems/vivosoc3.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=bigpulp     > configs/systems/bigpulp.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=fulmine     > configs/systems/fulmine.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=hero-zc706  > configs/systems/hero-zc706.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=honey       > configs/systems/honey.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=multino     > configs/systems/multino.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=neuraghe    > configs/systems/neuraghe.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=oprecompkw  > configs/systems/oprecompkw.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=quentin     > configs/systems/quentin.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=vivosoc2_1  > configs/systems/vivosoc2_1.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=vivosoc2    > configs/systems/vivosoc2.json


INSTALL_FILES += $(shell find configs -name *.json)
INSTALL_FILES += $(shell find generators -name pulp_*)
INSTALL_FILES += $(shell find generators -name *.py)


define declareInstallFile

$(INSTALL_DIR)/$(1): $(1)
	install -D $(1) $$@

INSTALL_HEADERS += $(INSTALL_DIR)/$(1)

endef

$(foreach file, $(INSTALL_FILES), $(eval $(call declareInstallFile,$(file))))


install: $(INSTALL_HEADERS)

# This file is a dummy one that is updated as soon as one of the tools file is updated
# This is used to trigger automatic application recompilation
$(PULP_SDK_INSTALL)/rules/tools.mk: $(INSTALL_HEADERS)
	@mkdir -p `dirname $@`
	touch $@

header: $(PULP_SDK_INSTALL)/rules/tools.mk
