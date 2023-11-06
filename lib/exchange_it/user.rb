# frozen_string_literal: true

module ExchangeIt
  class User
    extend Forwardable
    attr_reader :name, :surname, :account

    def_delegators :account, :balance

    def initialize(first_name, second_name)
      raise('First or second name is nil') if first_name.nil? || second_name.nil?

      @name = first_name # .reverse
      @surname = second_name
      create_account
    end

    private

    def create_account
      @account = Account.new self
    end
  end
end
