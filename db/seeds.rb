# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

t = User.take

1.upto(50){|i|
  i = Photo.create([{title: "testPhoto#{i}", imageable_id: "#{t[:id]}", imageable_type: "User"}])
  p "photo #{i}"
}

1.upto(50){|i|
  i = Album.create([{title: "testAlbum#{i}", user_id: "#{t[:id]}"}])
  p "album #{i}"
}


