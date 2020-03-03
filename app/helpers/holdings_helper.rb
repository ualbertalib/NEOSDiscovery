# frozen_string_literal: true

require_relative '../services/symphony_service.rb'
require_relative '../services/marc_module.rb'

module HoldingsHelper
  include MarcModule

  def holdings(document, method)
    doc = nokogiri document
    id = get_marc_id(doc)
    begin
      SymphonyService.new(id).send(method)
    rescue SymphonyService::Error::HTTPError => e
      logger.error e.message
      nil
    end
  end

  def location(item)
    Location.find_by!(short_code: item[:location].downcase.delete('_').to_sym)
  rescue ActiveRecord::RecordNotFound => e
    Rollbar.error("Error retriving name for Location #{item[:location].downcase.delete('_').to_sym}", e)
    Location.create(
      short_code: item[:location].downcase.delete('_').to_sym,
      name: 'Unknown'
    )
  end

  def links(name)
    # TODO: Concordia is a special case.  It's name is "Concordia Internet Library"
    # but it's link is "Concordia University of Edmonton Access"
    if name == 'Concordia Internet Library'
      name = 'Concordia University of Edmonton'
    end

    # :links will get all the links, at this point we want just the one that matches
    # the name we passed or the free resource
    holdings(@document, :links).inject(:merge).select do |k|
      free?(k) || name.include?(k.partition(' Access ').first)
    end || {}
  end

  def proxy(location)
    location.library.proxy
  end

  def free?(name)
    name.include?('NEOS') || name.include?('Free')
  end

  def proxy?(name)
    !free?(name)
  end

  def electronic_access_url(enable_proxy, proxy, url)
    return url unless enable_proxy

    proxy + url
  end

  def status(item)
    if item[:status] == 'CHECKEDOUT'
      if item[:due]
        "Due: #{Date.parse(item[:due])}" if item[:due]
      else
        'Unknown/Never'
      end
    else
      Status.find_by!(short_code: [item[:status].to_s.downcase]).name
    end
  rescue ActiveRecord::RecordNotFound => e
    Rollbar.error("Error retriving name for Status #{item[:status].to_s.downcase}", e)
    Status.create(short_code: item[:status].to_s.downcase, name: 'Unknown')
    'Unknown'
  end

  def unavailable?(item)
    Status.find_by(short_code: item[:status].to_s.downcase).name == 'unavailable'
  end
end
