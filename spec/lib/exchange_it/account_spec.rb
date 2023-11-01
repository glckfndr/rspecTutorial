describe ExchangeIt::Account do
  let(:user) { ExchangeIt::User.new('John', 'Snow') }
  let(:account) { described_class.new user }

  it 'responds to balance and id' do
    expect(account).to respond_to(:balance)
    expect(account).to respond_to(:id)
  end

  it 'has zero balance by default' do
    expect(account.balance).to be(0)
  end

  it 'has proper id' do
    hash_id = ExchangeIt::Utils::Uid.hash user.name, user.surname
    expect(account.id).to be(hash_id)
  end

  describe '#deposit' do
    it 'allows to deposit correct sum' do
      account.deposit 100
      expect(account.balance).to be(100)
    end

    it 'does not allow to deposit a negative sum' do
      expect { account.deposit(-100) }.to raise_error('Sum must be greater than zero')
    end

    it 'does not allow to deposit a zero sum' do
      expect { account.deposit 0 }.to raise_error('Sum must be greater than zero')
    end
  end

  context 'when perform money withdrawal' do
    specify '#transfer'
    describe '#withdraw' do
      it 'allows to withdraw correct sum'
      it 'does not allow to withdraw a sum that is too large'
      it 'does not allow to withdraw a negative sum'
      it 'does not allow to withdraw a zero sum'
    end
  end
end
