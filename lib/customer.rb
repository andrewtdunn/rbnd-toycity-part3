class Customer
    attr_reader :name, :zip
    @@customers = []

    def initialize(options = {})
        @name = options[:name]
        if !@name
            raise NoNameError, 'Customer must have a name'
        end
        @zip = options[:zip]
        add_to_customers
    end

    def self.all
        @@customers
    end

    def add_to_customers
        if @@customers.any?{|customer| customer.name == @name}
            raise DuplicateCustomerError, '\'' + @name + "' already exists."
        else
            @@customers << self
        end
    end

    def self.find_by_name(name)
        @@customers.find{ |customer| customer.name == name }
    end

    def purchase(product)
        Transaction.new(self, product)
    end

    def return(product)
        transaction = Transaction.find_by_product_and_customer(product, self)
        if transaction
            product.increment_stock
            Transaction.delete_by_id(transaction.id)
        else
            raise BadReturnError, @name + " did not purchase a " + product.title
        end
    end

end