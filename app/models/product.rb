class Product < ApplicationRecord

    def to_s
        name
    end

    after_create do
        product = Stripe::Product.create(
            name: name
        )
        sprice = Stripe::Price.create(
            product: product.id, 
            unit_amount: price * 100, 
            currency: 'usd'
        )
        update(stripe_product_id: product.id)
    end
end
