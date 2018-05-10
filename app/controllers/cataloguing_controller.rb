require 'zoom'

class CataloguingController < ApplicationController

  def index
    # present form which accepts catkey
  end

  def create
    # harvest record using z39.50
    @catkey = params['record']['catkey']
    ZOOM::Connection.open('ualapp.library.ualberta.ca', 2200) do |conn|
      conn.database_name = 'Unicorn'
      conn.preferred_record_syntax = 'USMARC'
      rset = conn.search(@catkey)
      File.open("#{Rails.root}/tmp/records/#{@catkey}.mrc", 'wb'){|f|
        f.write rset[0].raw
      }
    end
  end

end
