class Product
    attr_reader :title, :stock, :price
    @@products  = []

    def initialize(options={})
        @title = options[:title]
        @price = options[:price]
        @stock = options[:stock]
        add_to_products
    end

    def self.all
        @@products
    end

    def add_to_products
        if @@products.any?{|product| product.title == @title}
            raise DuplicateProductError, @title + " already exists."
        else
            @@products << self
        end
    end

    def purchase(product)
        Transaction.new(self, product)
    end

    def decrement_stock
        @stock -= 1
    end

    def increment_stock
        @stock += 1
    end


    def self.find_by_title(title)
        @@products.find{ |product| product.title == title }
    end

    def self.in_stock
        @@products.reject{ |product| product.stock == 0}
    end

    def in_stock?
        @stock > 0
    end

end