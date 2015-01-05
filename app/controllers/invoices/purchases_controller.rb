class Invoices::PurchasesController < ApplicationController
  #before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @purchases = Purchase.all
    respond_with(@purchases)
  end

  def show
    respond_with(@purchase)
  end

  def new
    @invoice = Invoice.find(params[:invoice_id])
    @purchase = Purchase.new
    #respond_with(@purchase)
  end

  def edit
  end

  def create
    @invoice = Invoice.find(params[:invoice_id])
    @purchase = Purchase.new(purchase_params)
    @purchase.invoice = @invoice

    @purchase.save
    #respond_with(@purchase)
    respond_with(@invoice)
  end

  def update
    @purchase.update(purchase_params)
    respond_with(@purchase)
  end

  def destroy
    @invoice = Invoice.find(params[:invoice_id])
    @purchase = Purchase.find(params[:id])
    title = @purchase.name

    if @purchase.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      respond_with(@invoice)
    else
      flash[:error] = "There was an error deleting the purchase"
      render :show
    end
  end

  private
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    def purchase_params
      params.require(:purchase).permit(:name, :category, :quantity, :invoice_id)
    end
end
