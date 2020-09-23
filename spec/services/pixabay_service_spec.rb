require 'rails_helper'

RSpec.describe PixabayService do
  it 'can find photograph', :vcr do
    params = {location: 'denver', weather: 'sunny'}
    photo = PixabayService.find_photograph params
    expect(photo).to be_a Hash
  end
end
# {
#   "data": {
#     "type": "image",
#     "id": null,
#     "image": {
#       "location": "denver,co",
#       "image_url": "https://pixabay.com/get/54e6d4444f50a814f1dc8460962930761c38d6ed534c704c7c2878dd954dc451_640.jpg",
#       "credit": {
#         "source": "pixabay.com",
#         "author": "quinntheislander",
#         "logo": "https://pixabay.com/static/img/logo_square.png"
#       }
#     }
#   }
# }
