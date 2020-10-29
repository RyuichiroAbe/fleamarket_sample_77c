FactoryBot.define do
  factory :image do
    # src {File.open("#{Rails.root}/public/uploads/image/src/1/E3EC61A2-DCEB-4994-A633-297C37C123A3.jpeg")}
    src { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.jpeg')) }
    item_id {2}
  end
end
