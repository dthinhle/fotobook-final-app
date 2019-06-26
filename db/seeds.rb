# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all
Photo.delete_all
Album.delete_all
User.create(email: "admin@nus.com",password:'admin1',first_name: 'admin',last_name: 'admin')

1.upto(5){|i|
  i = Photo.create([{title: "testPhoto#{i}"}])
}

1.upto(5){|i|
  i = Album.create([{title: "testAlbum#{i}"}])
}

2.upto(5){|i|
  User.create(email: "testUser#{i}@nus.com",password:'123456',first_name: 'dummy',last_name: "user#{i}")
}

