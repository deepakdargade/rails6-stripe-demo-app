class CheckoutController < ApplicationController
    def create
        # product = Product.find(params[:id])
        @session = Stripe::Checkout::Session.create({
            customer: current_user.stripe_customer_id,
            payment_method_types: ['card'],
            line_items: @cart.collect{|i| i.to_builder.attributes! },
            # line_items: [{
            #     # name: product.name,
            #     # amount: product.price * 100,
            #     # currency: 'inr',
            #     price: product.stripe_price_id,
            #     quantity: 1,
            # }],
            mode: 'payment',
            success_url: success_url + "?session_id={CHECKOUT_SESSION_ID}",
            cancel_url: cancel_url
        })
        respond_to do |format|
            format.js
        end
    end

    def success
        if params[:session_id].present?
            session[:cart] = []

            @session = Stripe::Checkout::Session.retrieve({
                id: params[:session_id],
                expand: ["line_items"]
            })
            @line_items = @session.line_items
        else
            redirect_to cancel_url, alert: 'No information about your payment was provided.'
        end
    end

    def cancel
    end
end