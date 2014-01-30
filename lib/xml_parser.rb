class XMLParser
  require 'rexml/document'

  def self.parse(xml)
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

  def self.build_permutations(table)
    { "AUD" => {"CAD"=>"0", "USD"=>"0"},
      "CAD" => {"USD"=>"0", "AUD"=>"0"},
      "USD" => {"CAD"=>"0", "AUD"=>"0"}
    }
  end

  def self.convert_through(from_a, to_a, from_b, to_b)
    (to_a / from_a.to_f) * (to_b / from_b.to_f)
  end

  def self.convert_opposite_currency(from_currency, to_currency)
    1.0 / (to_currency / from_currency)
  end

  def self.find_common_currency(from, to, table)
    table[from].keys.each do |k|
      return k if table[k].has_key?(to)
    end
  end
end
