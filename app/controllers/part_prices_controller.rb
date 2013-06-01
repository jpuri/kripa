class PartPricesController < ApplicationController

  before_filter :session_timeout

  def index
    @make = params[:part_price][:make]
    @currency = params[:part_price][:currency]
    @part_prices = PartPrice.where("make = ? and currency =  ?", 
    "#{params[:part_price][:make]}", "#{params[:part_price][:currency]}").order('make asc')
  end

  def ajaxSearch
    @part_prices = PartPrice.where("lower(model) like ? and lower(part_number) like ? and make = ? and currency =  ?", 
    "%#{params[:model].strip.downcase}%", "%#{params[:part_number].strip.downcase}%",
    "#{params[:make]}", "#{params[:currency]}", ).order('make asc')
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
    @makes = Make.all(:order => "name")
    @currencies = Currency.all
    render :partial => 'partPriceMenu', :locals => { :models => @models, :currencies => @currencies}    
  end

end
