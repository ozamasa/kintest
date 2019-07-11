class PicturesController < ApplicationController

  def index
    require 'kintone'
    
    api = Kintone::Api.new(ENV["KINTONE_HOST"], ENV["CYBOZU_API_TOKEN"])
    app = ENV["KINTONE_APP"]

    title = ENV["KINTONE_FIELD_TITLE"]
    created_at = ENV["KINTONE_FIELD_CREATED"]

    file1 = ENV["KINTONE_FIELD_FILE1"]
    file2 = ENV["KINTONE_FIELD_FILE2"]
    file3 = ENV["KINTONE_FIELD_FILE3"]

    query = Kintone::Query.new { limit 7 } # { f(created_at) == today }
    fields = [ file1, file2, file3, title, created_at ].uniq

    @files = []
    api.records.get(app, query, fields)["records"].each do |record|
      @files << Hash[
        file1:      (api.file.get(record[file1]["value"].first["fileKey"]) rescue nil),
        file2:      (api.file.get(record[file2]["value"].first["fileKey"]) rescue nil),
        file3:      (api.file.get(record[file3]["value"].first["fileKey"]) rescue nil),
        type1:      (record[file1]["value"].first["contentType"] rescue nil),
        type2:      (record[file2]["value"].first["contentType"] rescue nil),
        type3:      (record[file3]["value"].first["contentType"] rescue nil),
        title:      (record[title]["value"] rescue nil),
        created_at: (record[created_at]["value"] rescue nil)
      ]
    end
  end

end
