module Jekyll
  class Annotation < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @text = text.strip
    end
    def render(context)
      "<i class=\"code-annotation\" annotation-number=\"" + @text + "\"></i>"
    end
  end
end
Liquid::Template.register_tag('annotation', Jekyll::Annotation)