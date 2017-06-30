class User < ApplicationRecord
  validates :name, presence: true
  validates :wechat_num, presence: true

  # config.omniauth :wechat, "wxbe0340edbe6d3316", "c803758db02c441a19f546107348602a",
  #                 :authorize_params => {:scope => "snsapi_userinfo"}
end
