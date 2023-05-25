desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do
  10.times do
    User.create(
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      company_name: Faker::Company.name
    )
  end

  User.all.each do |user|
    3.times do
      user.posts.create(description: Faker::Lorem.paragraph) do |p|
        p.remote_photo_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ['nature'])
      end
    end
  end

end
