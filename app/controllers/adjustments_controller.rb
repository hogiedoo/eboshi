class AdjustmentsController < ApplicationController
  before_filter :get_client
  before_filter :authorized?

  before_filter [:filter_date, :filter_user], :only => [:create, :update]

  # actions :all, :except => [:index, :show]

  def new
    @adjustment = @client.adjustments.build
  end

  def create
    @adjustment = @client.adjustments.build params[:adjustment]
    if @adjustment.save
      flash[:notice] = "Adjustment successfully created."
      redirect_to invoices_path(@client)
    else
      render :new
    end
  end

  def edit
    @adjustment = Adjustment.find params[:id]
  end

  def update
    @adjustment = Adjustment.find params[:id]
    if @adjustment.update_attributes params[:adjustment]
      respond_to do |wants|
        wants.html { redirect_to invoices_path(@client) }
        wants.js { render :nothing => true }
      end
    else
      respond_to do |wants|
        wants.html { render :edit }
        wants.js { exit }
      end
    end
  end

  def destroy
    @adjustment = Adjustment.find params[:id]
    respond_to do |wants|
      wants.html { redirect_to invoices_path(@client) }
      wants.js { render :json => object.invoice_total }
    end
  end

  private
    def filter_date
      a = params[:adjustment]
      if a.delete(:no_date) == "1"
        a[:start] = nil 
        a.delete_if { |key, value| key =~ /^start\(.i\)$/ }
      end
    end

    def filter_user
      a = params[:adjustment]
      a[:user_id] = current_user.id if a[:user_id].blank?
      a[:user_id] = nil if a.delete(:no_user) == "1"
    end

    def get_client
      @client ||= (object.try(:client) || Client.find(params[:client_id]))
    end

    def authorized?
      current_user.authorized? @client
    end
end
