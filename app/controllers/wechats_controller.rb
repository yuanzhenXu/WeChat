class WechatsController < ApplicationController
  # For details on the DSL available within this file, see https://github.com/Eric-Guo/wechat#wechat_responder---rails-responder-controller-dsl
  # wechat_api
  layout 'wechat'
  wechat_responder

  def apply_new
    wechat_oauth2 do |userid|
      @current_user = User.find_by(wechat_userid: userid)
      @apply = Apply.new
      @apply.user_id = @current_user.id
    end
  end

  #邀请成员关注
  # def inivite_user(user)
  #   @user = Wechat.api.invite_user(user.id)
  # end
  #
  # #给用户发消息
  # def send_message(openid, message)
  #   @user.openid = Wechat.api.user(openid)
  #   # message = Wechat.api.message_send(@user.openid,message)
  #   # render message
  # end

  # 默认文字信息responder
  on :text do |request, content|
    request.reply.text "#{content}" #Just echo
  end

  # 当请求的文字信息内容为'help'时, 使用这个responder处理
  on :text, with: 'help' do |request|
    # p "***#{Wechat.api.users}********"
    request.reply.text 'help content' #回复帮助信息
  end

  # 当请求的文字信息内容为'<n>条新闻'时, 使用这个responder处理, 并将n作为第二个参数
  on :text, with: /^(\d+)条新闻$/ do |request, count|
    # 微信最多显示8条新闻，大于8条将只取前8条
    news = (1..count.to_i).each_with_object([]) { |n, memo| memo << { title: '新闻标题', content: "第#{n}条新闻的内容#{n.hash}" } }
    request.reply.news(news) do |article, n, index| # 回复"articles"
      article.item title: "#{index} #{n[:title]}", description: n[:content], pic_url: 'http://www.baidu.com/img/bdlogo.gif', url: 'http://www.baidu.com/'
    end
  end

  # 当用户加关注
  on :event, with: 'subscribe' do |request|
    # request.reply.text "User #{request[:FromUserName]} subscribe now"
    if WechatUser.exist?(openid:request[:FromUserName])
      @wechat_user.openid = request[:FromUserName]
      @wechat_user.event = 'subscribe'
      @wechat_user.subscribe_at = Time.now
      @wechat_user.save!
    else
      @wechat_user = WechatUser.new
      @wechat_user.openid = request[:FromUserName]
      @wechat_user.event = 'subscribe'
      @wechat_user.subscribe_at = Time.now
      @wechat_user.save!
    end
    request.reply.news([welcome_message]) do |article, n, index|
      article.item title: n[:title], description: nil, pic_url: n[:pic_url], url: n[:url]
    end

    p '#######'
    p request

  end


  def welcome_message
    {
     :title => "欢迎你",
     :content => "未完待续..........",
     :pic_url => "",
     :url => root_url

    }
  end
  # 公众号收到未关注用户扫描qrscene_xxxxxx二维码时。注意此次扫描事件将不再引发上条的用户加关注事件
  on :scan, with: 'qrscene_xxxxxx' do |request, ticket|
    request.reply.text "Unsubscribe user #{request[:FromUserName]} Ticket #{ticket}"
  end

  # 公众号收到已关注用户扫描创建二维码的scene_id事件时
  on :scan, with: 'scene_id' do |request, ticket|
    request.reply.text "Subscribe user #{request[:FromUserName]} Ticket #{ticket}"
  end

  # 当没有任何on :scan事件处理已关注用户扫描的scene_id时
  on :event, with: 'scan' do |request|
    if request[:EventKey].present?
      request.reply.text "event scan got EventKey #{request[:EventKey]} Ticket #{request[:Ticket]}"
    end
  end


  # 处理图片信息
  # 直接将图片返回给用户
  on :image do |request|
    request.reply.image(request[:MediaId])
  end

  # 处理语音信息
  # 直接语音音返回给用户
  on :voice do |request|
    request.reply.voice(request[:MediaId])
  end

  # 处理视频信息
  # 调用 api 获得发送者的nickname
  # 直接视频返回给用户
  on :video do |request|
    nickname = wechat.user(request[:FromUserName])['nickname']
    request.reply.video(request[:MediaId], title: '回声', description: "#{nickname}发来的视频请求")
  end

  # 处理地理位置消息
  on :label_location do |request|
    request.reply.text("Label: #{request[:Label]} Location_X: #{request[:Location_X]} Location_Y: #{request[:Location_Y]} Scale: #{request[:Scale]}")
  end

  # 处理上报地理位置事件
  on :location do |request|
    request.reply.text("Latitude: #{request[:Latitude]} Longitude: #{request[:Longitude]} Precision: #{request[:Precision]}")
  end

  # 当用户取消关注订阅
  on :event, with: 'unsubscribe' do |request|
    request.reply.success # user can not receive this message
  end


  # 成员进入应用的事件推送
  # on :event, with: 'enter_agent' do |request|
  #   request.reply.text "#{request[:FromUserName]} enter agent app now"
  # end
  #
  # # 当异步任务增量更新成员完成时推送
  # on :batch_job, with: 'sync_user' do |request, batch_job|
  #   request.reply.text "job #{batch_job[:JobId]} finished, return code #{batch_job[:ErrCode]}, return message #{batch_job[:ErrMsg]}"
  # end
  #
  # # 当异步任务全量覆盖成员完成时推送
  # on :batch_job, with: 'replace_user' do |request, batch_job|
  #   request.reply.text "job #{batch_job[:JobId]} finished, return code #{batch_job[:ErrCode]}, return message #{batch_job[:ErrMsg]}"
  # end
  #
  # # 当异步任务邀请成员关注完成时推送
  # on :batch_job, with: 'invite_user' do |request, batch_job|
  #   request.reply.text "job #{batch_job[:JobId]} finished, return code #{batch_job[:ErrCode]}, return message #{batch_job[:ErrMsg]}"
  # end

  # 当异步任务全量覆盖部门完成时推送
  # on :batch_job, with: 'replace_party' do |request, batch_job|
  #   request.reply.text "job #{batch_job[:JobId]} finished, return code #{batch_job[:ErrCode]}, return message #{batch_job[:ErrMsg]}"
  # end

  # 事件推送群发结果
  # on :event, with: 'masssendjobfinish' do |request|
  #   # https://mp.weixin.qq.com/wiki?action=doc&id=mp1481187827_i0l21&t=0.03571905015619936#8
  #   request.reply.success # request is XML result hash.
  # end

  # 当无任何responder处理用户信息时,使用这个responder处理
  on :fallback, respond: '欢迎你'
  # template = YAML.load(File.read(template_yaml_path))
  # Wechat.api.template_message_send Wechat::Message.to(openid).template(template['template'])
  #
  # ActiveSupport::Notifications.subscribe('wechat.responder.after_create') do |name, started, finished, unique_id, data|
  #   WechatLog.create request: data[:request], response: data[:response]
  # end

  # 获取用户的nickname,headimageurl
  # def fetch_user(openid)
  #   _hash = wechat.user(openid)
  #   user = User.find_or_initilize_via_wechat(openid)
  #   user.attribute = {
  #       nickname: _hash['nickename'].presence || user.nickname,
  #       headimageurl: _hash['headimgurl'].presence || user.headimageurl
  #   }
  #   user.save!
  #   return user
  # end
end
