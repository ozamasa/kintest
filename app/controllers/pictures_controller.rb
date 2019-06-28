class PicturesController < ApplicationController

  def index
    require 'kintone'
    
    api = Kintone::Api.new(ENV["KINTONE_HOST"], ENV["CYBOZU_API_TOKEN"])
    app = ENV["KINTONE_APP"]

    file = ENV["KINTONE_FIELD_FILE"]
    title = ENV["KINTONE_FIELD_TITLE"]
    created_at = ENV["KINTONE_FIELD_CREATED"]

    query = Kintone::Query.new { f(created_at) == today }  #limit 5
    fields = [ file, title, created_at ]

    @files = []
    api.records.get(app, query, fields)["records"].each do |record|
      @files << Hash[
        file:       (api.file.get(record[file]["value"].first["fileKey"]) rescue nil),
        type:       (record[file]["value"].first["contentType"] rescue nil),
        title:      (record[title]["value"] rescue nil),
        created_at: (record[created_at]["value"] rescue nil)
      ]
    end
  end

end
