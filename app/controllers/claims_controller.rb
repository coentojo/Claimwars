class ClaimsController < ApplicationController
  
  #currently only saving artist, song title, and release date (consider album name)
  def new
    if current_user
      require 'net/http'
      data = params[:q].split('-')
      q = "'"+data[0]+"'"
      url = 'http://ws.spotify.com/search/1/track.json?q='+q
      result = Net::HTTP.get(URI.parse(URI.encode(url.strip)))
      parsed_json = ActiveSupport::JSON.decode(result)
      @released = parsed_json["tracks"][0]["album"]["released"]
      @album = parsed_json["tracks"][0]["album"]["name"]
      @track = q
      @sid = parsed_json["tracks"][0]["external-ids"][0]["id"]
      @artist = parsed_json["tracks"][0]["artists"][0]["name"]
      @claim = Claim.new
    else
      flash[:notice] = "Please sign in"
      redirect_to pages_path
    end
    
  end
  
  def show
    @c = Claim.find_by_id(params[:id])
    @s = Song.find_by_sid(@c.sid) 
    @world_claims = Claim.where(:sid => @c.sid).limit(10)
    puts 'BALS'
    puts @world_claims.to_yaml
    @total_users = Array.new
    @world_claims.each do |w|
      @total_users << User.find_by_uid(w.uid)
    end
  end

  def create
    released = params[:released]
    artist = params[:artist]
    album = params[:album]
    title = params[:title]
    sid = params[:sid]
    s = Song.new(:artist => artist, :title => title, :album => album, :sid => sid, :released => released )
    if s.save 
      u = User.find_by_id(current_user.id)
      c = Claim.new(:sid => s.sid, :uid => u.uid, :listened_at => Time.now)
      if c.save 
        flash[:notice] ="Successfully claimed!"
        redirect_to claim_path(c)
      else
        flash[:notice] = "Already claimed this!"
        redirect_to claim_path(c)
      end
    end
    
  end
end
