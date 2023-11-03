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
  end
end
