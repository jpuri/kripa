class PartModelsController < ApplicationController
  # GET /part_models
  def index
    @part_models = PartModel.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /part_models/1
  def show
    @part_model = PartModel.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /part_models/new
  def new
    @part_model = PartModel.new
	@part_model.part = Part.find(params[:part_id])
	
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /part_models/1/edit
  def edit
    @part_model = PartModel.find(params[:id])
  end

  # POST /part_models
  def create
  
    @part_model = PartModel.new()
    @part_model.model_name = params[:part_model][:model_name]
	@part_model.part = Part.find(params[:part_model][:part_id])

    respond_to do |format|
      if @part_model.save
		format.html { redirect_to :controller=>'parts', :action => 'index' }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /part_models/1
  def update
    @part_model = PartModel.find(params[:id])

    respond_to do |format|
      if @part_model.update_attributes(params[:part_model])
        format.html { redirect_to(@part_model, :notice => 'Part model was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /part_models/1
  def destroy
    @part_model = PartModel.find(params[:id])
    @part_model.destroy

    respond_to do |format|
      format.html { redirect_to(part_models_url) }
    end
  end
  
  # GET /part_models/getModelsForPart
  def getModelsForPart
	@models = PartModel.where("part_id = ?", (params[:part_id]))	
    render :json => @models
  end

  
end
