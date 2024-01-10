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

  it 'has proper id', :positive do
    hash_id = john_account.hash 'John', 'Snow'
    expect(john_account.id).to eq(hash_id)
  end

  describe '#deposit', :positive do
    it 'allows to deposit correct sum', :positive do
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
    specify '#transfer_with_conversion' do
      expect(john_account).to respond_to(:transfer_with_conversion).with(4).arguments
    end

    describe 'transfer_with_conversion' do
      it 'does not allow to deposit a zero sum' do
        john_account.deposit 100
        allow(john_account).to receive(:convert).with(sum: 50, from: :usd, to: :eur).and_return(40)
        john_account.transfer_with_conversion ann_account, 50, :usd, :eur
        expect(john_account.balance).to eq(50)
        expect(ann_account.balance).to eq(40)
        expect(john_account).to have_received(:convert)
      end
    end

    describe '#transfer' do
      before { john_account.deposit 100 }

      specify '#transfer' do
        expect(john_account).to respond_to(:transfer).with(2).arguments
      end

      it 'allows to transfer correct sum', :positive do
        john_account.transfer ann_account, 30
        expect(ann_account.balance).to eq(30)
        expect(john_account.balance).to eq(70)
      end

      it 'allows to transfer(mocked) correct sum', :positive do
        ann_mocked = instance_double(described_class, balance: 30, deposit: 0)

        john_account.transfer ann_mocked, 30
        expect(ann_mocked.balance).to eq(30)
        expect(john_account.balance).to eq(70)
      end
    end

    specify '#withdraw' do
      expect(john_account).to respond_to(:withdraw).with(1).arguments
    end

    describe '#withdraw', withdraw: true do
      before { john_account.deposit 100 }

      it 'allows to withdraw correct sum', :positive do
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
