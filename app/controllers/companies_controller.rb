class CompaniesController < ApplicationController

  before_filter :find_company, :only => [:edit, :update, :destroy]

  def index
    params[:sort] ? sort = "#{params[:sort]}" : sort = "name"
    if params[:order] == "ASC" || params[:order].blank?
      order = "ASC"
      @order = "DESC"
    else
      order = "DESC"
      @order = "ASC"
    end
    @companies = Company.order("#{sort} #{order}")
    @invoice_earnings_total = Invoice.sum(:billed)
    @invoice_earnings = Invoice.sum(:paid)
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.create(company_params)
    if @company.save
      flash[:notice] = "“#{@company.name}” was created."
      redirect_to :action => :edit, id: @company.id
    else
      render :action => :new
    end
  end

  def edit
  end

  def update
    if @company.update_attributes(company_params)
      flash[:notice] = "“#{@company.name}” has been updated."
      redirect_to :action => :edit, id: @company.id
    else
      render :action => :edit
    end
  end

  def destroy
    if @company.invoices.present?
      flash[:notice] = "“#{@company.name}” can't be deleted."
    else
      @company.destroy
      flash[:notice] = "“#{@company.name}” was deleted."
    end
    redirect_to :back
  end

  private

    def find_company
      if params[:id].present? && params[:id] == "clone"
        @company = Company.new
      else 
        @company = Company.find(params[:id])
      end
    end

    def company_params
      params.require(:company).permit(:name, :email, :address, :phone)
    end

end
