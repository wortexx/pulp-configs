INSTALL_DIR ?= $(CURDIR)/install
BUILD_DIR   ?= $(CURDIR)/build

all: install

gen.usecases:
	./bin/pulp_usecase_gen --configs=$(CURDIR)/configs                     > configs/usecases/jtag.json

gen.pulp:
	./bin/pulp_soc_gen    --configs=$(CURDIR)/configs --template=configs/templates/pulp/soc.json --output=configs/chips/pulp/soc.json
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=pulp --usecase=usecases/jtag.json --output=configs/systems/pulp.json

gen.pulpissimo:
	./bin/pulp_soc_gen     --configs=$(CURDIR)/configs --template=configs/templates/pulpissimo/soc.json --output=configs/chips/pulpissimo/soc.json
	./bin/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo --output=configs/chips/pulpissimo/chip.json
	./bin/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo --output=configs/chips/pulpissimo/system.json
	./bin/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json --output=configs/systems/pulpissimo.json

gen.pulpissimo.zeroriscy:
	./bin/pulp_soc_gen     --configs=$(CURDIR)/configs --template=configs/templates/pulpissimo/soc-zeroriscy.json --output=configs/chips/pulpissimo/soc-zeroriscy.json
	./bin/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo --soc-file=soc-zeroriscy.json --output=configs/chips/pulpissimo/chip-zeroriscy.json
	./bin/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo --chip-file=chip-zeroriscy.json --output=configs/chips/pulpissimo/system-zeroriscy.json
	./bin/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json --system-file=system-zeroriscy.json --output=configs/systems/pulpissimo-zeroriscy.json

gen.pulpissimo.microriscy:
	./bin/pulp_soc_gen     --configs=$(CURDIR)/configs --template=configs/templates/pulpissimo/soc-microriscy.json --output=configs/chips/pulpissimo/soc-microriscy.json
	./bin/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo --soc-file=soc-microriscy.json --output=configs/chips/pulpissimo/chip-microriscy.json
	./bin/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo --chip-file=chip-microriscy.json --output=configs/chips/pulpissimo/system-microriscy.json
	./bin/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json --system-file=system-microriscy.json --output=configs/systems/pulpissimo-microriscy.json

gen.pulpissimo.riscy:
	./bin/pulp_soc_gen     --configs=$(CURDIR)/configs --template=configs/templates/pulpissimo/soc-riscy.json --output=configs/chips/pulpissimo/soc-riscy.json
	./bin/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=pulpissimo --soc-file=soc-riscy.json --output=configs/chips/pulpissimo/chip-riscy.json
	./bin/pulp_system_gen  --configs=$(CURDIR)/configs --chip=pulpissimo --chip-file=chip-riscy.json --output=configs/chips/pulpissimo/system-riscy.json
	./bin/pulp_top_gen     --configs=$(CURDIR)/configs --system=pulpissimo --usecase=usecases/jtag.json --system-file=system-riscy.json --output=configs/systems/pulpissimo-riscy.json

gen.wolfe:
	./bin/pulp_soc_gen     --configs=$(CURDIR)/configs --template=configs/templates/wolfe/soc.json --output=configs/chips/wolfe/soc.json
	./bin/pulp_chip_gen    --configs=$(CURDIR)/configs --chip=wolfe --output=configs/chips/wolfe/chip.json
	./bin/pulp_system_gen  --configs=$(CURDIR)/configs --chip=wolfe --output=configs/chips/wolfe/system.json
	./bin/pulp_top_gen     --configs=$(CURDIR)/configs --system=wolfe --usecase=usecases/jtag.json --output=configs/systems/wolfe.json

gen.oprecompkw:
	./bin/pulp_soc_gen --configs=$(CURDIR)/configs --template=configs/templates/oprecompkw/soc.json --output=configs/chips/oprecompkw/soc.json
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=oprecompkw --output=configs/systems/oprecompkw.json

gen.vega:
	./bin/pulp_soc_gen --configs=$(CURDIR)/configs --template=configs/templates/vega/soc.json --output=configs/chips/vega/soc.json
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=vega --output=configs/systems/vega.json

gen.gap:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=gap --usecase=usecases/jtag.json --output=configs/systems/gap.json

gen.vivosoc3:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=vivosoc3   --output=configs/systems/vivosoc3.json

gen.bigpulp:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=bigpulp    --output=configs/systems/bigpulp.json

gen.fulmine:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=fulmine    --output=configs/systems/fulmine.json

gen.hero-zc706:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=hero-zc706 --output=configs/systems/hero-zc706.json

gen.honey:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=honey      --output=configs/systems/honey.json

gen.multino:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=multino    --output=configs/systems/multino.json

gen.neuraghe:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=neuraghe   --output=configs/systems/neuraghe.json

gen.quentin:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=quentin    --output=configs/systems/quentin.json

gen.vivosoc2_1:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=vivosoc2_1 --output=configs/systems/vivosoc2_1.json

gen.vivosoc2:
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=vivosoc2   --output=configs/systems/vivosoc2.json

gen: gen.usecases gen.pulp gen.pulpissimo gen.pulpissimo.zeroriscy gen.pulpissimo.microriscy \
  gen.pulpissimo.riscy gen.wolfe gen.oprecompkw gen.vega gen.gap gen.vivosoc3 gen.bigpulp \
  gen.fulmine gen.hero-zc706 gen.honey gen.multino gen.neuraghe \
  gen.quentin gen.vivosoc2_1 gen.vivosoc2

INSTALL_FILES += $(shell find configs -name "*.json")
INSTALL_FILES += $(shell find bin -name "pulp_*")
INSTALL_FILES += $(shell find bin -name "*.py")


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
