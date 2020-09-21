require 'rails_helper'

RSpec.describe Error do
  it 'exists with attributes' do
    error_params = {
      status:'415',
      source: '/api/v1/forecast',
      title: 'Unsupported Media Type',
      detail: 'This API conforms to the JSON API Spec. ' +
               'Requests must have the header ' +
               '`Content-Type: application/vnd.api+json`.'
    }

    error = Error.new error_params
    expect(error.status).to eq error_params[:status]
    expect(error.source).to eq({ pointer: '/api/v1/forecast' })
    expect(error.title).to eq error_params[:title]
    expect(error.detail).to eq error_params[:detail]
  end
end
