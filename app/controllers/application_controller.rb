class ApplicationController < ActionController::Base
  # Adds a few additional behaviors into the application controller
  include Blacklight::Controller
  layout 'blacklight'

  helper_method :load_lookup_tables

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def load_lookup_tables
    @statuses ||= YAML.load_file("#{Rails.root}/config/statuses.yml")
    @locations ||= YAML.load_file("#{Rails.root}/config/locations.yml")
    @libraries ||= YAML.load_file("#{Rails.root}/config/libraries.yml")
    @item_types ||= YAML.load_file("#{Rails.root}/config/item_types.yml")
  end

end
