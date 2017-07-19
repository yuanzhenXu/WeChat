class Admin::FaqsController < Admin::BaseController
  before_action :fetch_faq, only: [:show, :edit, :update, :destroy ]

  def index
    @faqs = Faq.all.order_by_position.page(params[:page]||1).per(20)
    # @faqs = @faqs.order('created_at desc').page(params[:page]||1).per(20)
  end

  def new
    @faq = Faq.new
  end

  def edit

  end

  def create
    @faq = Faq.new(faq_params)
    if @faq.save
      flash[:notice] = "保存成功"
      redirect_to admin_faqs_path
    else
      flash[:alert] = @faqs.errors.full_messages.join('.')
      render action: 'new'
    end
  end

  def update
    if @faq.update(faq_params)
      flash[:notice] = "修改成功"
      redirect_to admin_faqs_path
    else
      flash[:alert] = @faq.error.full_messages.join('.')
      render action: 'edit'

    end
  end
  def destroy
    @faq.destroy
    flash[:notice] = "成功删除"
    redirect_to admin_faqs_path
  end

  private
  def fetch_faq
    @faq = Faq.find(params[:id])
  end

  def faq_params
    params.require(:faq).permit(:title, :position, :content, :is_online)
  end

end
