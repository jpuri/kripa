class BillPartsController < ApplicationController
  # GET /bill_parts
  # GET /bill_parts.xml
  def index
    @bill_parts = BillPart.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bill_parts }
    end
  end

  # GET /bill_parts/1
  # GET /bill_parts/1.xml
  def show
    @bill_part = BillPart.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bill_part }
    end
  end

  # GET /bill_parts/new
  # GET /bill_parts/new.xml
  def new
    @bill_part = BillPart.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bill_part }
    end
  end

  # GET /bill_parts/1/edit
  def edit
    @bill_part = BillPart.find(params[:id])
  end

  # POST /bill_parts
  # POST /bill_parts.xml
  def create
    @bill_part = BillPart.new(params[:bill_part])

    respond_to do |format|
      if @bill_part.save
        format.html { redirect_to(@bill_part, :notice => 'Bill part was successfully created.') }
        format.xml  { render :xml => @bill_part, :status => :created, :location => @bill_part }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @bill_part.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /bill_parts/1
  # PUT /bill_parts/1.xml
  def update
    @bill_part = BillPart.find(params[:id])

    respond_to do |format|
      if @bill_part.update_attributes(params[:bill_part])
        format.html { redirect_to(@bill_part, :notice => 'Bill part was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bill_part.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /bill_parts/1
  # DELETE /bill_parts/1.xml
  def destroy
    @bill_part = BillPart.find(params[:id])
    @bill_part.destroy

    respond_to do |format|
      format.html { redirect_to(bill_parts_url) }
      format.xml  { head :ok }
    end
  end
end
