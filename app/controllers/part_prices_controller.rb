class PartPricesController < ApplicationController

  before_filter :session_timeout

  def index
    @make = params[:make]
    @currency = params[:currency]
    @part_prices = PartPrice.where("make = ? and currency =  ?", "#{params[:make]}", "#{params[:currency]}")

    render :json => @part_prices.collect { |part_price| 
      {:id => part_price.id, :model => part_price.model, 
      :part_number => part_price.part_number, :part_desc => part_price.part_desc, 
      :weight => part_price.weight, :price => part_price.price, :color => part_price.color}}
  end

  def create
    @part_price = PartPrice.new(params[:part_price])
    if @part_price.save
      render :json => {:status => 'SUCCESS', :part_price_id => @part_price.id}
    else
      error_messages = Array.new
      @part_price.errors.each do |attr,message|
        error_messages << message
      end
      render :json => {:status => 'FAILURE', :messages => error_messages}
    end
  end

  def destroy
    @part_price = PartPrice.find(params[:id])
    if @part_price.delete
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def update
    @part_price = PartPrice.find(params[:id])

    if @part_price.update_attributes(params[:part_price])
      render :json => {:status => 'SUCCESS'}
    else
      error_messages = Array.new
      @part_price.errors.each do |attr,message|
        error_messages << message
      end
      render :json => {:status => 'FAILURE', :messages => error_messages}
    end
  end
end
