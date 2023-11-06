# frozen_string_literal: true

describe ExchangeIt::User do
  let(:user) do |ex|
    described_class.new(ex.metadata.fetch(:name, 'John'),
                        ex.metadata.fetch(:surname, 'Snow'))
  end

  describe '#name' do
    it 'returns name' do
      expect(user.name).to eq('John')
    end

    it 'raise name error', name: nil do
      expect { user }.to raise_error('First or second name is nil')
    end
  end

  describe '#surname' do
    it 'returns surname' do
      expect(user.surname).to eq('Snow')
    end

    it 'raise surname error', surname: nil do
      expect { user }.to raise_error('First or second name is nil')
    end
  end

  describe '#balance and #account' do
    it 'responds to balance and account' do
      expect(user).to respond_to(:balance)
      expect(user).to respond_to(:account)
    end

    it 'has account' do
      expect(user.account).to be_an_instance_of(ExchangeIt::Account)
    end

    it 'has zero balance by default' do
      expect(user.balance).to eq(0)
    end
  end
end
