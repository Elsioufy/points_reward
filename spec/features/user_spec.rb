require "rails_helper"

# This feature spec is used to test our invitation spec

feature User, :type => :feature do
  scenario 'goes to importing a new user sheet' do
    visit new_import_users_path
    expect(current_path).to eq new_import_users_path
  end

  scenario 'uploads input as txt and computes score correctly' do
    visit new_import_users_path
    path = 'spec/fixtures/sample_input_data.txt'
    page.attach_file "file", path
    click_on 'upload'
    result = JSON.parse(page.html)
    expect(result['A'].to_f).to eq(1.75)
    expect(result['B'].to_f).to eq(1.5)
    expect(result['C'].to_f).to eq(1.0)
    expect(result['D'].to_f).to eq(0)
  end

  scenario 'uploads changed time input as txt and computes score correctly' do
    visit new_import_users_path
    path = 'spec/fixtures/sample_input_data_time_changed.txt'
    page.attach_file "file", path
    click_on 'upload'
    result = JSON.parse(page.html)
    expect(result['A'].to_f).to eq(2.0)
    expect(result['B'].to_f).to eq(2.0)
    expect(result['C'].to_f).to eq(0)
    expect(result['D'].to_f).to eq(0)
  end

  scenario 'uploads changed ordered input as txt and computes score correctly' do
    visit new_import_users_path
    path = 'spec/fixtures/sample_input_order_changed.txt'
    page.attach_file "file", path
    click_on 'upload'
    result = JSON.parse(page.html)
    expect(result['A'].to_f).to eq(0)
    expect(result['B'].to_f).to eq(0)
    expect(result['C'].to_f).to eq(0)
    expect(result['D'].to_f).to eq(0)
  end

  scenario 'uploads wrong input' do
    visit new_import_users_path
    path = 'spec/fixtures/buggy_input_data.txt'
    page.attach_file "file", path
    click_on 'upload'
    result = JSON.parse(page.html)
    expect(result.has_key?('errors')).to be_truthy
    expect(result['errors'][0]).to eq "Error parsing file, make sure info is correct"
  end
end