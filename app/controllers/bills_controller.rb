class BillsController < ApplicationController
  # GET /bills
  # GET /bills.xml
  def index
    @bills = Bill.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bills }
    end
  end

  # GET /bills/1
  # GET /bills/1.xml
  def show
    @bill = Bill.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bill }
    end
  end

  # GET /bills/new
  def new
	@currencies = Currency.find(:all)
	@parts = Part.find(:all)
	@models = PartModel.find(:all)
	@customers = Customer.find(:all)
    @bill = Bill.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /bills/1/edit
  def edit
    @bill = Bill.find(params[:id])
  end

  # POST /bills
  # POST /bills.xml
  def create
  
    @bill = Bill.new(params[:bill])

	@bill_parts = params[:bill_part_model_price_id]
	@quantities = params[:bill_part_quantity]
	for i in 0...@bill_parts.length
		@bill_part = BillPart.new
		@bill_part.bill = @bill
		@bill_part.model_price = ModelPrice.find(@bill_parts[i])
		@bill_part.bill = @quantities[i]
		@bill_part.save
	end

    respond_to do |format|
      if @bill.save
        format.html { redirect_to(@bill, :notice => 'Bill was successfully created.') }
        format.xml  { render :xml => @bill, :status => :created, :location => @bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bills/1
  # PUT /bills/1.xml
  def update
    @bill = Bill.find(params[:id])

    respond_to do |format|
      if @bill.update_attributes(params[:bill])
        format.html { redirect_to(@bill, :notice => 'Bill was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bills/1
  # DELETE /bills/1.xml
  def destroy
    @bill = Bill.find(params[:id])
    @bill.destroy

    respond_to do |format|
      format.html { redirect_to(bills_url) }
      format.xml  { head :ok }
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
