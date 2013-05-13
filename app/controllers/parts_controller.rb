class PartsController < ApplicationController

  before_filter :session_timeout

  def index
    @parts = Part.all(:order => "number")
  end

  def ajaxSearch
    @parts = Part.all(:order => "number")
    render :partial => 'result', :locals => { :parts => @parts}
  end

  def ajaxNew
    @part = Part.new
    @models = Model.all(:order => "number")
    render :partial => 'new', :locals => { :part => @part, :models => @models}    
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

  def ajaxEdit
    @part = Part.find(params[:id])
    @models = Model.all(:order => "number")
    render :partial => 'edit', :locals => { :part => @part, :models => @models}    
  end

  def ajaxUpdate
    @part = Part.find(params[:id])

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
      render :json => {:status => 'SUCCESS', :displayValue => [@part.number, @part.description, @part.weight,
        @part.model_parts.collect { |modelPart| modelPart.model.number }.join(', ')]}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxDelete
    @part = Part.find(params[:id])
    if @part.delete
      render :json => {:status => 'SUCCESS'}
    else
      render :json => {:status => 'FAILURE'}
    end
  end

  def ajaxAutoCompleteValue
    @parts = Part.all(:order => "number")
      render :json => {:list => @parts.collect { |part| part.number }}
  end

end
