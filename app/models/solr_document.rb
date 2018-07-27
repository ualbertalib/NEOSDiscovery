# frozen_string_literal: true
class SolrDocument
  include Blacklight::Solr::Document    
      # The following shows how to setup this blacklight document to display marc documents
  extension_parameters[:marc_source_field] = :marc_display
  extension_parameters[:marc_format_type] = :marcxml
  use_extension( Blacklight::Solr::Document::Marc) do |document|
    document.key?( :marc_display  )
  end
  
  field_semantics.merge!(    
                         :title => "title_display",
                         :author => "author_display",
                         :language => "language_facet",
                         :format => "format"
                         )



  # self.unique_key = 'id'

  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension(Blacklight::Document::Email)

  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension(Blacklight::Document::Sms)

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Document::SemanticFields#field_semantics
  # and Blacklight::Document::SemanticFields#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension(Blacklight::Document::DublinCore)

 include Blacklight::Solr::Document::RisFields
  use_extension(Blacklight::Solr::Document::RisExport)

  ris_field_mappings.merge!(
    # Procs are evaluated in context of SolrDocument instance
    :TY => Proc.new {
      format = fetch('format', [])
      if format.member?('Book')
        'BOOK'
      elsif format.member?('Journal')
        'JOUR'
      elsif format.member?('Video or Projection')
        'VIDEO'
      else
        'GEN'
      end
    },
    # use solr field named 'title'
    :TI => "#{title_display}: #{subtitle_display}",
    :AU => 'author_display',
    :AU => 'author_addl_t',
    :PY => 'pub_date',
    # this assumes you're using blacklight-marc
    :CY => Proc.new { marclibrary.get_ris_cy_field(to_marc) },
    :PB => 'publisher_tesim', #Proc.new { marclibrary.get_ris_pb_field(to_marc) },
    :ET => 'edition',
    :SN => 'isbn_tesim', #Proc.new { marclibrary.get_ris_sn_field(to_marc) },
    :SN => 'issn_tesim'
  )
end
