require 'rails_helper'

RSpec.describe MapQuestService do
  it 'can get a response' do
    a = MapQuestService.conn
  end

  it 'can locate' do
    json = MapQuestService.locate('denver,co')
    location = JSON.parse json.body, symbolize_names: true

    expect(location).to be_a Hash
    expect(location).to have_keys :info
    expect(location).to have_keys :options
    expect(location).to have_keys :results

    expect(location[:info][:statuscode]).to eq 0
  end
end
