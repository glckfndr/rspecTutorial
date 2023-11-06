# frozen_string_literal: true

describe ExchangeIt::Account do
  let(:user_class) { Struct.new(:name, :surname) }
  let(:john_account) { described_class.new user_class.new('John', 'Snow') }
  let(:ann_account) { described_class.new user_class.new('Ann', 'White') }

  it 'responds to balance and id' do
    expect(john_account).to respond_to(:balance)
    expect(john_account).to respond_to(:id)
  end

  it 'has zero balance by default' do
    expect(john_account.balance).to be(0)
  end

  it 'has proper id' do
    hash_id = john_account.hash 'John', 'Snow'
    expect(john_account.id).to eq(hash_id)
  end

  describe '#deposit', deposit: true do
    it 'allows to deposit correct sum' do
      john_account.deposit 100
      expect(john_account.balance).to be(100)
    end

    it 'does not allow to deposit a negative sum' do
      expect { john_account.deposit(-100) }.to raise_error('Sum must be greater than zero')
    end

    it 'does not allow to deposit a zero sum' do
      expect { john_account.deposit 0 }.to raise_error('Sum must be greater than zero')
    end
  end

  context 'when perform money withdrawal' do
    describe '#transfer' do
      specify '#transfer' do
        expect(john_account).to respond_to(:transfer).with(2).arguments
      end

      it 'allows to withdraw correct sum' do
        john_account.deposit 100
        john_account.transfer ann_account, 30
        expect(ann_account.balance).to eq(30)
        expect(john_account.balance).to eq(70)
      end
    end

    specify '#withdraw' do
      expect(john_account).to respond_to(:withdraw).with(1).arguments
    end

    describe '#withdraw', withdraw: true do
      before { john_account.deposit 100 }

      it 'allows to withdraw correct sum' do
        john_account.withdraw 30
        expect(john_account.balance).to eq(70)
      end

      it 'does not allow to withdraw a sum that is too large' do
        expect { john_account.withdraw 200 }.to raise_error(ExchangeIt::NotEnoughFunds, /Available: #{john_account.balance}/)
      end

      it 'does not allow to withdraw a negative sum' do
        expect { john_account.withdraw(-1) }.to raise_error(ExchangeIt::IncorrectSum, /must be positive/)
      end

      it 'does not allow to withdraw a zero sum' do
        expect { john_account.withdraw 0 }.to raise_error(ExchangeIt::IncorrectSum, /must be positive/)
      end
    end
  end
end
