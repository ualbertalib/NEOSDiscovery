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
    end
  end

  scenario 'Sfx item has no holding table' do
    VCR.use_cassette('item_sfx_holding_table') do
      visit '/catalog/954921333007'

      page.assert_selector('#holdings table td', count: 0)
      expect(page).to have_text('No copies found. This item may be lost or missing, or the data may be temporarily unavailable. Please contact your library for assistance.')
    end
  end

  scenario 'Requestable items have proper holding tables' do
    VCR.use_cassette('item_requestable_holding_table') do
      visit '/catalog/10068'

      page.assert_selector('#holdings table td', count: 1)
      expect(first('#holdings table td')).to have_text('University of Alberta Research and Collections Resource Facility')
      expect(first('#holdings table td')).to have_text('call number: LB 01 459 (1 reel)')
      expect(first('#holdings table td')).to have_text('status: on shelf')
      expect(first('#holdings table td')).to have_css("a[href='https://www.library.ualberta.ca/locations/rcrf']")

      visit '/catalog/1000719'

      page.assert_selector('#holdings table td', count: 1)
      expect(first('#holdings table td')).to have_text('University of Alberta Research and Collections Resource Facility')
      expect(first('#holdings table td')).to have_text('call number: F 1465.3 G6 M296 1988')
      expect(first('#holdings table td')).to have_text('status: Read On Site')
      expect(first('#holdings table td')).to have_css("a[href='https://www.library.ualberta.ca/locations/rcrf']")

      visit '/catalog/1001675'

      page.assert_selector('#holdings table td', count: 2)
      expect(all('#holdings table td').last).to have_text('University of Alberta Bruce Peel Special Collections')
      expect(all('#holdings table td').last).to have_text('call number: TL 789.3 S917 1987')
      expect(all('#holdings table td').last).to have_text('status: Read On Site')
      expect(all('#holdings table td').last).to have_css("a[href='https://www.library.ualberta.ca/locations/bpsc']")
    end
  end
end
