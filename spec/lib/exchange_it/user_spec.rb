describe ExchangeIt::User do
  let(:user) { described_class.new('John', 'Snow') }
  let(:user_without_name) { described_class.new(nil, 'Snow') }
  let(:user_without_surname) { described_class.new('John', nil) }

  it 'returns name' do
    expect(user.name).to eq('John')
  end

  it 'raise name error' do
    expect { user_without_name }.to raise_error('First or second name is nil')
  end

  it 'returns surname' do
    expect(user.surname).to eq('Snow')
  end

  it 'raise surname error' do
    expect { user_without_surname }.to raise_error('First or second name is nil')
  end
end
