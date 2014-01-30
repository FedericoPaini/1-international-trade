require 'spec_helper'
require 'xml_parser'

describe XMLParser do
  let(:xml_text) { IO.read(fixture('SAMPLE_RATES.xml')) }

  let(:table) {
    { "USD" => {"CAD"=>"0.9911"},
      "CAD" => {"AUD"=>"1.0090"} }
  }

  it "parses the xml text" do
    pending
    expect(XMLParser.parse(xml_text)).to eql(
      { "AUD" => {"CAD"=>"1.0079"},
        "CAD" => {"USD"=>"1.0090"},
        "USD" => {"CAD"=>"0.9911"},
        "CAD" => {"USD"=>"1.0089"},
      }
    )
  end

  it "finds common currency (us -> aud) us->cad  cad->aud" do
    expect(XMLParser.find_common_currency('USD', 'AUD', table)).to eql('CAD')
  end

  # a. create a set of all the first order and second order keys
  # b. permutation
  # c. check see if the table is already built
  #   not - then we need to find a common currency
  #   use the convert through 2 currencies

  it "converts through 2 currencies" do
    expect(XMLParser.convert_through(1, 2, 1, 2)).to eql(4.0)
  end

  it "reverses the rate" do
    expect(XMLParser.convert_opposite_currency(1,2)).to eql(0.5)
  end
end


    # USD => CAD = 1/(CA => US)
    # 0.911 = 1/1.0090
    #
    # 1us = 0.9911 => ca=1/0.9911
    # 1aud= 1.0079 ca => 1au = 1.0079*(1/0911) => AUD=> US
    #
    # 1.0079 *
    # 11.06366630076838638858
    #

