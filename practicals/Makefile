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
HTML_BUILD_DIR 				:= $(BUILD_DIR)/html
PDF_BUILD_DIR 				:= $(BUILD_DIR)/pdf

DOCS_DIR 							:= docs
IMAGES_DIR 						:= images
EXTENSIONS_DIR 				:= extensions
STYLESHEETS_DIR				:= stylesheets

DOCS									:= $(wildcard $(DOCS_DIR)/*.adoc)
HTML_DOCS							:= $(patsubst $(DOCS_DIR)/%.adoc,$(HTML_BUILD_DIR)/%.html, $(DOCS))

EXTENSIONS 						:= ./$(EXTENSIONS_DIR)/*.rb
STYLESHEET 						:= golo.css
ASCIIDOCTOR_FLAGS 		:= -a stylesheet=../stylesheets/$(STYLESHEET) -r $(EXTENSIONS) -b html5 -R $(DOCS_DIR) -D $(HTML_BUILD_DIR)

# asciidoctor command
define asciidoctor-call
asciidoctor $(ASCIIDOCTOR_FLAGS) $<
endef

# building adoc files into html files
$(HTML_BUILD_DIR)/%.html : $(DOCS_DIR)/%.adoc
	$(asciidoctor-call)

################################################
#
#
# 							Phonies
#
#
################################################


all: install stylesheets html

install:
	@echo "Installing asciidoctor....."; \
	gem install asciidoctor

stylesheets:
	@echo "Installing stylesheets....."; \
	git clone https://github.com/asciidoctor/asciidoctor-stylesheet-factory && \
	cd asciidoctor-stylesheet-factory && \
	bundle install && \
	compass compile && \
	mv stylesheets ../$(STYLESHEETS_DIR) && \
	cd .. && \
	rm -rf asciidoctor-stylesheet-factory

dirs:
	mkdir -p $(BUILD_DIR) $(HTML_BUILD_DIR) $(PDF_BUILD_DIR)

images:
	cp -r $(IMAGES_DIR) $(HTML_BUILD_DIR)/$(IMAGES_DIR)

html: dirs images $(HTML_DOCS)

clean :
	@echo "Cleaning up....."; \
	rm -rf $(BUILD_DIR) $(STYLESHEETS_DIR)

debug:
	@echo "source docs:\n\t$(DOCS)" && \
	echo "target docs:\n\t$(HTML_DOCS)" && \
	echo "command:\n\t$(asciidoctor-call) FILENAME"

.PHONY: all install stylesheets dirs images html clean debug
