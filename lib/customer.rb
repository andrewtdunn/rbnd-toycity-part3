class Customer
    attr_reader :name
    @@customers = []

    def initialize(options = {})
        @name = options[:name]
        add_to_customers
    end

    def Customer.all
        @@customers
    end

    def add_to_customers
        if @@customers.any?{|customer| customer.name == @name}
            raise DuplicateCustomerError, @name + " already exists."
        else
            @@customers << self
        end
    end

    def Customer.find_by_name(name)
        @@customers.find{ |customer| customer.name == name }
    end

end