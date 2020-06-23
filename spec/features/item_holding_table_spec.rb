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

      # this one isn't in the test set
      visit '/catalog/8679451'
      page.assert_selector('#holdings table td', count: 12)
      expect(first('#holdings table td')).to have_text('Burman University')
      expect(first('#holdings table td')).to have_link('Click here for Internet Access', href: 'http://ezproxy.achcu.talonline.ca/login?url=https://fod.infobase.com/PortalPlayLists.aspx?wID=152898&xtid=187246')
      expect(first('#holdings table td')).to have_text('call number: Internet Access')
      expect(first('#holdings table td')).to have_text('status: internet')
      expect(first('#holdings table td')).to have_css("a[href='https://www.burmanu.ca/library']")

      visit '/catalog/1007482'
      page.assert_selector('#holdings table td', count: 2)
      expect(first('#holdings table td')).to have_text('University of Alberta Internet')
      expect(first('#holdings table td')).to have_link('Click here for Internet Access', href: 'http://www.peabody.yale.edu/scipubs/bulletins_postillas/ypmB04_1935.pdf')
      expect(first('#holdings table td')).to have_text('call number: Internet Access')
      expect(first('#holdings table td')).to have_text('status: internet')
      expect(first('#holdings table td')).to have_css("a[href='https://www.library.ualberta.ca/services/off-campus-access']")

      visit '/catalog/2714245'
      page.assert_selector('#holdings table td', count: 1)
      expect(first('#holdings table td')).to have_text('Alberta Government Library - Internet')
      expect(first('#holdings table td')).to have_link('Click here for Internet Access', href: 'https://ezproxy.aee.talonline.ca/login?url=http://purl.access.gpo.gov/GPO/LPS31752')
      expect(first('#holdings table td')).to have_text('call number: Internet Access')
      expect(first('#holdings table td')).to have_text('status: internet')
      expect(first('#holdings table td')).to have_css("a[href='https://www.servicealberta.ca/alberta-government-library.cfm']")

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
