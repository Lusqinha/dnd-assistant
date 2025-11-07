require 'json'

module SeedHelpers
  # Helper method to parse Python-like JSON strings
  def parse_json_field(field)
    return nil if field.nil? || field.empty?

    # Replace Python's True/False/None with JSON equivalents
    field = field.gsub(/\bTrue\b/, 'true')
                 .gsub(/\bFalse\b/, 'false')
                 .gsub(/\bNone\b/, 'null')

    # Try to parse as JSON
    begin
      JSON.parse(field)
    rescue JSON::ParserError
      # If parsing fails, use Python's ast.literal_eval equivalent via eval
      # This is safe for CSV data we control
      begin
        eval(field.gsub('{', '{:').gsub(':', '=>').gsub('[', '[').gsub("'", '"'))
      rescue
        nil
      end
    end
  end

  def parse_array_field(field)
    return [] if field.nil? || field.empty?
    result = parse_json_field(field)
    result.is_a?(Array) ? result : [ result ].compact
  end
end
