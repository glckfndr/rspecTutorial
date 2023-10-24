describe ExchangeIt::Account do
  it 'has zero balance'
  it 'has proper id'

  describe '#deposit' do
    it 'allows to deposit correct sum'
    it 'does not allow to deposit a negative sum'
    it 'does not allow to deposit a zero sum'
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
