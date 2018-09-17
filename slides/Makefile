################################################
#
#
# 							Le Makefile
#
#
################################################
# 	Author:
#
#					Pedro Pinto da Silva
#			 		p.pinto-da-silva@newcastle.ac.uk
#
################################################

BUILD_DIR 						:= build

DOCS_DIR 							:= docs
IMAGES_DIR 						:= images

MARKDOWN							:= $(wildcard $(DOCS_DIR)/*.md)
HTML_SLIDES						:= $(patsubst $(DOCS_DIR)/%.md,$(BUILD_DIR)/%, $(MARKDOWN))

REVEALMD_FLAGS 				:= --static__site --static_dirs=$(IMAGES_DIR)

# asciidoctor command
define revealmd-call
reveal-md $(REVEALMD_FLAGS) --static=./$@ $<
endef

# building adoc files into html files
$(BUILD_DIR)/% : $(DOCS_DIR)/%.md
	$(revealmd-call)

################################################
#
#
# 							Phonies
#
#
################################################


all: install slides

install:
	@echo "Installing reveal-md locally....."; \
	npm install

dirs:
	mkdir -p $(BUILD_DIR)

slides: dirs $(HTML_SLIDES)

clean :
	@echo "Cleaning up....."; \
	rm -rf $(BUILD_DIR) node_modules package-lock.json

debug:
	@echo "source docs:\n\t$(MARKDOWN)" && \
	echo "target docs:\n\t$(HTML_SLIDES)" && \
	echo "command:\n\t$(revealmd-call) FILENAME"

.PHONY: all install dirs slides clean debug
