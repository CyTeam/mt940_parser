require 'mt940'

describe MT940 do
  describe MT940::AccountIdentification do
    context 'account identifier' do
      it 'gives back the account identifier string' do
        acc_ident = MT940::AccountIdentification.new('some unused modifer', '12345690')
        expect(acc_ident.account_identifier).to eq('12345690')
      end

      it 'only gets the first 35 characters' do
        content = '1' * 40
        acc_ident = MT940::AccountIdentification.new('some unused modifer', content)
        expect(acc_ident.account_identifier.length).to eq(35)
      end
    end
  end

  describe MT940::InformationToAccountOwner do
    it 'gives back the narrative in lines' do
      content = 'NAME ACCOUNT OWNER: FEANDO LIMITED
                 ACCOUNT DESCRIPTION: CURR'

      info = MT940::InformationToAccountOwner.new('some unsed modifier', content)

      expect(info.narrative).to eq(['NAME ACCOUNT OWNER: FEANDO LIMITED',
                                    'ACCOUNT DESCRIPTION: CURR'])
    end
  end

  describe MT940::StatementNumber do
    let(:content) { '01704/01234' }

    subject { MT940::StatementNumber.new('some unused modifier', content) }

    it 'gives back the number of the statement as a string' do
      expect(subject.number).to eq('01704')
    end

    it 'gives back the sequence number of the statement' do
      expect(subject.sequence).to eq('01234')
    end

    it 'gives back nil if the sequence number is not included' do
      statement_number = MT940::StatementNumber.new('some unused modifier', '01704')
      expect(statement_number.sequence).to be_nil
    end
  end

  describe MT940::AccountBalance do
    let(:account_balance) { MT940::AccountBalance.new('some modifier', 'D120417USD13042,03') }

    context 'the sign' do
      it 'is :credit when the first char of the content is "C"' do
        account_balance = MT940::AccountBalance.new('some modifier', 'C120417USD0,00')
        expect(account_balance.sign).to eq(:credit)
      end

      it 'is :debit when the first char of the content is "D"' do
        account_balance = MT940::AccountBalance.new('some modifier', 'D120417USD0,00')
        expect(account_balance.sign).to eq(:debit)
      end
    end

    context 'the balance type' do
      it 'is :start when the modifier is "F"' do
        account_balance = MT940::AccountBalance.new('F', 'C120417USD0,00')
        expect(account_balance.sign).to eq(:credit)
      end

      it 'is :intermediate when the modifier is "M"' do
        account_balance = MT940::AccountBalance.new('M', 'D120417USD0,00')
        expect(account_balance.sign).to eq(:debit)
      end
    end

    it 'parses the date of the balance from the 6 digits after the sign' do
      expect(account_balance.date).to eq(Date.parse('2012-04-17'))
    end

    it 'parses the currency of the balance' do
      expect(account_balance.currency).to eq('USD')
    end

    it 'parses the balance amount into a big decimal' do
      expect(account_balance.amount).to be_a BigDecimal
      expect(account_balance.amount).to eq(BigDecimal.new('13042.03'))
    end
  end
end
