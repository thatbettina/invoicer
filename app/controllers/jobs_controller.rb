class JobsController < ApplicationController

  before_filter :find_job, :only => [:edit, :update, :show, :destroy]

  def index
    params[:sort] ? sort = "#{params[:sort]}" : sort = "start_date"
    if params[:order] == "ASC"
      order = "ASC"
      @order = "DESC"
    else
      order = "DESC"
      @order = "ASC"
    end
    @jobs = Job.order("#{sort} #{order}").includes(:invoice)
    @job_hours = Job.sum(:hours)
    @job_amounts = Job.sum(:amount)
  end

  def new
    @job = Job.new(invoice_id: params[:invoice_id])
    @invoice_id = params[:invoice_id]
  end

  def create
    @job = Job.create(job_params)
    if @job.save
      @invoice = Invoice.find(@job.invoice_id)
      @invoice.save
      flash[:notice] = "“#{@job.description}” was created."
      redirect_to :action => :edit, id: @job.id
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @job.update_attributes(job_params)
      @invoice = Invoice.find(@job.invoice_id)
      @invoice.save
      flash[:notice] = "“#{@job.description}” has been updated."
      redirect_to :action => :edit, id: @job.id
    else
      render :action => :edit
    end
  end

  def show
  end

  def destroy
    @job.destroy
    flash[:notice] = "“#{@job.description}” was deleted."
    redirect_to :back
  end

  private

    def find_job
      if params[:id].present? && params[:id] == "clone"
        @job = Job.new
      else 
        @job = Job.find(params[:id])
      end
      @invoice_id = @job.invoice_id
    end

    def job_params
      params.require(:job).permit(:invoice_id, :description, :rate, :hours, :amount, :start_date, :end_date)
    end

end
