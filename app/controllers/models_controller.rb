class ModelsController < ApplicationController
  # GET /models
  # GET /models.xml
  def index
    
    @models_select = Model.all
    @parts = Part.all
    @customers = Customer.all
    @currencies = Currency.all
    
    condition = 'true'
      
    if(params[:model])
      @model_id = params[:model][:id]
      if(@model_id.length > 0)
        condition = "m.id = #{@model_id}"
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
    
    @result = ActiveRecord::Base.connection.execute("SELECT m.number as model_number, m.name as model_name, p.number as part_number, p.name as part_name, 
      p.weight, c.name, concat(cur.symbol, pp.price) as price from models m, model_parts mp, 
      parts p, part_prices pp, customers c, currencies cur where m.id = mp.model_id and p.id = mp.part_id and p.id = pp.part_id and pp.customer_id = c.id 
      and pp.currency_id = cur.id and " + condition)
      
      puts '=========================================='
      for column in @result
        puts column
      end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @models }
    end
  end

  # GET /models/1
  # GET /models/1.xml
  def show
    @model = Model.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @model }
    end
  end

  # GET /models/new
  # GET /models/new.xml
  def new
    @model = Model.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @model }
    end
  end

  # GET /models/1/edit
  def edit
    @model = Model.find(params[:id])
  end

  # POST /models
  # POST /models.xml
  def create
    @model = Model.new(params[:model])

    respond_to do |format|
      if @model.save
        format.html { redirect_to(@model, :notice => 'Model was successfully created.') }
        format.xml  { render :xml => @model, :status => :created, :location => @model }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /models/1
  # PUT /models/1.xml
  def update
    @model = Model.find(params[:id])

    respond_to do |format|
      if @model.update_attributes(params[:model])
        format.html { redirect_to(@model, :notice => 'Model was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @model.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /models/1
  # DELETE /models/1.xml
  def destroy
    @model = Model.find(params[:id])
    @model.destroy

    respond_to do |format|
      format.html { redirect_to(models_url) }
      format.xml  { head :ok }
    end
  end
  
  def addModelPart
    @model = Model.find(params[:model_id])
	@parts = Part.find(:all)
	
    respond_to do |format|
      format.html # addModelPart.html.erb
      format.xml  { render :xml => @model_part }
    end
  end

  def saveModelPart
	@model_part = ModelPart.new(params[:model_part])

    respond_to do |format|
      if @model_part.save
        format.html { redirect_to @model_part.model }
      else
		 # tbd
      end
    end
  end

end
