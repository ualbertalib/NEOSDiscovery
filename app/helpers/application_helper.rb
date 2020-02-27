# frozen_string_literal: true

module ApplicationHelper
  def neos_libraries
    Library.all
           .reject { |library| free?(library.name) }
           .sort_by(&:name)
  end
end
