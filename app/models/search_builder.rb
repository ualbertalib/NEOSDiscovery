# frozen_string_literal: true
class SearchBuilder < Blacklight::SearchBuilder
  include Blacklight::Solr::SearchBuilderBehavior
  include BlacklightAdvancedSearch::AdvancedSearchBuilder
  self.default_processor_chain += [:add_advanced_parse_q_to_solr, :add_advanced_search_to_solr]

  self.default_processor_chain += [:show_only_symphony_records]

  def show_only_symphony_records(solr_parameters)
    solr_parameters[:fq] ||= []
    solr_parameters[:fq] << 'source:Symphony'
  end
end
