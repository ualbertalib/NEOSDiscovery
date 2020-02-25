require 'rails_helper'

RSpec.describe 'Item has proper holding table', type: :feature do
  scenario 'Symphony item has proper holding table' do
    VCR.use_cassette('item_symphony_holding_table') do
      visit '/catalog/1002481'

      page.assert_selector('#holdings table td', count: 7)
      expect(first('#holdings table td')).to have_text('Burman University')
      expect(first('#holdings table td')).to have_text('call number: PR 3095 .B4 1966')
      expect(first('#holdings table td')).to have_text('status: on shelf')
      expect(first('#holdings table td')).to have_css("a[href='https://www.burmanu.ca/library']")

      visit '/catalog/8679451'
      page.assert_selector('#holdings table td', count: 12)
      expect(first('#holdings table td')).to have_text('Burman University')
      expect(first('#holdings table td')).to have_link('Click here for Internet Access', href: 'http://ezproxy.achcu.talonline.ca/login?url=https://fod.infobase.com/PortalPlayLists.aspx?wID=152898&xtid=187246')
      expect(first('#holdings table td')).to have_text('call number: Internet Access')
      expect(first('#holdings table td')).to have_text('status: internet')
      expect(first('#holdings table td')).to have_css("a[href='https://www.burmanu.ca/library']")

      visit '/catalog/3951085'
      page.assert_selector('#holdings table td', count: 3)
      expect(first('#holdings table td')).to have_text('Grande Prairie Regional College - Internet')
      expect(first('#holdings table td')).to have_link('Click here for Internet Access', href: 'http://www.cbd.int/doc/bioday/2007/ibd-2007-booklet-01-en.pdf')
      expect(first('#holdings table td')).to have_text('call number: Internet Access')
      expect(first('#holdings table td')).to have_text('status: internet')
      expect(first('#holdings table td')).to have_css("a[href='https://www.gprc.ab.ca/library']")

      page
    end
  end

  scenario 'Sfx item has no holding table' do
    VCR.use_cassette('item_sfx_holding_table') do
      visit '/catalog/954921333007'

      page.assert_selector('#holdings table td', count: 0)
      expect(page).to have_text('No copies found. This item may be lost or missing, or the data may be temporarily unavailable. Please contact your library for assistance.')
    end
  end

end
