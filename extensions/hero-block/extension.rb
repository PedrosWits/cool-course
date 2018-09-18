require 'asciidoctor/extensions'

include Asciidoctor

class HeroAdmonitionBlock < Extensions::BlockProcessor
  use_dsl
  named :HERO
  on_contexts :example, :paragraph

  def process parent, reader, attrs
    attrs['name'] = 'hero'
    attrs['caption'] = 'From Zero to Hero'
    create_block parent, :admonition, reader.lines, attrs, content_model: :compound
  end
end

class HeroAdmonitionBlockDocinfo < Extensions::DocinfoProcessor
  use_dsl

  def process doc
    '<style>
.admonitionblock td.icon .icon-hero:before {content:"\f64";color:#871452;}
</style>'
  end
end
