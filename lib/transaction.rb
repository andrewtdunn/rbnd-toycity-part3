class Transaction

  attr_reader :id
  attr_reader :customer
  attr_reader :product

  @@id = 1
  @@transactions = []

  def initialize(customer, product)
    @id = @@id
    @@id += 1
    @customer = customer
    @product = product
    @product.purchase()
    @@transactions << self
  end

  def self.all
    @@transactions
  end

  def self.find(id)
    @@transactions.find{ |transaction| transaction.id == id }
  end
end