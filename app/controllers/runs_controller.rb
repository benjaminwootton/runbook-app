class RunsController < ApplicationController
  # GET /runs
  # GET /runs.json
  def index
    @runs = Run.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @runs }
    end
  end

  # GET /runs/1
  # GET /runs/1.json
  def show
    @run = Run.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @run }
    end
  end

  # GET /runs/new
  # GET /runs/new.json
  def new
    book = Book.find(params[:book_id])    
    @run = book.runs.build


      
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @run }
    end
  end
 
  # GET /runs/1/edit
  def edit
    @run = Run.find(params[:id])
  end

  # POST /runs
  # POST /runs.json
  def create
    @run = Run.new(params[:run])
    @run.user_id = current_user.id

    respond_to do |format|
      if @run.save
        format.html { redirect_to @run.book.steps.first, notice: 'Run was successfully created.' }                
      else
        format.html { render action: "new" }        
      end
    end
  end

  # PUT /runs/1
  # PUT /runs/1.json
  def update
    @run = Run.find(params[:id])

    respond_to do |format|
      if @run.update_attributes(params[:run])
        format.html { redirect_to @run, notice: 'Run was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /runs/1
  # DELETE /runs/1.json
  def destroy
    @run = Run.find(params[:id])
    @run.destroy

    respond_to do |format|
      format.html { redirect_to runs_url }
      format.json { head :no_content }
    end
  end

  def finish
      @run = Run.find(params[:id])
      @run.complete = true
      @run.save
  end

  def sendmail
      puts 'Sending Mail!'
      @run = Run.find(params[:id])
      respond_to do |format|
        format.html { render action: "finish" }
      end

  end


end
