class PricesController < ApplicationController

  before_filter :session_timeout

  def index
    
    @makes = Make.all(:order => "name")
    @models = Model.all(:order => "number")
    @parts = Part.order("number")
    @customers = Customer.all(:order => "name")
    @currencies = Currency.all(:order => "name")
    @result = fetchSearchResults
  end

  def ajaxSearch
    
    @result = fetchSearchResults
    render :partial => 'result', :locals => { :result => @result}    
  end

  def fetchSearchResults
      
      condition = 'true'
        
      if(params[:make_id])
        @make_id = params[:make_id]
        if(@make_id.length > 0)
          condition = "mk.id = #{@make_id}"
        end
      end
      
      if(params[:model_number])
        @model_number = params[:model_number]
        if(@model_number.length > 0)
          condition += " and m.number like '#{@model_number}%"
        end
      end
      
      if(params[:part_number])
        @part_number = params[:part_number]
        if(@part_number.length > 0)
          condition += " and p.number like '#{@part_number}%'"
        end
      end
      
      if(params[:customer_id])
        @customer_id = params[:customer_id]
        if(@customer_id.length > 0)
          condition += " and c.id = #{@customer_id}"
        end
      end
      
      if(params[:currency_id])
        @currency_id = params[:currency_id]
        if(@currency_id.length > 0)
          condition += " and cur.id = #{@currency_id}"
        end
      end
      
      @result = ActiveRecord::Base.connection.execute("SELECT pp.id as id, mk.name as make_name, m.number as model_number, p.number as part_number,  
        p.description as part_description, p.weight, c.name, concat(cur.symbol, pp.value) as value from makes mk, models m, model_parts mp, 
        parts p, prices pp, customers c, currencies cur where mk.id = m.make_id and m.id = mp.model_id and p.id = mp.part_id and p.id = pp.part_id  
        and pp.customer_id = c.id and pp.currency_id = cur.id and " + condition)
  
      @result   
  end

  def ajaxNew
    
    @price = Price.new
    @currencies = Currency.all(:order => "name")
    @customers = Customer.all(:order => "name")
    @parts = Part.all(:order => "number")
    render :partial => 'new', :locals => { :price => @price, :currencies => @currencies, :customers => @customers, :parts => @parts}    
  end

  def ajaxCreate
    
    @price = Price.new(params[:price])

    if @price.save
     render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxEdit
    
    @price = Price.find(params[:id])
    @currencies = Currency.all(:order => "name")
    @customers = Customer.all(:order => "name")
    @parts = Part.all(:order => "number")
    render :partial => 'edit', :locals => { :price => @price, :currencies => @currencies, :customers => @customers, :parts => @parts}    
  end

  def ajaxUpdate
    
    @price = Price.find(params[:id])
    if @price.update_attributes(params[:price])
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxDelete
    
    @price = Price.find(params[:id])
    if @price.delete
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

end