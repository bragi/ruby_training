# Allows to generate HTML using a nice Ruby syntax. Takes care of whitespace,
# closing the tags properly and quoting attributes.
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
