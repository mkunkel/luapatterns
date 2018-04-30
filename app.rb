require 'sinatra/base'
require 'slim'
require 'lib/parser'

class LuaPatterns < Sinatra::Base
  get '/' do
    slim :'form'
  end

  post '/' do
    puts params
    puts results
    results.to_json
  end

  private

  def string
    params['string']
  end

  def pattern
    params['pattern']
  end

  def results
    parsed = Parser.new(string, pattern).parse
    {
      pattern: pattern,
      string: string,
      results: parsed
    }
  end
end
