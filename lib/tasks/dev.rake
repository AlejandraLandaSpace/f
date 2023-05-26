desc "Hydrate the database with some sample data to look at so that developing is easier"
task({ :sample_data => :environment}) do
  require 'faker'

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
    post = user.posts.create(description: Faker::Lorem.paragraph)
    post.remote_photo_url = Faker::LoremFlickr.image(size: "300x300", search_terms: ['nature'])
    post.save

    participants = User.where.not(id: user.id).sample(2)

    # Create conversation
    conversation = Conversation.create(
      sender_id: user.id,
      recipient_id: participants.first.id,
      created_at: Faker::Time.between(from: 1.year.ago, to: Time.now)
    )

    # Create messages for the conversation
    2.times do
      Message.create(
        body: Faker::Lorem.sentence,
        conversation_id: conversation.id,
        user_id: [user.id, participants.first.id].sample,
        read: Faker::Boolean.boolean,
        created_at: Faker::Time.between(from: conversation.created_at, to: Time.now)
      )
    end
  end
end
end
