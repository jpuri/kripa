class PartPricesController < ApplicationController
  # GET /part_prices
  def index
    @part_prices = PartPrice.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /part_prices/1
  def show
    @part_price = PartPrice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /part_prices/new
  def new
    @part_price = PartPrice.new
	@currencies = Currency.find(:all)
	@customers = Customer.find(:all)
	@part = Part.find(params[:part_id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /part_prices/1/edit
  def edit
    @part_price = PartPrice.find(params[:id])
  @currencies = Currency.find(:all)
  @customers = Customer.find(:all)
  end

  # POST /part_prices
  def create
  
  @part_price = PartPrice.new(params[:part_price])
	#@part_price.currency = 
	  currency = Currency.where(params[:part_price][:currency_id]).first
	  puts '==================================='
	  puts currency.name
	#@part_price.customer = 
	  customer = Customer.where(params[:part_price][:customer_id]).first
    puts customer.name
	@part_price.part = Part.find(params[:part_price][:part_id])

    respond_to do |format|
      if @part_price.save
  	    format.html { redirect_to '/parts/' + String(@part_price.part.id)}
      else
        @currencies = Currency.find(:all)
        @customers = Customer.find(:all)
        @part_id = String(@part_price.part.id)
        format.html { render :action => "new"}
      end
    end
  end

  # PUT /part_prices/1
  def update
    @part_price = PartPrice.find(params[:id])

    respond_to do |format|
      if @part_price.update_attributes(params[:part_price])
        format.html { redirect_to(@part_price, :notice => 'Part price was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /part_prices/1
  def destroy
    @model_price = PartPrice.find(params[:id])
    @model_price.destroy

    respond_to do |format|
      format.html { redirect_to(part_prices_url) }
    end
  end
end
