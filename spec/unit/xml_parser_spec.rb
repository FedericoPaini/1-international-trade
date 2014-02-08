require 'spec_helper'
require 'xml_parser'

describe XMLParser do

  let(:xml_text) { IO.read(fixture('SAMPLE_RATES.xml')) }

  let(:table) do
    {
      'AUD' => { 'CAD' => 1.0079 },
      'CAD' => { 'USD' => 1.0090 },
      'USD' => { 'CAD' => 0.9911 },
    }
  end

  let(:permutations) do
    {
      'AUD' => { 'CAD' => 1.0079, 'USD' => nil },
      'CAD' => { 'USD' => 1.0090, 'AUD' => nil },
      'USD' => { 'CAD' => 0.9911, 'AUD' => nil },
    }
  end

  it "builds an initial table from XML" do
    expect(XMLParser.build_table(xml_text)).to eql(table)
  end

  it "builds all permutations" do
    expect(XMLParser.build_permutations(table)).to eql(permutations)
  end

  it "finds common currency shared by USD and AUD" do
    expect(XMLParser.find_common_currency('USD', 'AUD', permutations)).to eql('CAD')
  end

  it "converts through 2 currencies" do
    pending
    expect(XMLParser.convert_through(1, 2, 1, 2)).to eql(4.0)
  end

  it "reverses the rate" do
    pending
    expect(XMLParser.convert_opposite_currency(1,2)).to eql(0.5)
  end

end
