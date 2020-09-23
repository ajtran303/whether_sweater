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

  let(:photo_assertions) do
    Proc.new do |photo|
      expect(photo).to be_a Hash
      expect(photo.keys).to match_array photo_keys
      expect(photo[:id]).to be_a Numeric
      expect(photo[:pageURL]).to be_a String
      expect(photo[:type]).to be_a String
      expect(photo[:tags]).to be_a String
      expect(photo[:previewURL]).to be_a String
      expect(photo[:previewWidth]).to be_a Numeric
      expect(photo[:previewHeight]).to be_a Numeric
      expect(photo[:webformatURL]).to be_a String
      expect(photo[:webformatWidth]).to be_a Numeric
      expect(photo[:webformatHeight]).to be_a Numeric
      expect(photo[:largeImageURL]).to be_a String
      expect(photo[:imageWidth]).to be_a Numeric
      expect(photo[:imageHeight]).to be_a Numeric
      expect(photo[:imageSize]).to be_a Numeric
      expect(photo[:views]).to be_a Numeric
      expect(photo[:downloads]).to be_a Numeric
      expect(photo[:favorites]).to be_a Numeric
      expect(photo[:likes]).to be_a Numeric
      expect(photo[:comments]).to be_a Numeric
      expect(photo[:user_id]).to be_a Numeric
      expect(photo[:user]).to be_a String
      expect(photo[:userImageURL]).to be_a String
    end
  end

  it 'can find photograph by location' do
    VCR.use_cassette 'location photograph' do
      params = {location: 'denver', weather: 'sunny'}
      photo = PixabayService.find_photograph params
      photo_assertions.call photo
    end
  end

  it 'finds a weather photograph when there are no location photos' do
    VCR.use_cassette 'weather photograph' do
      params = {location: 'gainesville', weather: 'sunny'}
      photo = PixabayService.find_photograph params
      photo_assertions.call photo
    end
  end
end
