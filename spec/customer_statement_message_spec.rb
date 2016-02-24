require 'spec_helper'
require 'mt940'
require 'mt940/customer_statement_message'

# TODO: Make sure name align closly with the MT940 specifications
# TODO: Add a method to get the currency of the account.

describe MT940::CustomerStatementMessage do
  subject { MT940::CustomerStatementMessage }
  let(:file) { File.dirname(__FILE__) + '/fixtures/sepa_snippet.txt' }
  let(:messages) { subject.parse_file(file) }
  let(:message) { messages.first }
  let(:message_2) { messages.last }

  it 'has a bank code' do
    expect(message.bank_code).to eq('50880050')
  end

  it 'has a account number' do
    expect(message.account_number).to eq('0194787400888')
  end

  it 'has statement lines' do
    expect(message.statement_lines).to respond_to(:each)
    expect(message.statement_lines.size).to eq(4)
  end

  it 'handles multi-lines for Information to Account owners fields' do
    message = ":20:STMT20120604
               :25:111234123412134124
               :28C:01234
               :60F:C120603USD0,00
               :62F:C120603USD0,00
               :64:C120603USD0,00
               :86:NAME ACCOUNT OWNER:SOME ENTITY
               ACCOUNT DESCRIPTION:  CURR
               -"

    statement = subject.parse(message).first
    expect(statement.narrative).to eq(['NAME ACCOUNT OWNER:SOME ENTITY',
                                       'ACCOUNT DESCRIPTION:  CURR'])
  end

  context 'statement lines' do
    # TODO: I don't like the use of fixtures here as it is difficult to see
    # what is being tested and why the tests have those values. I want to inline
    # some of the examples in the fixtures.

    # TODO: These tests should maybe go into a separate file and test through
    # the StatementLineBundle class
    let(:line) { message.statement_lines.first }

    it 'have credited amounts' do
      # TODO: This should maybe return a Money object based on the currency in the
      # statement.
      expect(line.amount).to eq(5_099_005)
      # TODO: funds_code doesn't seam like a good name for this, will need to check
      # the docs to find a more appropriate name. Suggestions: mark, direction.
      expect(line.funds_code).to eq(:credit)
    end

    it 'have debited amounts' do
      line = message_2.statement_lines.first
      # TODO: Same as above.
      expect(line.amount).to eq(8)
      expect(line.funds_code).to eq(:debit)
    end

    it 'have a account holder' do
      # TODO: There should be better string formatting here
      expect(line.account_holder).to eq("KARL\n        KAUFMANN")
    end

    it 'has statement lines that have a bank code' do
      # TODO: check this method has a appropriate name.
      expect(line.bank_code).to eq('DRESDEFF508')
    end

    it 'has statement lines that a have account number' do
      # TODO: check this method has a appropriate name.
      expect(line.account_number).to eq('DE14508800500194785000')
    end

    it 'has details' do
      # TODO: Maybe change #details to #narrative
      expect(line.details).to eq(
        "EREF+EndToEndId TFNR 22 004\n 00001\nSVWZ+Verw CTSc-01 BC-PPP TF\nNr 22 004"
      )
    end

    it 'has an entry date' do
      # TODO: check this method has a appropriate name.
      expect(line.entry_date).to eq(Date.parse('2007-09-04'))
    end

    it 'has a value date' do
      # TODO: check this method has a appropriate name.
      expect(line.value_date).to eq(Date.parse('2007-09-07'))
    end

    it 'raises a no method error when asking for unknown info' do
      expect { line.unknown_method }.to raise_error NoMethodError
    end
  end

  it 'parses a message file into individual statements' do
    messages = subject.parse_file(file)
    expect(messages.size).to eq(2)
    expect(messages[0].account_number).to eq('0194787400888')
    expect(messages[1].account_number).to eq('0194791600888')
  end

  it 'fails when it parses a file with a broken structure' do
    file = File.dirname(__FILE__) + '/fixtures/sepa_snippet_broken.txt'
    # TODO: I think raising a more specific error is better.
    expect { subject.parse_file(file) }.to raise_error StandardError
  end

  it 'parses mt940 within curved brackets' do
    file = File.dirname(__FILE__) + '/fixtures/bracket_example.txt'
    expect { subject.parse_file file }.not_to raise_error StandardError
  end
end
