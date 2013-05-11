class CustomersController < ApplicationController

  before_filter :session_timeout

  def index
    @customers = Customer.all(:order => "name")
  end

  def ajaxSearch
    @customers = Customer.all(:order => "name")
    render :partial => 'result', :locals => { :customers => @customers}
  end

  def ajaxNew
    @customer = Customer.new
    render :partial => 'new', :locals => { :customer => @customer}    
  end

  def ajaxCreate
    @customer = Customer.new(params[:customer])

    if @customer.save
     render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxEdit
    @customer = Customer.find(params[:id])
    render :partial => 'edit', :locals => { :customer => @customer}    
  end

  def ajaxUpdate
    @customer = Customer.find(params[:id])

    if @customer.update_attributes(params[:customer])
      render :json => {:status => 'SUCCESS', :displayValue => [@customer.customer_id, @customer.name, @customer.country,
        @customer.phone, @customer.email]}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxDelete
    @customer = Customer.find(params[:id])
    if @customer.delete
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

end
