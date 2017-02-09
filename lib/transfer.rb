require "pry"

class Transfer
  attr_accessor :status
  attr_reader :sender, :receiver, :amount

  def initialize(sender, receiver, amount)
    @status = "pending"
    @sender = sender
    @receiver = receiver
    @amount = amount
  end

  def valid?
    self.sender.valid? && self.receiver.valid? && sender.balance >= self.amount

  end

  def execute_transaction
    if self.valid? && self.status == "pending"
      receiver.deposit(self.amount)
      sender.withdrawal(self.amount)
      self.status = "complete"
    else
      self.status ="rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if self.status == "complete"
      receiver.withdrawal(self.amount)
      sender.deposit(self.amount)
      self.status = "reversed"
    end
  end


end
