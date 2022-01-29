class Product < ApplicationRecord

    def to_s
        name
    end

    def to_builder
        Jbuilder.new do |product|
            product.price stripe_price_id
            product.quantity 1
        end
    end

    after_create do
        product = Stripe::Product.create(
            name: name
        )
        price = Stripe::Price.create(
            product: product.id, 
            unit_amount: self.price * 100, 
            currency: 'inr'
        )
        update(stripe_product_id: product.id, stripe_price_id: price.id)
    end
end
