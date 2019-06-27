class PicturesController < ApplicationController

  def index
    require 'kintone'
    
    api = Kintone::Api.new(ENV["KINTONE_HOST"], ENV["CYBOZU_API_TOKEN"])
    app = ENV["KINTONE_APP"]
    id = ENV["KINTONE_ID"]

    fields = ["name", "file", "作成日時"]
    query = Kintone::Query.new { f("作成日時") == today }  #limit 5

    @files = []
    api.records.get(app, query, fields)["records"].each do |record|
      value = record["file"]["value"].first
      h = {}
      h[:file] = api.file.get(record["file"]["value"].first["fileKey"])
      h[:name] = record["name"]["value"]
      h[:created_at] = record["作成日時"]["value"]
      @files << h
    end
  end

end
