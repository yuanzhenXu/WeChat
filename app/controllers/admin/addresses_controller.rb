class Admin::AddressesController < Admin::BaseController

  def index
    @addresses = current_user.addresses.order('is_default desc, created_at desc')

  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user_id = current_user.id
    if @address.save
      after_success_save()
    else
      flash[:alert] = @address.errors.full_messages.join(',')
      render :new

    end
  end

  def edit

  end

  def update
    if @address.update_attributes(address_params)
      after_success_save()
    else
      flash[:alert] = @address.errors.full_messages.join(',')
      render :edit
    end

  end

  def destroy
    @address.destroy
  end

  private
  def address_params
    params.require(:address).permit(:name, :phone, :province_code, :city_code, :street, :is_default)
  end

  def after_success_save

  end
end
