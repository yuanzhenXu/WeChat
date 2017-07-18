class Faq < ApplicationRecord

  scope :order_by_position, -> {order('position asc')}
  scope :online, -> {where(is_online: true)}
end
