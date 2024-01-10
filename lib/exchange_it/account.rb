# frozen_string_literal: true

module ExchangeIt
  class Account
    include ExchangeIt::Utils::Uid
    attr_reader :balance, :id

    def initialize(user)
      @balance = 0
      @id = hash user.name, user.surname
    end

    def deposit(sum)
      raise 'Sum must be greater than zero' if sum <= 0

      @balance += sum
    end

    def transfer(receiver, amount)
      withdraw amount
      receiver.deposit amount
    end

    def withdraw(amount)
      raise(ExchangeIt::NotEnoughFunds, "Available: #{@balance} but tried to withdraw #{amount}") if @balance < amount
      raise(ExchangeIt::IncorrectSum, 'Amount must be positive!') unless amount.positive?

      @balance -= amount
    end

    def transfer_with_conversion(receiver, amount, in_currency, out_currency)
      converted_amount = convert sum: amount, from: in_currency, to: out_currency
      withdraw amount
      receiver.deposit converted_amount
    end
  end
end
