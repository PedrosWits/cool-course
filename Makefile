################################################
#
#
#               Le Makefile
#
#
################################################
#   Author:
#
#          Pedro Pinto da Silva
#           p.pinto-da-silva@newcastle.ac.uk
#
################################################

BUILD_DIR              := build
SRC_DIR								 := docs

COURSEWORK_DIR         := coursework
SLIDES_DIR             := slides

IMAGES_DIR             := images
EXTENSIONS_DIR         := extensions
STYLESHEETS_DIR        := stylesheets

COURSEWORK_INPUT       := $(wildcard $(SRC_DIR)/$(COURSEWORK_DIR)/*.adoc)
SLIDES_INPUT           := $(wildcard $(SRC_DIR)/$(SLIDES_DIR)/*.md)
GENERIC_INPUT          := $(wildcard $(SRC_DIR)/*.adoc)

COURSEWORK_OUTPUT      := $(patsubst $(SRC_DIR)/$(COURSEWORK_DIR)/%.adoc, \
                                     $(BUILD_DIR)/$(COURSEWORK_DIR)/%.html, \
                                     $(COURSEWORK_INPUT))

SLIDES_OUTPUT          := $(patsubst $(SRC_DIR)/$(SLIDES_DIR)/%.md, \
                                     $(BUILD_DIR)/$(SLIDES_DIR)/%, \
																		 $(SLIDES_INPUT))

GENERIC_OUTPUT         := $(patsubst $(SRC_DIR)/%.adoc, \
                                     $(BUILD_DIR)/%.html, \
                                     $(GENERIC_INPUT))
#

EXTENSIONS             := ./$(EXTENSIONS_DIR)/*.rb
STYLESHEET             := golo.css

ASC_FLAG_COURSEWORK    := -a stylesheet=../../stylesheets/$(STYLESHEET)
ASC_FLAG_GENERIC       := -a stylesheet=../stylesheets/$(STYLESHEET)

ASCIIDOCTOR_FLAGS      := -r $(EXTENSIONS) \
                          -b html5 \
                          -R $(SRC_DIR) \
                          -D $(BUILD_DIR)

REVEALMD_FLAGS         := --static__site \
                          --static_dirs=$(SRC_DIR)/$(IMAGES_DIR)

#

# asciidoctor command
define asciidoctor-call-coursework
asciidoctor $(ASC_FLAG_COURSEWORK) \
            $(ASCIIDOCTOR_FLAGS) \
            $<
endef

define asciidoctor-call-generic
asciidoctor $(ASC_FLAG_GENERIC) \
            $(ASCIIDOCTOR_FLAGS) \
            $<
endef

# building adoc files into html files
$(BUILD_DIR)/$(COURSEWORK_DIR)/%.html : $(SRC_DIR)/$(COURSEWORK_DIR)/%.adoc
	$(asciidoctor-call-coursework)

$(BUILD_DIR)/%.html : $(SRC_DIR)/%.adoc
	$(asciidoctor-call-generic)


# revealmd command
define revealmd-call
reveal-md $(REVEALMD_FLAGS) \
          --static=./$@ \
          $<
endef

# building adoc files into html files
$(BUILD_DIR)/$(SLIDES_DIR)/% : $(SRC_DIR)/$(SLIDES_DIR)/%.md
	$(revealmd-call)

# stylesheets
$(STYLESHEETS_DIR) :
	@[ ! -d "./$(STYLESHEETS_DIR)" ] \
		&& echo "Installing stylesheets....." && \
		git clone https://github.com/asciidoctor/asciidoctor-stylesheet-factory && \
		cd asciidoctor-stylesheet-factory && \
		bundle install && \
		compass compile && \
		mv stylesheets ../$(STYLESHEETS_DIR) && \
		cd .. && \
		rm -rf asciidoctor-stylesheet-factory \
		||	echo "./$(STYLESHEETS_DIR) exists. Skipping....." \

################################################
#
#
#               Phonies
#
#
################################################


all: install html

install:
	@echo "Installing asciidoctor....." && \
	gem install asciidoctor compass && \
	echo "Installing reveal-md locally....." && \
	npm install

styles: $(STYLESHEETS_DIR)

dirs:
	mkdir -p $(BUILD_DIR) $(BUILD_DIR)/$(SLIDES_DIR) $(BUILD_DIR)/$(COURSEWORK_DIR)

images:
	cp -r $(SRC_DIR)/$(IMAGES_DIR) $(BUILD_DIR)/$(IMAGES_DIR)

index:
	@echo "<meta http-equiv=\"refresh\" content=\"0; URL=overview.html\" />" > $(BUILD_DIR)/index.html

html: dirs \
			styles \
	    images \
			$(SLIDES_OUTPUT) \
			$(COURSEWORK_OUTPUT) \
			$(GENERIC_OUTPUT) \
			index


clean :
	@echo "Cleaning up....."; \
	rm -rf $(BUILD_DIR) $(STYLESHEETS_DIR) node_modules package-lock.json

debug:
	@echo "slides - input:\n\t$(SLIDES_INPUT)" && \
	echo "slides - output:\n\t$(SLIDES_OUTPUT)" && \
	echo "coursework - input:\n\t$(COURSEWORK_INPUT)" && \
	echo "coursework - output:\n\t$(COURSEWORK_OUTPUT)" && \
	echo "generic - input:\n\t$(GENERIC_INPUT)" && \
	echo "generic - output:\n\t$(GENERIC_OUTPUT)" && \
	echo "command:\n\t$(asciidoctor-call-coursework) FILENAME" && \
	echo "command:\n\t$(revealmd-call) FILENAME" && \
	echo "command:\n\t$(asciidoctor-call-generic) FILENAME"

.PHONY: all install styles dirs images index html clean debug
