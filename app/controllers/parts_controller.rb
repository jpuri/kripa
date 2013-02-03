class PartsController < ApplicationController
  # GET /parts
  def index
    @parts = Part.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /parts/1
  def show
    @part = Part.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /parts/new
  def new
    @part = Part.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /parts/1/edit
  def edit
    @part = Part.find(params[:id])
  end

  # POST /parts
  def create
    @part = Part.new(params[:part])

	puts params.inspect
	
    respond_to do |format|
      if @part.save
        format.html { redirect_to(@part, :notice => 'Part was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /parts/1
  def update
    @part = Part.find(params[:id])

    respond_to do |format|
      if @part.update_attributes(params[:part])
        format.html { redirect_to(@part, :notice => 'Part was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /parts/1
  def destroy
    @part = Part.find(params[:id])
    @part.destroy

    respond_to do |format|
      format.html { redirect_to(parts_url) }
    end
  end

  # GET /part/generatebill
  def generatebill
	@currencies = Currency.find(:all)
	@parts = Part.find(:all)
	@models = PartModel.find(:all)

    respond_to do |format|
      format.html # generatebill.html.erb
    end
  end
  
  # GET /part/getModelDetail
  def getModelDetail

    @model_price = ModelPrice.where("part_model_id = ? and currency_id = ?", params[:model_id], params[:currency_id]).first
	@part_model = PartModel.find(@model_price.part_model_id)
	@part = Part.find(@part_model.part_id)
	
	quantity = params[:quantity]
	price = @model_price.price * Float(quantity)
	weight = @part.weight * Float(quantity)
	
    render :partial => 'partadded', :locals => { :part_name => @part.name, :quantity => quantity, :weight => weight, :price => price }
  end

  # GET /part/getWeigthPrice
  def getWeigthPrice

    @model_price = ModelPrice.where("part_model_id = ? and currency_id = ?", params[:model_id], params[:currency_id]).first
	@part_model = PartModel.find(@model_price.part_model_id)
	@part = Part.find(@part_model.part_id)
	
	quantity = params[:quantity]
	price = @model_price.price * Float(quantity)
	weight = @part.weight * Float(quantity)
	
    render :json => {:price => price, :weight => weight}
  end
  
end
