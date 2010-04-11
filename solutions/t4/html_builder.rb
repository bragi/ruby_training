# Allows to generate HTML using a nice Ruby syntax. Takes care of closing the
# tags properly.
#
# Example usage:
#
#    html = HtmlBuilder.new("html")
#    html.head do |html|
#      head.title "Hello World!"
#    end
#    html.body do |body|
#      body.h1 "Hello World!"
#      body.p do |p|
#        p.text "Hello "
#        p.strong "everybody"
#        p.text "!"
#      end
#    end
class HtmlBuilder
  def initialize(name=nil)
    @name = name
    @tags = []
  end
  
  def to_s
    nested_tags = @tags.map {|t| t.to_s}
    start = "<#{@name}>" if @name
    finish = "</#{@name}>" if @name
    [start, nested_tags, finish].compact.join
  end
  
  def text(text)
    @tags << text
  end
  
  def tag(name, text=nil)
    tag = HtmlBuilder.new(name)
    tag.text text if text
    yield tag if block_given?
    @tags << tag
  end
  
  %w(body h1 head html p strong title).each do |t|
    eval <<-METHOD
      def #{t}(text=nil, &block)
        tag("#{t}", text, &block)
      end
METHOD
  end
end
