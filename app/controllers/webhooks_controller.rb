class WebhooksController < ApplicationController

    def index 
        render json: { message: 'Webhook index' }
    end

    def create
        # Handle the webhook POST request here
        # Access the request parameters using params[:param_name]
        # Process the webhook data and perform necessary actions

        # Example: Log the webhook data
        Rails.logger.info("Webhook received: #{params}")
        puts "Webhook received: #{params}"


        # Example: Send a response back to the webhook sender
        render json: { message: 'Webhook received successfully'  }, status: :ok
    end
end
