class RTablesController < ApplicationController
  # GET /r_tables
  # GET /r_tables.json
  def index
    @r_tables = RTable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @r_tables }
    end
  end

  # GET /r_tables/1
  # GET /r_tables/1.json
  def show
    @r_table = RTable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @r_table }
    end
  end

  # GET /r_tables/new
  # GET /r_tables/new.json
  def new
    @r_table = RTable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @r_table }
    end
  end

  # GET /r_tables/1/edit
  def edit
    @r_table = RTable.find(params[:id])
  end

  # POST /r_tables
  # POST /r_tables.json
  def create
    @r_table = RTable.new(params[:r_table])

    respond_to do |format|
      if @r_table.save
        format.html { redirect_to @r_table, :notice => 'R table was successfully created.' }
        format.json { render :json => @r_table, :status => :created, :location => @r_table }
      else
        format.html { render :action => "new" }
        format.json { render :json => @r_table.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /r_tables/1
  # PUT /r_tables/1.json
  def update
    @r_table = RTable.find(params[:id])

    respond_to do |format|
      if @r_table.update_attributes(params[:r_table])
        format.html { redirect_to @r_table, :notice => 'R table was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @r_table.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /r_tables/1
  # DELETE /r_tables/1.json
  def destroy
    @r_table = RTable.find(params[:id])
    @r_table.destroy

    respond_to do |format|
      format.html { redirect_to r_tables_url }
      format.json { head :ok }
    end
  end
end
