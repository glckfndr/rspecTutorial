describe ExchangeIt::Api::Converter do
  # let(:dummy) { Class.new { include ExchangeIt::Api::Converter }.new }

  specify '#convert' do
  #   expect(dummy).to respond_to(:convert).with(3).arguments

  converter_stub = instance_double ExchangeIt::Api::Converter

  #expect(converter_stub).to receive(:convert).with(sum: 80)
  allow(converter_stub).to receive(:convert).with(sum: 80).and_return(100)
  expect(converter_stub.convert(sum: 80)).to eq(100)
  # spy
  expect(converter_stub).to have_received(:convert).with(sum: 80).once
  end
end
