class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :initialise_session
    before_action :load_cart

    private

    def initialise_session
        session[:cart] ||= []
    end

    def load_cart
        @cart = Product.find(session[:cart])
    end
end
