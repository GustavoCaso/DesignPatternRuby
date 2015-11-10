class VirtualAccountProxy
  def initialize(starting_balance=0)
    @starting_balance = starting_balance
  end

  def deposit(amount)
    s = subject
    s.deposit(amount)
  end

  def widthdraw(amount)
    s = subject
    s.widthdraw(amount)
  end

  def balance
    s = subject
    s.balance
  end

  def subject
    @subject || (@subject = BankAccount.new(@starting_balance))
  end
end
