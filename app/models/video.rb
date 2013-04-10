require 'open-uri'
require 'tempfile'

class Video < ActiveRecord::Base
  API_KEY = '25718772'
  API_SECRET = '5af4390c86057b8f1f561c0f751d595ebd800543'
  TOKEN = 'T1==cGFydG5lcl9pZD0yNTcxODc3MiZzZGtfdmVyc2lvbj10YnJ1YnktdGJyYi12MC45MS4yMDExLTAyLTE3JnNpZz01ZjFjMWEwZGY4OTM2NGNjNTM3Y2RiNjI5N2ExOGE1ODg2MGIwMjcxOnJvbGU9bW9kZXJhdG9yJnNlc3Npb25faWQ9Ml9NWDR5TlRjeE9EYzNNbjR4TWpjdU1DNHdMakYtVkhWbElFRndjaUF3T1NBeE1UbzBNRG93TkNCUVJGUWdNakF4TTM0d0xqTTNOamt3TXpSLSZjcmVhdGVfdGltZT0xMzY1NTMyODEwJm5vbmNlPTAuMTE5MTI5NzY3NDY5NDkyNDQmZXhwaXJlX3RpbWU9MTM2ODEyNDgxMiZjb25uZWN0aW9uX2RhdGE9'
  attr_accessible :tokbox_id, :tokbox_url, :user_id
  belongs_to :user

  after_create :upload_to_facebook

  def upload_to_facebook
    puts "user_id in model #{user_id}"
    puts "1 - #{tokbox_url}"
    while tokbox_url.blank? || tokbox_url =~ /itemNotFound/
      puts "2 - #{tokbox_url}"
      sleep 1
      self.tokbox_url = download_tokbox_url
    end
    puts "3 - #{tokbox_url}"

    tempfile = Tempfile.new(['foo', '.flv'])
    File.open(tempfile.path, 'wb') do |f|
      f.write(open(tokbox_url).read)
    end

    user = User.find(user_id)
    graph = Koala::Facebook::API.new(user.oauth_token)
    graph.put_video(tempfile.path)
    save!
  end

  def download_tokbox_url
    otsdk = OpenTok::OpenTokSDK.new(API_KEY, API_SECRET)
    otArchive = otsdk.getArchiveManifest(tokbox_id, TOKEN)
    otVideoResource = otArchive.resources[0]
    videoId = otVideoResource.getId()
    otArchive.downloadArchiveURL(videoId, TOKEN)
  end
end
