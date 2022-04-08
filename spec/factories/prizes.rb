FactoryBot.define do
  factory :prize do
    name { "PrizeName" }
    image {Rack::Test::UploadedFile.new("#{Rails.root}/spec/features/images/image_4.jpg")}
  end
end
