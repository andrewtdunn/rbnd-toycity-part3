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
    add_to_transactions
  end

  def self.all
    @@transactions
  end

  def add_to_transactions
    if Product.in_stock.include?(@product)
      @product.decrement_stock
      @@transactions << self
    else
      raise OutOfStockError, '\'' + @product.title + '\' is out of stock.'
    end
  end

  def self.find(id)
    @@transactions.find{ |transaction| transaction.id == id }
  end

  def self.find_by_product_and_customer(product, customer)
    @@transactions.find{ |transaction| transaction.product == product && transaction.customer == customer}
  end

  def self.delete_by_id(id)
    @@transactions.delete self.find(id)
  end
end