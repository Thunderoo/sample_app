namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_user
    make_forums
  end
end

def make_user
  User.create!( username: "CForbes",
                email: "chris.forbes.outgames@gmail.com",
                password: "foobar",
                password_confirmation: "foobar",
                admin: true)
end

def make_users
  User.create!( username: "Example User",
               email: "example@railstutorial.org",
               password: "foobar",
               password_confirmation: "foobar",
               admin: true)
  99.times do |n|
    name = Faker::Name.name
    email = "Example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(username: name,
                 email: email,
                 password:password,
                 password_confirmation: password)
  end
end

def make_microposts
  users = User.all(limit: 6)
  50.times do
    content = Faker::Lorem.sentence(5)
    users.each { |user| user.microposts.create!(content: content) }
  end
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users [3..50]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

def make_forums
  Forum.create!( name: "Main discussion",
                subname: "All discussion about development of the game",
                creator: "Chris Forbes")
end

def make_posts
  forum = Forum.all.first
  user = User.all.first
  forum.posts.create!(title: "first post", content: "Lorem Ipsum", user_id: user.id)
end

def make_replies
  post = Post.all.first
  user = User.all.second
  post.replies.create!(content: "OP is a fag", user_id: user.id)
end