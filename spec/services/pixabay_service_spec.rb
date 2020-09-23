require 'rails_helper'

RSpec.describe PixabayService do
  let(:photo_keys) do
    [
      :id, :pageURL, :type, :tags, :previewURL, :previewWidth, :previewHeight,
      :webformatURL, :webformatWidth, :webformatHeight, :largeImageURL,
      :imageWidth, :imageHeight, :imageSize, :views, :downloads, :favorites,
      :likes, :comments, :user_id, :user, :userImageURL
    ]
  end

  it 'can find photograph by location' do
    VCR.use_cassette 'location photograph' do
      params = {location: 'denver', weather: 'sunny'}
      photo = PixabayService.find_photograph params
      expect(photo).to be_a Hash
      expect(photo.keys).to match_array photo_keys
    end
  end

  it 'finds a weather photograph when there are no location photos' do
    VCR.use_cassette 'weather photograph' do
      params = {location: 'gainesville', weather: 'sunny'}
      photo = PixabayService.find_photograph params
      expect(photo).to be_a Hash
      expect(photo.keys).to match_array photo_keys
    end
  end
end
