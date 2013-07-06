class PartPricesController < ApplicationController

  before_filter :session_timeout

  def index
    @make = params[:part_price][:make]
    @currency = params[:part_price][:currency]
    @part_prices = PartPrice.where("make = ? and currency =  ?", 
    "#{params[:part_price][:make]}", "#{params[:part_price][:currency]}").order('part_number asc')
  end

  def ajaxSearch
    @make = params[:make]
    @currency = params[:currency]
    @part_prices = PartPrice.where("lower(model) like ? and lower(part_number) like ? and make = ? and currency =  ?", 
    "%#{params[:model].strip.downcase}%", "%#{params[:part_number].strip.downcase}%",
    "#{params[:make]}", "#{params[:currency]}", ).order('part_number asc')
    render :partial => 'result', :locals => { :part_prices => @part_prices}
  end

  def ajaxNew
    @part_price = PartPrice.new
    render :partial => 'new', :locals => { :part_price => @part_price}    
  end

  def ajaxCreate
    @part_prices = PartPrice.new(params[:part_price])

    if @part_prices.save
     render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxDelete
    @part_prices = PartPrice.find(params[:id])
    if @part_prices.delete
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxEdit
    @part_price = PartPrice.find(params[:id])
    index = params[:index]
    render :partial => 'edit', :locals => { :part_price => @part_price, :index => index}    
  end

  def ajaxUpdate
    @part_price = PartPrice.find(params[:id])

    if @part_price.update_attributes(params[:part_price])
      render :json => {:status => 'SUCCESS', :displayValue => [@part_price.make, @part_price.model, @part_price.part_number,
        @part_price.part_desc, @part_price.weight, @part_price.currency, @part_price.price]}
    else
      render :json => {:status => 'FAILURE'}
    end
  end
  
  def ajaxSingleDisplayRow
    @part_price = PartPrice.find(params[:id])
    index = params[:index]
    render :partial => 'singleRow', :locals => { :part_price => @part_price, :i => index}    
  end
  
  def ajaxPartPriceMenu
    @makes = ['HAMWORTHY', 'Hatlapa', 'SALAR', 'SPERRE', 'TANABE']
    @currencies = ['EURO', 'GBP', 'USD']
    render :partial => 'partPriceMenu', :locals => { :models => @models, :currencies => @currencies}    
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
