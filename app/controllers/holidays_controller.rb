class HolidaysController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @holidays = Holiday.where(:user_id => current_user.id)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @holidays }
    end
  end

  # GET /holidays/1
  # GET /holidays/1.xml
  def show
    @holiday = Holiday.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @holiday }
    end
  end

  # GET /holiday/new
  # GET /holiday/new.xml
  def new
    @holiday = Holiday.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @holiday }
    end
  end

  # GET /holidays/1/edit
  def edit
    @holiday = Holiday.find(params[:id])
  end

  # POST /holidays
  # POST /holidays.xml
  def create
    @holiday = Holiday.new(params[:holiday])
    @holiday.user_id = current_user.id

    respond_to do |format|
      if @holiday.save
        format.html { redirect_to(@holiday, :notice => 'Holiday was successfully created.') }
        format.xml  { render :xml => @holiday }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @holiday.errors}
      end
    end
  end

  # PUT /holidays/1
  # PUT /holidays/1.xml
  def update
    @holiday = Holiday.find(params[:id])

    respond_to do |format|
      if @holiday.update_attributes(params[:holiday])
        format.html { redirect_to(@holiday, :notice => 'Holiday was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @holiday.errors}
      end
    end
  end

  # DELETE /holidays/1
  # DELETE /holidays/1.xml
  def destroy
    @holiday = Holiday.find(params[:id])
    @holiday.destroy

    respond_to do |format|
      format.html { redirect_to(holidays_url) }
      format.xml  { head :ok }
    end
  end    
end
