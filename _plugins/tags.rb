module Jekyll
  class RenderGistTag < Liquid::Tag

    def initialize(tag_name, gist_id, tokens)
      super
      @gist_id = gist_id.strip
    end

    def render(context)
      '<script src="https://gist.github.com/' +
        @gist_id +
        '.js?file=stopfinder.rb"></script>'
    end
  end
end

Liquid::Template.register_tag('gist', Jekyll::RenderGistTag)
