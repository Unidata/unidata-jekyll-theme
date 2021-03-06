module Jekyll
  class IncludeCodeBlockTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      arr = text.split("&")
      if arr.length < 3
        raise "Syntax error in includecodeblock: " + text
      else
        @projdir = arr[0].strip
        @path = arr[1].strip
        ext = /\.[a-zA-Z]+/ =~ @path
        @lang = @path[ext+1..-1]
        if arr.length < 4
          @function = arr[2].strip
          @startline = nil
          @endline = nil
        else
          @startline = arr[2].strip.to_i
          @endline = arr[3].strip.to_i
        end
      end
    end
    def render(context)
      # read file
      projdir = @projdir

      # finds last occurrence of '/projname' followed by '/' or end of string
      # e.g. "/home/runner/work/unidata-jekyll-theme[/unidata-jekyll-theme/]"
      # OR /home/runner/work/unidata-jekyll-theme[/unidata-jekyll-theme/]docs
      # OR /home/runner/work/unidata-jekyll-theme[/unidata-jekyll-theme]
      dirIndex = Dir.pwd.rindex(/\/#{projdir}(\/|$)/)
      projpath = Dir.pwd[0..dirIndex+1 + projdir.length]

      filestring = File.read File.join projpath, @path
      codestring = filestring

      # get start and stop lines
      startline = @startline
      endline = @endline

      if defined? @function
        # init function text
        codestring = ""
        # find function start
        startscan = /#{@function}\(.*\).*\{/m =~ filestring

        # find function end
        if startscan.nil?
          raise "Function name "+ @function + " not found in file " + File.basename(@path)
        else
          start = filestring.index("{", startscan)
          i = start
          brackets = ["{"]
          while brackets.length > 0
            i+=1
            c = filestring[i]
            if c == "{"
              brackets.push(c)
            elsif c == "}"
              brackets.pop
            end
          end

          codestring = filestring[start..i]
          startline = 1
          endline = -2
        end
      end
      # subset and format text
      text = format(codestring, startline, endline)

      # include the text annotated with code syntax
      "~~~" + @lang + "\n" + text + "\n~~~"
    end

    ##
    # left align code block
    def format(codestring, startline, endline)
      # uncomment insert tag
      insertTag = /\/\* INSERT .* \*\//
      codestring.gsub!(insertTag) {|s| s[10..-3]}
      # split code into line array and subset
      codelines = codestring.split("\n")[startline..endline]
      # remove lines with ignore tag
      ignoreTag = "/* DOCS-IGNORE */"
      codelines.select! { |s| !s.include? ignoreTag}
      # remove fixed num of tab characters from each line
      offset = /\S/ =~ codelines[0]
      codelines.map! { |s| s[offset..-1]}
      # join and return
      return  codelines.join("\n")
    end
  end
end
Liquid::Template.register_tag('includecodeblock', Jekyll::IncludeCodeBlockTag)
