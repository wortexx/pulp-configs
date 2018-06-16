INSTALL_DIR ?= $(CURDIR)/install
BUILD_DIR   ?= $(CURDIR)/build

all: install

gen.usecases:
	./generators/pulp_usecase_gen --configs=$(CURDIR)/configs                     > configs/usecases/jtag.json

gen.pulp:
	./generators/pulp_soc_gen    --configs=$(CURDIR)/configs --template=templates/pulp/soc.json --output=configs/chips/pulp/soc.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=pulp --usecase=usecases/jtag.json         > configs/systems/pulp.json

gen.pulpissimo:
	./generators/pulp_soc_gen     --configs=$(CURDIR)/configs --template=templates/pulpissimo/soc.json --output=configs/chips/pulpissimo/soc.json
	./generators/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo   > configs/chips/pulpissimo/chip.json
	./generators/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo   > configs/chips/pulpissimo/system.json
	./generators/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json > configs/systems/pulpissimo.json

gen.pulpissimo.zeroriscy:
	./generators/pulp_soc_gen     --configs=$(CURDIR)/configs --template=templates/pulpissimo/soc-zeroriscy.json --output=configs/chips/pulpissimo/soc-zeroriscy.json
	./generators/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo --soc-file=soc-zeroriscy.json         > configs/chips/pulpissimo/chip-zeroriscy.json
	./generators/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo --chip-file=chip-zeroriscy.json       > configs/chips/pulpissimo/system-zeroriscy.json
	./generators/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json --system-file=system-zeroriscy.json > configs/systems/pulpissimo-zeroriscy.json

gen.pulpissimo.microriscy:
	./generators/pulp_soc_gen     --configs=$(CURDIR)/configs --template=templates/pulpissimo/soc-microriscy.json --output=configs/chips/pulpissimo/soc-microriscy.json
	./generators/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo --soc-file=soc-microriscy.json         > configs/chips/pulpissimo/chip-microriscy.json
	./generators/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo --chip-file=chip-microriscy.json       > configs/chips/pulpissimo/system-microriscy.json
	./generators/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json --system-file=system-microriscy.json > configs/systems/pulpissimo-microriscy.json

gen.pulpissimo.riscy:
	./generators/pulp_soc_gen     --configs=$(CURDIR)/configs --template=templates/pulpissimo/soc-riscy.json --output=configs/chips/pulpissimo/soc-riscy.json
	./generators/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo --soc-file=soc-riscy.json         > configs/chips/pulpissimo/chip-riscy.json
	./generators/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo --chip-file=chip-riscy.json       > configs/chips/pulpissimo/system-riscy.json
	./generators/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json --system-file=system-riscy.json > configs/systems/pulpissimo-riscy.json

gen.wolfe:
	./generators/pulp_soc_gen     --configs=$(CURDIR)/configs --template=templates/wolfe/soc.json --output=configs/chips/wolfe/soc.json
	./generators/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=wolfe   > configs/chips/wolfe/chip.json
	./generators/pulp_system_gen  --configs=$(CURDIR)/configs --chip=wolfe   > configs/chips/wolfe/system.json
	./generators/pulp_top_gen     --configs=$(CURDIR)/configs --system=wolfe --usecase=usecases/jtag.json > configs/systems/wolfe.json

gen.oprecompkw:
	./generators/pulp_soc_gen --configs=$(CURDIR)/configs --template=templates/oprecompkw/soc.json --output=configs/chips/oprecompkw/soc.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=oprecompkw  > configs/systems/oprecompkw.json

gen.vega:
	./generators/pulp_soc_gen --configs=$(CURDIR)/configs --template=templates/vega/soc.json --output=configs/chips/vega/soc.json
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=vega        > configs/systems/vega.json

gen.gap:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=gap         --usecase=usecases/jtag.json > configs/systems/gap.json

gen.vivosoc3:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=vivosoc3    > configs/systems/vivosoc3.json

gen.bigpulp:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=bigpulp     > configs/systems/bigpulp.json

gen.fulmine:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=fulmine     > configs/systems/fulmine.json

gen.hero-zc706:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=hero-zc706  > configs/systems/hero-zc706.json

gen.honey:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=honey       > configs/systems/honey.json

gen.multino:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=multino     > configs/systems/multino.json

gen.neuraghe:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=neuraghe    > configs/systems/neuraghe.json

gen.quentin:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=quentin     > configs/systems/quentin.json

gen.vivosoc2_1:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=vivosoc2_1  > configs/systems/vivosoc2_1.json

gen.vivosoc2:
	./generators/pulp_top_gen --configs=$(CURDIR)/configs --system=vivosoc2    > configs/systems/vivosoc2.json

gen: gen.usecases gen.pulp gen.pulpissimo gen.pulpissimo.zeroriscy gen.pulpissimo.microriscy \
  gen.pulpissimo.riscy gen.wolfe gen.oprecompkw gen.vega gen.gap gen.vivosoc3 gen.bigpulp \
  gen.fulmine gen.hero-zc706 gen.honey gen.multino gen.neuraghe \
  gen.quentin gen.vivosoc2_1 gen.vivosoc2

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
