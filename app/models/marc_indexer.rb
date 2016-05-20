$:.unshift './config'
class MarcIndexer < Blacklight::Marc::Indexer
  # this mixin defines lambda facotry method get_format for legacy marc formats
  include Blacklight::Marc::Indexer::Formats

  def initialize
    super

    settings do
      # type may be 'binary', 'xml', or 'json'
      provide "marc_source.type", "binary"
      # set this to be non-negative if threshold should be enforced
      provide 'solr_writer.max_skipped', -1
    end

    to_field "id", trim(extract_marc("001"), :first => true)
    to_field 'marc_display', get_xml
    to_field "text", extract_all_marc_values do |r, acc|
      acc.replace [acc.join(' ')] # turn it into a single string
    end
     
    to_field "language_facet", marc_languages("008[35-37]:041a:041d:")
    #to_field "format", get_format
    to_field "isbn_t",  extract_marc('020a', :separator=>nil) do |rec, acc|
         orig = acc.dup
         acc.map!{|x| StdNum::ISBN.allNormalizedValues(x)}
         acc << orig
         acc.flatten!
         acc.uniq!
    end
    
    to_field "issn_t",  extract_marc('022a', :separator=>nil)
    
    to_field "isbn_tesim",  extract_marc('020a', :separator=>nil) do |rec, acc|
         orig = acc.dup
         acc.map!{|x| StdNum::ISBN.allNormalizedValues(x)}
         acc << orig
         acc.flatten!
         acc.uniq!
    end
    
    to_field "issn_tesim",  extract_marc('022a', :separator=>nil)
     
    to_field 'material_type_display', extract_marc('300a', :trim_punctuation => true)
     
    # Title fields
    #    primary title 
     
    to_field 'title_t', extract_marc('245a')
    to_field 'title_display', extract_marc('245a', :trim_punctuation => true, :alternate_script=>false)
    to_field 'title_vern_display', extract_marc('245a', :trim_punctuation => true, :alternate_script=>:only)
     
    #    subtitle
     
    to_field 'subtitle_t', extract_marc('245b')
    to_field 'subtitle_display', extract_marc('245b', :trim_punctuation => true, :alternate_script=>false)
    to_field 'subtitle_vern_display', extract_marc('245b', :trim_punctuation => true, :alternate_script=>:only)
     
    #    additional title fields
    to_field 'title_addl_t', 
      extract_marc(%W{
        245abnps
        130#{ATOZ}
        240abcdefgklmnopqrs
        210ab
        222ab
        242abnp
        243abcdefgklmnopqrs
        246abcdefgnp
        247abcdefgnp
      }.join(':'))
     
    to_field 'title_added_entry_t', extract_marc(%W{
      700gklmnoprst
      710fgklmnopqrst
      711fgklnpst
      730abcdefgklmnopqrst
      740anp
    }.join(':'))
     
    to_field 'title_series_t', extract_marc("440anpv:490av")
     
    to_field 'title_sort', marc_sortable_title  
     
    # Author fields
     
    to_field 'author_t', extract_marc("100abcegqu:110abcdegnu:111acdegjnqu")
    to_field 'author_addl_t', extract_marc("700abcegqu:710abcdegnu:711acdegjnqu")
    to_field 'author_display', extract_marc("100abcdq:110#{ATOZ}:111#{ATOZ}", :alternate_script=>false)
    to_field 'author_vern_display', extract_marc("100abcdq:110#{ATOZ}:111#{ATOZ}", :alternate_script=>:only)
     
    # JSTOR isn't an author. Try to not use it as one
    to_field 'author_sort', marc_sortable_author
     
    # Subject fields
    to_field 'subject_t', extract_marc(%W(
      600#{ATOZ}
      610#{ATOZ}
      611#{ATOZ}
      630#{ATOZ}
      650#{ATOZ}
      651#{ATOZ}
      653a
      654#{ATOZ}
      655#{ATOZ}
    ).join(':'))
    to_field 'subject_addl_t', extract_marc("600vwxyz:610vwxyz:611vwxyz:630vwxyz:650vwxyz:651vwxyz:654vwxyz:655vwxyz")
    to_field 'subject_topic_facet', extract_marc("600abcdq:610ab:611ab:630aa:650aa:653aa:654ab:655ab", :trim_punctuation => true)
    to_field 'subject_era_facet',  extract_marc("650y:651y:654y:655y", :trim_punctuation => true)
    to_field 'subject_geo_facet',  extract_marc("651a:650z",:trim_punctuation => true )
     
    # Publication fields
    to_field 'published_display', extract_marc('260a', :trim_punctuation => true, :alternate_script=>false)
    to_field 'published_vern_display', extract_marc('260a', :trim_punctuation => true, :alternate_script=>:only)
    to_field 'pub_date', marc_publication_date
     
    # Call Number fields
    to_field 'lc_callnum_display', extract_marc('050ab', :first => true)
    to_field 'lc_1letter_facet', extract_marc('050ab', :first=>true, :translation_map=>'callnumber_map') do |rec, acc|
      # Just get the first letter to send to the translation map
      acc.map!{|x| x[0]}
    end

    alpha_pat = /\A([A-Z]{1,3})\d.*\Z/
    to_field 'lc_alpha_facet', extract_marc('050a', :first=>true) do |rec, acc|
      acc.map! do |x|
        (m = alpha_pat.match(x)) ? m[1] : nil
      end
      acc.compact! # eliminate nils
    end

    to_field 'lc_b4cutter_facet', extract_marc('050a', :first=>true)

    # URL Fields
     
    notfulltext = /abstract|description|sample text|table of contents|/i
     
    to_field('url_fulltext_display') do |rec, acc|
      rec.fields('856').each do |f|
        case f.indicator2
        when '0'
          f.find_all{|sf| sf.code == 'u'}.each do |url|
            acc << url.value
          end
        when '2'
          # do nothing
        else
          z3 = [f['z'], f['3']].join(' ')
          unless notfulltext.match(z3)
            acc << f['u'] unless f['u'].nil?
          end
        end
      end
    end

    # Very similar to url_fulltext_display. Should DRY up.
    to_field 'url_suppl_display' do |rec, acc|
      rec.fields('856').each do |f|
        case f.indicator2
        when '2'
          f.find_all{|sf| sf.code == 'u'}.each do |url|
            acc << url.value
          end
        when '0'
          # do nothing
        else
          z3 = [f['z'], f['3']].join(' ')
          if notfulltext.match(z3)
            acc << f['u'] unless f['u'].nil?
          end
        end
      end
    end

    to_field "edition_tesim", extract_marc('250a', :first=>true)
    to_field "alternate_display_tesim", extract_marc('880a', :first=>true)
    to_field "holdings_tesim", extract_marc("949#{ATOZ}")
    to_field "owning_library_tesim", extract_marc('990m')
    to_field "general_note_tesim", extract_marc('500a')
    to_field "target_audience_note_tesim", extract_marc('521a')
    to_field "awards_note_tesim", extract_marc('586a')
    to_field "local_note_tesim", extract_marc('590a')
    to_field "contents_tesim", extract_marc('505a')
    to_field "bibliography_note_tesim", extract_marc('504a')
    to_field "summary_tesim", extract_marc("520a")
    to_field "earlier_title_tesim", extract_marc("780t")
    to_field "later_title_tesim", extract_marc("785t")
    to_field "section_number_tesim", extract_marc("245n")
    to_field "section_name_tesim", extract_marc("245p")
    to_field "summary_holdings_tesim", extract_marc("8563")
    to_field "uniform_title_tesim", extract_marc("240a")
    to_field "performers_tesim", extract_marc("511a")
    to_field "publisher_number_tesim", extract_marc("028abq")
    to_field "held_by_tesim", extract_marc("596a")
    to_field "arrangement_tesim", extract_marc("351a")
    to_field "time_of_event_tesim", extract_marc("518a")
    to_field "issuing_body_tesim", extract_marc("550a")
    to_field "supplementary_note_tesim", extract_marc("525a")
    to_field "title_history_tesim", extract_marc("580a")
    to_field "numbering_tesim", extract_marc("515a")
    to_field "use_repro_tesim", extract_marc("540a")
    to_field "language_note_tesim", extract_marc("546a")
  end
end
