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
    @model_price = PartPrice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /part_prices/new
  def new
    @model_price = PartPrice.new
	@currencies = Currency.find(:all)
	@customers = Customer.find(:all)

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /part_prices/1/edit
  def edit
    @model_price = PartPrice.find(params[:id])
  end

  # POST /part_prices
  def create
  
    @model_price = PartPrice.new(params[:part_price])
	@model_price.currency = Currency.find(params[:part_price][:currency_id])
	@model_price.customer = Customer.find(params[:part_price][:customer_id])

    respond_to do |format|
      if @model_price.save
		format.html { redirect_to :controller=>'parts', :action => 'index' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /part_prices/1
  def update
    @model_price = PartPrice.find(params[:id])

    respond_to do |format|
      if @model_price.update_attributes(params[:model_price])
        format.html { redirect_to(@model_price, :notice => 'Model price was successfully updated.') }
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
