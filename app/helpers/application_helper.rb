module ApplicationHelper
  def download_url_for(song_key)
    @song_url = AWS::S3::S3Object.url_for(song_key, 'automusicvideosongs', :authenticated => false)
    #binding.pry
  end

  def json
    @json = JSON.parse(`curl -X POST 'http://developer.echonest.com/api/v4/track/upload' -d 'api_key=ZLPOL4KMABYSTIM8A&url=#{@song_url}&bucket=audio_summary'`)
    @id = @json["response"]["track"]["id"]
  end

  def analysis_json
    JSON.parse(`curl -X GET "#{analysis_url}"`)
  end


  def analysis_url
    url = "http://developer.echonest.com/api/v4/track/profile?api_key=ZLPOL4KMABYSTIM8A&format=json&id="
    track_id = @id
    bucket = "&bucket=audio_summary"
    uri = URI.parse(url + track_id + bucket)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    json = JSON.parse(response.body)
    json["response"]["track"]["audio_summary"]["analysis_url"]

  
  end

end
  