class Product
    attr_reader :title
    attr_reader :stock
    attr_reader :price
    @@products  = []

    def initialize(options={})
        @title = options[:title]
        @price = options[:price]
        @stock = options[:stock]
        add_to_products
    end

    def Product.all
        @@products
    end

    def add_to_products
        if @@products.any?{|product| product.title == @title}
            raise DuplicateProductError, @title + " already exists."
        else
            @@products << self
        end
    end

    def Product.find_by_title(title)
        @@products.find{ |product| product.title == title }
    end

    def Product.in_stock
        @@products.reject{ |product| product.stock == 0}
    end

    def in_stock?
        @stock > 0
    end

end