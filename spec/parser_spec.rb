require_relative '../lib/parser'

describe Parser do
  it 'correctly parses a string' do
    string = 'The date was 19 September 1765 (est) as best as we can tell'
    pattern = '[1-3]?%d %u%l+ %d%d%d%d% %(%l%l%l%)'
    expect(described_class.new(string, pattern).parse).to eql(['19 September 1765 (est)'])
  end

  it 'returns multiple results' do
    string = 'In Q3 2019 something will happen just like it did in Q1 1983'
    pattern = 'Q[1-4] %d%d%d%d'
    expect(described_class.new(string, pattern).parse).to eql(['Q3 2019', 'Q1 1983'])
  end
end
