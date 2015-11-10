class VirtualAccountProxyBlock
  def initialize(&creation_block)
    @creation_block = creation_block
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
    @subject || (@subject = @creation_block.call)
  end
end
