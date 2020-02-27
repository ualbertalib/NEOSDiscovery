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

  def location_name(item)
    Location.find_by!(short_code: item[:location].downcase.gsub('_', '')).name || 'Unknown'
  end

  def location_url(item)
    Location.find_by!(short_code: item[:location].downcase.gsub('_', '')).url
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

  # prefix of location to group
  LIBRARIES = {
    'AGINTERNET' => 'gov',
    'AGL_CAP' => 'gov',
    'AHS_ACH' => 'abhealth',
    'AHS_INT' => 'abhealth',
    'AHS_KEC' => 'abhealth',
    'AHS_REDDR' => 'abhealth',
    'AHS_RVG' => 'abhealth',
    'AHS_TBCC' => 'abhealth',
    'AHSGLENRSE' => 'abhealth',
    'BURMAN' => 'burmanuniversity',
    'CONCORDIA' => 'concordia',
    'CONCORDSEM' => 'concordia',
    'CONCORD_IN' => 'concordia',
    'COVENANTMH' => 'covenant',
    'GPRC_GP' => 'gp',
    'GPRC_FRVW' => 'gp',
    'GPRC_INT' => 'gp',
    'GR_MAC_ACC' => 'macewanuniversity',
    'GR_MAC_INT' => 'macewanuniversity',
    'GR_MACEWAN' => 'macewanuniversity',
    'KEYANO' => 'keyano',
    'KINGS' => 'kings',
    'LAKELND_IN' => 'lakeland',
    'LAKELND_LL' => 'lakeland',
    'LAKELND_VR' => 'lakeland',
    'NEWMAN' => 'newman',
    'NLC_INT' => 'nlc',
    'NLC_SL' => 'nlc',
    'NLC_GR' => 'nlc',
    'NORQ_MAIN' => 'norquest',
    'OLDS' => 'olds',
    'RED_DEER_C' => 'reddeer',
    'UAARCHIVES' => 'universityofalberta',
    'UAAUG' => 'universityofalberta',
    'UABSJ' => 'universityofalberta',
    'UABUSINESS' => 'universityofalberta',
    'UAEDUC' => 'universityofalberta',
    'UAHLTHSC' => 'universityofalberta',
    'UAHSS' => 'universityofalberta',
    'UAINTERNET' => 'universityofalberta',
    'UALAW' => 'universityofalberta',
    'UARCRF' => 'universityofalberta',
    'UASCITECH' => 'universityofalberta',
    'UASJC' => 'universityofalberta',
    'UASPCOLL' => 'universityofalberta',
    'AITF_C-FER' => 'innovates',
    'AITF_MW' => 'innovates',
    'AITF_VEG' => 'innovates',
    'VANGUARD' => 'vanguard'
  }.freeze

  def proxy(item)
    Library.find_by!(short_code: LIBRARIES[item[:location]]).proxy
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

  def library(item)
    Library.find_by!(short_code: LIBRARIES[item[:location]])
  end

  def status(item)
    if item[:status] == 'CHECKEDOUT'
      if item[:due]
        "Due: #{Date.parse(item[:due])}" if item[:due]
      else
        'Unknown/Never'
      end
    else
      Status.find_by!(short_code: [item[:status].to_s.downcase])
    end
  end

  def unavailable?(item)
    Status.find_by!(short_code: item[:status].to_s.downcase) == 'unavailable'
  end
end
