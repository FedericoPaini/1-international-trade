require 'spec_helper'
require 'xml_parser'

describe XMLParser do
  let(:xml_text) { IO.read(fixture('SAMPLE_RATES.xml')) }

  it "parses the xml text" do

    expect(XMLParser.parse(xml_text)).to eql(
      { "AUD" => {"CAD"=>"1.0079"},
        "CAD" => {"USD"=>"1.0090"},
        "USD" => {"CAD"=>"0.9911"}
      }
    )

  end
end
