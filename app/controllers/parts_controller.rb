class PartsController < ApplicationController
  
  def index
    @parts = Part.all(:order => "number")
    @total_parts = Part.count    
    @page = params[:page]?params[:page]:1 
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def ajaxIndex
    @parts = Part.all(:order => "number")
    @total_parts = Part.count    
    @page = params[:page]?params[:page]:1 
    render :partial => 'result', :locals => { :parts => @parts, :total_parts => @total_parts, :page => @page}
  end

  def ajaxEdit
    @part = Part.find(params[:part_id])
    @models = Model.all(:order => "number")
    render :partial => 'edit', :locals => { :part => @part, :models => @models}    
  end

  def ajaxNew
    @part = Part.new
    @models = Model.all(:order => "number")
    render :partial => 'new', :locals => { :part => @part, :models => @models}    
  end

  def ajaxUpdate
    @part = Part.find(params[:id])
    @part.update_attributes(params[:part])

    ModelPart.where(:part_id => @part.id).delete_all

    if(params[:model_ids])
    @model_ids = params[:model_ids]
    @model_ids.each do |model_id|
      @modelPart = ModelPart.new
      @model = Model.find(model_id)
      @modelPart.part = @part
      @modelPart.model = @model
      @modelPart.save
    end    
    end

    if @part.update_attributes(params[:part])
      render :json => {:status => 'SUCCESS', :part => @part, :modelNumbers => @part.model_parts.collect { |modelPart| modelPart.model.number }.join(' ')}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxCreate
    @part = Part.new(params[:part])

    if(params[:model_ids])
    @model_ids = params[:model_ids]
    @model_ids.each do |model_id|
      @modelPart = ModelPart.new
      @model = Model.find(model_id)
      @modelPart.part = @part
      @modelPart.model = @model
      @modelPart.save
    end    
    end

    if @part.save
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxDelete
    @part = Part.find(params[:part_id])
    if @part.delete
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

end


