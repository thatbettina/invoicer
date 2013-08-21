class InvoicesController < ApplicationController
  before_filter :find_invoice, :only => [:edit, :update, :show, :print, :destroy, :toggle]

  def index
    params[:sort] ? sort = "#{params[:sort]}" : sort = "date"
    if params[:order] == "ASC"
      order = "ASC"
      @order = "DESC"
    else
      order = "DESC"
      @order = "ASC"
    end
    @invoices = Invoice.order("#{sort} #{order}").includes(:company, :jobs).paginate(page: params[:page], per_page: @per_page)
    @invoice_earnings_total = Invoice.sum(:total)
    @invoice_earnings = Invoice.sum(:paid)
  end

  def new
    @invoice = Invoice.new
  end

  def create
    @invoice = Invoice.create(invoice_params)
    if @invoice.save
      flash[:notice] = "“#{@invoice.number}” was created."
      redirect_to :action => :edit, id: @invoice.id
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @invoice.update_attributes(invoice_params)
      flash[:notice] = "“#{@invoice.number}” has been updated."
      redirect_to :action => :edit, id: @invoice.id
    else
      render :action => :edit
    end
  end

  def show
  end

  def print
    render layout: false
  end

  def destroy
    if @invoice.jobs.present?
      flash[:notice] = "“#{@invoice.number}” can't be deleted."
    else
      @invoice.destroy
      flash[:notice] = "“#{@invoice.number}” was deleted."
    end
    redirect_to :back
  end

  private
 
    def find_invoice
      if params[:id].present? && params[:id] == "clone"
        @invoice = Invoice.new
      else 
        @invoice = Invoice.find(params[:id])
      end
    end

    def invoice_params
      params.require(:invoice).permit(:date, :po, :number, :memo, :company_id, :total, :discount, :billed, :paid, :payday)
    end

end
