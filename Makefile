gen:
	./generators/pulp_soc_gen --chip=pulp             > configs/chips/pulp/soc.json
	./generators/pulp_soc_gen --chip=pulpissimo       > configs/chips/pulpissimo/soc.json
	./generators/pulp_soc_gen --chip=oprecompkw       > configs/chips/oprecompkw/soc.json
	./generators/pulp_soc_gen --chip=vega             > configs/chips/vega/soc.json

	./generators/pulp_usecase_gen                     > configs/usecases/jtag.json

	./generators/pulp_system_gen --system=pulp        > configs/systems/pulp.json
	./generators/pulp_system_gen --system=pulpissimo  > configs/systems/pulpissimo.json
	./generators/pulp_system_gen --system=gap         > configs/systems/gap.json
	./generators/pulp_system_gen --system=wolfe       > configs/systems/wolfe.json
	./generators/pulp_system_gen --system=vega        > configs/systems/vega.json


INSTALL_FILES += $(shell find configs -name *.json)
INSTALL_FILES += $(shell find generators -name pulp_*)
INSTALL_FILES += $(shell find generators -name *.py)


define declareInstallFile

$(PULP_SDK_WS_INSTALL)/$(1): $(1)
	install -D $(1) $$@

INSTALL_HEADERS += $(PULP_SDK_WS_INSTALL)/$(1)

endef

$(foreach file, $(INSTALL_FILES), $(eval $(call declareInstallFile,$(file))))


install: $(INSTALL_HEADERS)
