require_relative "transaction"

class Customer
    attr_reader :name
    attr_reader :zip
    @@customers = []

    def initialize(options = {})
        @name = options[:name]
        @zip = options[:zip]
        add_to_customers
    end

    def Customer.all
        @@customers
    end

    def add_to_customers
        if @@customers.any?{|customer| customer.name == @name}
            raise DuplicateCustomerError, '\'' + @name + "' already exists."
        else
            @@customers << self
        end
    end

    def Customer.find_by_name(name)
        @@customers.find{ |customer| customer.name == name }
    end

    def purchase(product)
        Transaction.new(self, product)
    end

    def return(product)
        product.return()
    end

end