# frozen_string_literal: true
class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior

  self.default_processor_chain += [:show_only_symphony_records]

  def show_only_symphony_records(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << 'source:Symphony'
  end
end
