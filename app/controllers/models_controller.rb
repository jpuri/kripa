class ModelsController < ApplicationController

  def index
    @models = Model.all(:order => "number")
  end

  def ajaxSearch
    @models = Model.all(:order => "number")
    render :partial => 'result', :locals => { :models => @models}
  end

  def ajaxNew
    @model = Model.new
    @makes = Make.all(:order => "name")
    render :partial => 'new', :locals => { :model => @model, :makes => @makes}    
  end

  def ajaxCreate
    @model = Model.new(params[:model])

    if @model.save
     render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxEdit
    @model = Model.find(params[:id])
    @makes = Make.all(:order => "name")
    render :partial => 'edit', :locals => { :model => @model, :makes => @makes}    
  end

  def ajaxUpdate
    @model = Model.find(params[:id])

    if @model.update_attributes(params[:model])
      render :json => {:status => 'SUCCESS', :displayValue => [@model.make.name, @model.number, @model.description]}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxDelete
    @model = Model.find(params[:id])
    if @model.delete
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

end
