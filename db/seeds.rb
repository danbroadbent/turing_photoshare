class Seed
  def self.start
    seed = Seed.new
    seed.generate_admin
    seed.generate_users
    seed.generate_albums
  end

  def generate_admin
    puts "Generating administrator."
    chad = Fabricate(:user, role: 1, password: "password")
    Fabricate(:user_profile, user: chad, username: "clancey007@example.com")
  end

  def generate_users
    puts "Populating users table."
    Fabricate.times(999, :user)
    puts "#{User.count} users have been added to the database."
  end

  def generate_albums
    puts "Populating albums table"
    User.all.each do |user|
      user.albums << Fabricate.times(5, :album)
    end
    puts "#{Album.count} albums have been added to the database."
  end
end

Seed.start
