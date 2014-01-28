class XMLParser
  require 'rexml/document'

  def XMLParser.parse(xml)
    table = {}
    doc = REXML::Document.new(xml)
    doc.root.get_elements('rate').each do |e|
      from = e.get_text('from').to_s
      to = e.get_text('to').to_s
      conversion = e.get_text('conversion').to_s
      table[from] ||= {}
      table[from][to] = conversion
    end
    table
  end
end
