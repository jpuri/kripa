class PartPricesController < ApplicationController
  # GET /part_prices
  def index
    
    @makes = Make.all(:order => "name")
    @models_select = Model.all(:order => "number")
    @parts = Part.order("number")
    @customers = Customer.all(:order => "name")
    @currencies = Currency.all(:order => "name")
    
    condition = 'true'
      
    if(params[:make])
      @make_id = params[:make][:id]
      if(@make_id.length > 0)
        condition = "mk.id = #{@make_id}"
      end
    end
    
    if(params[:model])
      @model_id = params[:model][:id]
      if(@model_id.length > 0)
        condition += " and m.id = #{@model_id}"
      end
    end
    
    if(params[:part])
      @part_id = params[:part][:id]
      if(@part_id.length > 0)
        condition += " and p.id = #{@part_id}"
      end
    end
    
    if(params[:customer])
      @customer_id = params[:customer][:id]
      if(@customer_id.length > 0)
        condition += " and c.id = #{@customer_id}"
      end
    end
    
    if(params[:currency])
      @currency_id = params[:currency][:id]
      if(@currency_id.length > 0)
        condition += " and cur.id = #{@currency_id}"
      end
    end
    
    condition += " limit 20"
    
    @result = ActiveRecord::Base.connection.execute("SELECT mk.name as make_name, m.number as model_number, p.number as part_number, p.description as part_description, 
      p.weight, c.name, concat(cur.symbol, pp.price) as price from makes mk, models m, model_parts mp, 
      parts p, part_prices pp, customers c, currencies cur where mk.id = m.make_id and m.id = mp.model_id and p.id = mp.part_id and p.id = pp.part_id and pp.customer_id = c.id 
      and pp.currency_id = cur.id and " + condition)
     
    respond_to do |format|
      format.html
      format.xml  { render :xml => @models }
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
  @part = @part_price.part
  end

  # POST /part_prices
  def create
  
  @part_price = PartPrice.new(params[:part_price])

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
    @part_price = PartPrice.find(params[:id])
    @part_price.destroy
    @part = @part_price.part
    
    respond_to do |format|
      format.html { redirect_to(part_url(@part)) }
    end
  end
end
