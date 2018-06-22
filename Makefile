INSTALL_DIR ?= $(CURDIR)/install
BUILD_DIR   ?= $(CURDIR)/build

all: install

gen.usecases:
	./bin/pulp_usecase_gen --configs=$(CURDIR)/configs --output=configs/usecases/jtag.json

gen.pulp:
	./bin/pulp_config_gen --configs=$(CURDIR)/configs --template=templates/chips/pulp.json --output-dir=$(CURDIR)/configs/chips/pulp --output=configs/systems/pulp.json

gen.multino:
	./bin/pulp_config_gen --configs=$(CURDIR)/configs --template=templates/chips/multino.json --output-dir=$(CURDIR)/configs/chips/multino --output=configs/systems/multino.json

gen.pulpissimo:
	./bin/pulp_config_gen --configs=$(CURDIR)/configs --template=templates/chips/pulpissimo.json --output-dir=$(CURDIR)/configs/chips/pulpissimo --output=configs/systems/pulpissimo.json

gen.pulpissimo.zeroriscy:
	./bin/pulp_config_gen --configs=$(CURDIR)/configs --template=templates/chips/pulpissimo-zeroriscy.json --output-dir=$(CURDIR)/configs/chips/pulpissimo-zeroriscy --output=configs/systems/pulpissimo-zeroriscy.json

gen.pulpissimo.microriscy:
	./bin/pulp_config_gen --configs=$(CURDIR)/configs --template=templates/chips/pulpissimo-microriscy.json --output-dir=$(CURDIR)/configs/chips/pulpissimo-microriscy --output=configs/systems/pulpissimo-microriscy.json

gen.pulpissimo.riscy:
	./bin/pulp_config_gen --configs=$(CURDIR)/configs --template=templates/chips/pulpissimo-riscy.json --output-dir=$(CURDIR)/configs/chips/pulpissimo-riscy --output=configs/systems/pulpissimo-riscy.json

gen.wolfe:
	./bin/pulp_config_gen --configs=$(CURDIR)/configs --template=templates/chips/wolfe.json --output-dir=$(CURDIR)/configs/chips/wolfe --output=configs/systems/wolfe.json

gen.oprecompkw:
	./bin/pulp_soc_gen --configs=$(CURDIR)/configs --template=templates/chips/oprecompkw.json --output=configs/chips/oprecompkw/soc.json
	./bin/pulp_top_gen --configs=$(CURDIR)/configs --system=oprecompkw --output=configs/systems/oprecompkw.json

gen.vega:
	./bin/pulp_soc_gen --configs=$(CURDIR)/configs --template=templates/chips/vega.json --output=configs/chips/vega/soc.json
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
