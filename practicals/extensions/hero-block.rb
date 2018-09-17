RUBY_ENGINE == 'opal' ?
  (require 'hero-block/extension') :
  (require_relative 'hero-block/extension')

Extensions.register do
  block HeroAdmonitionBlock
  docinfo_processor HeroAdmonitionBlockDocinfo
end
