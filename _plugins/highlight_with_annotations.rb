module Jekyll
  class HighlightWithAnnotationsBlock < Jekyll::Tags::HighlightBlock

    def initialize(tag_name, markup, tokens)
      super
    end

    def render(context)
      # apply syntax highlighting to code block
      # {% raw %}{% annotation XX %}{% endraw %} -> {% annotation XX %}
      content = super
      # pass through parser again to pickup {% annotation XX %} now that
      # it is no longer surrounded by {% raw %}/{% endraw %}
      @template = Liquid::Template.parse(content)
      @template.render
    end
  end
end
Liquid::Template.register_tag('highlight_with_annotations', Jekyll::HighlightWithAnnotationsBlock)