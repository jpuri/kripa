class MakesController < ApplicationController

  def index
    @makes = Make.all(:order => "name")
  end

  def ajaxSearch
    @makes = Make.all(:order => "name")
    render :partial => 'result', :locals => { :makes => @makes}
  end

  def ajaxNew
    @make = Make.new
    render :partial => 'new', :locals => { :make => @make}    
  end

  def ajaxCreate
    @make = Make.new(params[:make])

    if @make.save
     render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxEdit
    @make = Make.find(params[:id])
    render :partial => 'edit', :locals => { :make => @make}    
  end

  def ajaxUpdate
    @make = Make.find(params[:id])

    if @make.update_attributes(params[:make])
      render :json => {:status => 'SUCCESS', :displayValue => [@make.name, @make.description]}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxDelete
    @make = Make.find(params[:id])
    if @make.delete
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

end
