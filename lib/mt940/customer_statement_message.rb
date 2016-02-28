# this is a beautification wrapper around the low-level
# MT940.parse command. use it in order to make dealing with
# the data easier
class MT940
  class CustomerStatementMessage
    attr_reader :statement_lines

    def self.parse_file(file)
      parse(File.read(file))
    end

    def self.parse(data)
      messages = MT940.parse(data)
      messages.map { |msg| new(msg) }
    end

    def initialize(raw_mt940)
      @raw = raw_mt940
      @account = @raw.find { |line| line.class == MT940::AccountIdentification }
      @statement_lines = []
      @raw.each_with_index do |line, i|
        next unless line.class == MT940::StatementLine
        ensure_is_info_line!(@raw[i + 1])
        @statement_lines << StatementLineBundle.new(@raw[i], @raw[i + 1])
      end
    end

    def bank_code
      @account.bank_code
    end

    def account_number
      @account.account_number
    end

    def narrative
      @information_to_account_owner = @raw.last
      @information_to_account_owner.narrative
    end

    private

    def ensure_is_info_line!(line)
      unless line.is_a?(MT940::InformationToAccountOwner)
        raise StandardError, "Unexpected Structure; expected StatementLineInformation, but was #{line.class}"
      end
    end
  end

  class StatementLineBundle
    METHOD_MAP = {
      amount: :line,
      funds_code: :line,
      value_date: :line,
      entry_date: :line,
      account_holder: :info,
      details: :info,
      account_number: :info,
      bank_code: :info
    }.freeze

    def initialize(statement_line, statement_line_info)
      @line = statement_line
      @info = statement_line_info
    end

    def method_missing(method, *args, &block)
      super unless METHOD_MAP.key?(method)
      object = instance_variable_get("@#{METHOD_MAP[method.to_sym]}")
      object.send(method)
    end
  end
end
