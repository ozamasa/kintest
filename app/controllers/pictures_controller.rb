class PicturesController < ApplicationController

  def index
    require 'kintone'
    
    api = Kintone::Api.new("example.cybozu.com", "authtoken")
  end

end
