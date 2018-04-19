class Parser
  MAPPINGS = {
    '%a' => '[a-zA-Z]',
    '%c' => '[[:cntrl:]]',
    '%d' => '\d',
    '%l' => '[a-z]',
    '%p' => '[[:punct:]]',
    '%s' => '\\s',
    '%u' => '[A-Z]',
    '%w' => '[a-zA-Z0-9]',
    '%x' => '[a-fA-F0-9]',
    '%z' => '\0',
    '%A' => '[^a-zA-Z]',
    '%C' => '[^[:cntrl:]]',
    '%D' => '\D',
    '%L' => '[^a-z]',
    '%P' => '[^[:punct:]]',
    '%S' => '\\S',
    '%U' => '[^A-Z]',
    '%W' => '[^a-zA-Z0-9]',
    '%X' => '[^a-fA-F0-9]',
    '%Z' => '[^\0]{1}',
    '%(' => '\\(',
    '%)' => '\\)',
    '/' => '\/',
    '\\' => '\\\\'
  }

  def initialize(string, pattern)
    @string = string
    @pattern = pattern
  end

  def parse(print_output = false)
    regex = pattern_to_regex
    results = @string.scan(/#{regex}/)
    print_results(results) if print_output
    results
  end

  private

  def print_results(results)
    if results.empty?
      puts 'No results found'
    else
      puts "Results in \"#{@string}\":"
      results.each { |result| puts "  - \u001b[31m#{result}\u001b[0m" }
    end
  end

  def pattern_to_regex
    chars = pattern_chars
    convert_chars(chars).join('')
  end

  def pattern_chars
    chars = []
    @pattern.chars.each do |char|
      if chars.last == '%'
        chars.last << char
      else
        chars << char
      end
    end
    chars
  end

  def convert_chars(chars)
    chars.map do |char|
      if MAPPINGS[char]
        MAPPINGS[char]
      elsif char.start_with?('%')
        char[1]
      else
        char
      end
    end
  end
end
