class ShipmentsController < ApplicationController
    before_action :authenticate_user! 
    before_action :set_shipment, only: [:show, :edit, :update, :destroy]
  
    def index
      @shipments = current_user.shipments 
    end
  
    def new
      @shipment = current_user.shipments.build
    end
  
    def create
      @shipment = current_user.shipments.build(shipment_params)
      if @shipment.save
        redirect_to @shipment, notice: 'Shipment was successfully created.'
      else
        render :new
      end
    end
  
    def show
    end
  
    def edit
    end
  
    def update
        @shipment = Shipment.find(params[:id])
        
        if current_user.delivery_partner?
          if @shipment.update(shipment_params_for_delivery_partner)
            redirect_to delivery_partner_shipments_path, notice: 'Shipment status was successfully updated.'
          else
            render :edit
          end
        else
          if @shipment.update(shipment_params)
            redirect_to @shipment, notice: 'Shipment was successfully updated.'
          else
            render :edit
          end
        end
    end

    def delivery_partner_index
        @assigned_shipments = Shipment.where(delivery_partner_id: current_user)
    end
  
    def destroy
        @shipment = Shipment.find(params[:id])
        @shipment.delete
        redirect_to shipments_path, notice: 'Shipment was successfully deleted.'
    end
  
    private
  
    def set_shipment
      @shipment = Shipment.find(params[:id])
    end
  
    def shipment_params
      params.require(:shipment).permit(:source, :target, :item, :status, :delivery_partner_id)
    end

    def shipment_params_for_delivery_partner
        params.require(:shipment).permit(:status)
    end
  end
  