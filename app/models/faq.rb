class Faq < ApplicationRecord
  validates :title, presence: true
  # include HasExternalImg
  acts_as_list add_new_at: :bottom

  scope :order_by_position, -> { order('position asc') }
  scope :online, -> {where(is_online: true)}
  # before_save do
  #   str = self.content
  #   str = self.class.replace_external_img(str)
  #   self.content = str
  # end
end
