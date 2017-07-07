require "omniauth-oauth2"

# module OmniAuth
#   module Strategies
#     class Wechat < OmniAuth::Strategies::OAuth2
#       def raw_info
#         @uid = access_token["openid"]
#         @raw_info ||= begin
#           access_token.options[:model] = :query
#           if access_token["scope"] == "snsapi_userinfo"
#             @raw_info = access_token.get("/sns/userinfo", :params => {"openid" => @uid, "lang" => "zh_CN"}, parse: :json).parsed
#           else
#             @raw_info = {"openid" => @uid }
#           end
#         end
#       end
#     end
#   end
# end
#
# module Wechat
#   class Api < ApiBase
#     def material(media_id)
#       get 'media/get', params: { media_id: media_id, base: 'http://file.api.weixin.qq.com/cgi-bin/' }, as: :file
#     end
#   end
# end