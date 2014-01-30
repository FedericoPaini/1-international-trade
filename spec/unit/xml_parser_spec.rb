require 'spec_helper'
require 'xml_parser'

describe XMLParser do
  let(:xml_text) { IO.read(fixture('SAMPLE_RATES.xml')) }

  let(:table) {
    { "USD" => {"CAD"=>"0.9911"},
      "CAD" => {"AUD"=>"1.0090"} }
  }

  let(:big_table) {
    { "AUD" => {"CAD"=>"1.0079"},
      "CAD" => {"USD"=>"1.0090"},
      "USD" => {"CAD"=>"0.9911"} }
  }

  it "parses the xml text" do
    expect(XMLParser.parse(xml_text)).to eql(
      { "AUD" => {"CAD"=>"1.0079"},
        "CAD" => {"USD"=>"1.0090"},
        "USD" => {"CAD"=>"0.9911"},
      }
    )
  end

  it "builds all permutations" do
    expect(XMLParser.build_permutations(big_table)).to eql(
      { "AUD" => {"CAD"=>"0", "USD"=>"0"},
        "CAD" => {"USD"=>"0", "AUD"=>"0"},
        "USD" => {"CAD"=>"0", "AUD"=>"0"},
      }
    )
  end

  it "finds common currency for us -> aud" do
    expect(XMLParser.find_common_currency('USD', 'AUD', table)).to eql('CAD')
  end

  it "converts through 2 currencies" do
    expect(XMLParser.convert_through(1, 2, 1, 2)).to eql(4.0)
  end

  it "reverses the rate" do
    expect(XMLParser.convert_opposite_currency(1,2)).to eql(0.5)
  end
end
