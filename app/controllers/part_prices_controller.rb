class PartPricesController < ApplicationController

  before_filter :session_timeout

  def index
    part_number = params[:part_number] ? params[:part_number] : ""
    model = params[:model] ? params[:model] : ""
    
    @make = params[:make]
    @currency = params[:currency]
    sort = params[:sort]? params[:sort] : 'part_number'
    order = params[:order]? params[:order] : 'asc'
    @part_prices = PartPrice.where("lower(model) like ? and lower(part_number) like ? and make = ? and currency =  ?", 
    "%#{model.strip.downcase}%", "%#{part_number.strip.downcase}%",
    "#{params[:make]}", "#{params[:currency]}", ).order(sort + ' ' + order)
    
    render :json => @part_prices.collect { |part_price| {:id => part_price.id, :model => part_price.model, 
      :part_number => part_price.part_number, :part_desc => part_price.part_desc, :weight => part_price.weight , :price => part_price.price} }
  end

  def ajaxSearch

    part_number = params[:part_number] ? params[:part_number] : ""
    model = params[:model] ? params[:model] : ""
    
    @make = params[:make]
    @currency = params[:currency]
    @part_prices = PartPrice.where("lower(model) like ? and lower(part_number) like ? and make = ? and currency =  ?", 
    "%#{model.strip.downcase}%", "%#{part_number.strip.downcase}%",
    "#{params[:make]}", "#{params[:currency]}", )
    render :partial => 'result', :locals => { :part_prices => @part_prices}
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
      render :json => {:status => 'SUCCESS', :displayValue => [@part_price.make, @part_price.model, @part_price.part_number,
        @part_price.part_desc, @part_price.weight, @part_price.currency, @part_price.price]}
    else
      error_messages = Array.new
      @part_price.errors.each do |attr,message|
        error_messages << message
      end
      render :json => {:status => 'FAILURE', :messages => error_messages}
    end
  end

  def ajaxAutoCompleteParts
    condition = "true"
    if(params[:currency] && params[:currency].length > 0)
      condition += " and currency = '#{params[:currency]}'"
    end
    if(params[:model_number] && params[:model_number].length > 0)
       condition += " and model = '#{params[:model_number]}'"
    end
    if(params[:make] && params[:make].length > 0)
      condition += " and make = '#{params[:make]}'"
    end
    @result = ActiveRecord::Base.connection.execute("select distinct(part_number) from part_prices where " + condition)
    render :json => {:list => @result.collect { |column| column["part_number"] }}
  end

  def ajaxAutoCompleteModels
    condition = "make = '#{params[:make]}'"
    if(params[:currency] && params[:currency].length > 0)
      condition += " and currency = '#{params[:currency]}'"
    end
    @result = ActiveRecord::Base.connection.execute("select distinct(model) from part_prices where " + condition)
    render :json => {:list => @result.collect { |column| column["model"] }}
  end

  def ajaxGetPartDescription
    @part_price = PartPrice.where("part_number = ?", params[:part_number]).first
    if(@part_price != nil)
      render :json => {:part_desc => @part_price.part_desc, :weight => @part_price.weight}
    else
      render :json => {:part_desc => '', :weight => ''}
    end
      
  end
end
