require "net/http"
require "uri"
require 'pry'
require 'json'
BOUNDARY = "AaB03x"

#curl -X POST "http://developer.echonest.com/api/v4/track/upload" -d "api_key=ZLPOL4KMABYSTIM8A&url=http://s3.amazonaws.com/automusicvideosongs/09+Special.m4a&bucket=audio_summary"



class Song < ActiveRecord::Base

  # http://developer.echonest.com/api/v4/track/upload?api_key=ZLPOL4KMABYSTIM8A&format=json&id=TRTLKZV12E5AC92E11&bucket=audio_summary
  # curl -X POST "http://developer.echonest.com/api/v4/track/upload" -d "api_key=ZLPOL4KMABYSTIM8A&url=http://example.com/audio.mp3"
  # curl -F "api_key=ZLPOL4KMABYSTIM8A" -F "filetype=mp3" -F "track=@audio.mp3" "http://developer.echonest.com/api/v4/track/upload"
  # curl -X POST -H "Content-Type:application/octet-stream" "http://developer.echonest.com/api/v4/track/upload?api_key=ZLPOL4KMABYSTIM8A&filetype=mp3" --data-binary "@audio.mp3"

  def get_json(file)



    uri = URI.parse('http://developer.echonest.com/api/v4/track/upload?api_key=ZLPOL4KMABYSTIM8A&format=json')
    file = "http://s3.amazonaws.com/automusicvideosongs/09+Special.m4a"

    post_body = []
    post_body << "--#{BOUNDARY}rn"
    post_body << "Content-Disposition: form-data; name='datafile'; filename='#{File.basename(file)}'rn"
    post_body << "Content-Type: text/plainrn"
    post_body << "rn"
    post_body << File.read(file)
    post_body << "rn--#{BOUNDARY}--rn"

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Post.new(uri.request_uri)
    request.body = post_body.join
    request["Content-Type"] = "multipart/form-data, boundary=#{BOUNDARY}"

    http.request(request)





    # @echonest = Echonest(Rails.application.secrets.echonest_api_key)
    # @analysis = @echonest.track.analysis(file)
    # @beats = @analysis.beats
  end


  def analysis_url
    url = "http://developer.echonest.com/api/v4/track/profile?api_key=ZLPOL4KMABYSTIM8A&format=json&id="
    track_id = "TRWRDRR14653DDF69D"
    bucket = "&bucket=audio_summary"
    uri = URI.parse(url + track_id + bucket)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)
    json = JSON.parse(response.body)
    json["response"]["track"]["audio_summary"]["analysis_url"]

    # response.code             # => 301
    # response.body             # => The body (HTML, XML, blob, whatever)
    # # Headers are lowercased
    # response["cache-control"] # => public, max-age=2592000

  end


  def json
    system('curl -X POST "http://developer.echonest.com/api/v4/track/upload" -d "api_key=ZLPOL4KMABYSTIM8A&url=http://s3.amazonaws.com/automusicvideosongs/09+Special.m4a&bucket=audio_summary"')
  end

  def analysis_json
    system('curl -X GET "http://echonest-analysis.s3.amazonaws.com/TR/TRWRDRR14653DDF69D/3/full.json?AWSAccessKeyId=AKIAJRDFEY23UEVW42BQ&Expires=1401571170&Signature=cpVXj5JvHhrP07iLob0ZYgxFV/U%3D"')
  end

end
