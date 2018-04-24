class ContactsController < ApplicationController
  
  def index
    @contact = Contact.new
    render :action => 'index'
  end

  def confirm
    @contact = Contact.new(contact_params)

    if @contact.valid?
      render :action => 'confirm'
    else
      render :action => 'index'
    end
  end

  def create
    begin
      @contact = Contact.new(contact_params)
      UserMailer.contact_form(@contact).deliver
      flash.now[:error] = nil
      render :action => 'create'
    rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
      flash[:error] = "送信できませんでした。"
    end
  end

  private
    def contact_params
     params.require(:contact).permit(:name, :email, :message)
    end
    
end
