# Allows to generate HTML using a nice Ruby syntax. Takes care of whitespace,
# closing the tags properly and quoting attributes.
class HtmlBuilder
  def initialize
    @to_html = ""
  end
  
  def to_html
    @to_html
  end
  
  def p
    @to_html += "<p></p>"
  end
  
end
