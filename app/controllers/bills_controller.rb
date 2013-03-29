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
      format.pdf { render :layout => false }
    end
  end

  # GET /bills/new
  def new
    
	  @currencies = Currency.find(:all, :order => 'name')
	  @parts = Part.find(:all, :order => 'number')
	  @customers = Customer.find(:all, :order => 'name')
    @bill = Bill.new
    @message = params[:message]

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
    @bill.status = "GENERATED"
	  @bill_parts = params[:bill_part_id]
    @quantities = params[:bill_part_quantity]
    @discounts = params[:bill_part_discount]
    @prices = params[:bill_part_price]
    @weights = params[:bill_part_weight]
    if(@bill_parts)
    for i in 0...@bill_parts.length
		  @bill_part = BillPart.new
      @part = Part.find(@bill_parts[i])
      @bill_part.bill = @bill
      @bill_part.part = @part
      @bill_part.quantity = @quantities[i]
      @bill_part.discount = @discounts[i] 
      @bill_part.price = @prices[i]
      @bill_part.weight = @weights[i]
		  @bill_part.save
	  end
	  end

    respond_to do |format|

      if !@bill_parts
        format.html { redirect_to :action => "new", :message => 'Add some parts first !!!'}
      elsif @bill.save
        format.html { redirect_to(@bill, :notice => 'Bill was successfully created.') }
        format.xml  { render :xml => @bill, :status => :created, :location => @bill }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bill.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def generate_pdf
    Prawn::Document.new do
        text "Hello Stackoverflow"
    end.render 
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
  def calculatePartDetails
    @part = Part.find(params[:part_id])
    @part_price = PartPrice.where("part_id = ? and customer_id = ? and currency_id = ?", params[:part_id], params[:customer_id], params[:currency_id]).first
    if(!@part_price)
      @part_price = PartPrice.where("part_id = ? and customer_id = -1 and currency_id = ?", params[:part_id], params[:currency_id]).first
    end
	  quantity = params[:quantity]
    discount = params[:discount].length > 0?params[:discount]:"0.0"
	  price = @part_price.price * Float(quantity)
	  if(discount)
	    price *= (100 - Float(discount))/100
	  end
	  #ternary operator to be put here
	  weight = @part.weight * Float(quantity)
	
    render :partial => 'partadded', :locals => { :part => @part, :price => @part_price.price, :quantity => quantity, :calculated_weight => weight, :calculated_price => price, :discount => discount }
  end

  # GET /part/getWeigthPrice
  def getWeigthPrice

    @part = Part.find(params[:part_id])
    @part_price = PartPrice.where("part_id = ? and customer_id = ? and currency_id = ?", params[:part_id], params[:customer_id], params[:currency_id]).first
    if(!@part_price)
      @part_price = PartPrice.where("part_id = ? and customer_id = -1 and currency_id = ?", params[:part_id], params[:currency_id]).first
    end
    quantity = params[:quantity]
    discount = params[:discount]?params[:discount]:"0.0"
    price = @part_price.price * Float(quantity)
    if(discount)
      price *= (100 - Float(discount))/100
    end
    #ternary operator to be put here
    weight = @part.weight * Float(quantity)
  
	
    render :json => {:price => price, :weight => weight}
  end
  
  # GET /bills/getPartDetails
  def getPartDetails
    @part = Part.find(params[:part_id])
    @part_price = PartPrice.where("part_id = ? and customer_id = ? and currency_id = ?", params[:part_id], params[:customer_id], params[:currency_id]).first
    @currency = Currency.find(params[:currency_id])
    if(!@part_price)
      @part_price = PartPrice.where("part_id = ? and customer_id = -1 and currency_id = ?", params[:part_id], params[:currency_id]).first
    end
    if(!@part_price)
      render :json => {:status => 'failure', :message=>'No price added for ' + @part.name + ' in ' + @currency.name + '.'}
    elsif(!@part.weight)
      render :json => {:status => 'failure', :message=>'No value of weight added for ' + @part.name + '.'}
    else
      render :json => {:status => 'success', :data=>{:part_name => @part.name, :part_weight => @part.weight, :part_price => @part_price.price}}
    end
  end
end
