# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
superuser = Role.create!(name: "superuser")
User.create!(first_name: "Przemyslaw",
             last_name: "Markowski",
             admin: true,
             role: superuser,
             email: "pmarkowski@alaraby.tv",
             password: "Changeme1",
             password_confirmation: "Changeme1")
