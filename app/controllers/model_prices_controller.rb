class ModelPricesController < ApplicationController
  # GET /model_prices
  def index
    @model_prices = ModelPrice.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /model_prices/1
  def show
    @model_price = ModelPrice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /model_prices/new
  def new
    @model_price = ModelPrice.new
	@currencies = Currency.find(:all)
	@part_models = PartModel.where("part_id = ?", params[:part_id])

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /model_prices/1/edit
  def edit
    @model_price = ModelPrice.find(params[:id])
  end

  # POST /model_prices
  def create
  
    @model_price = ModelPrice.new(params[:model_price])
	@model_price.currency = Currency.find(params[:model_price][:currency_id])
	@model_price.part_model = PartModel.find(params[:model_price][:part_model_id])

    respond_to do |format|
      if @model_price.save
		format.html { redirect_to :controller=>'parts', :action => 'index' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /model_prices/1
  def update
    @model_price = ModelPrice.find(params[:id])

    respond_to do |format|
      if @model_price.update_attributes(params[:model_price])
        format.html { redirect_to(@model_price, :notice => 'Model price was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /model_prices/1
  def destroy
    @model_price = ModelPrice.find(params[:id])
    @model_price.destroy

    respond_to do |format|
      format.html { redirect_to(model_prices_url) }
    end
  end
end
