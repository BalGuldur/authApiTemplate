# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
if Rails.env != 'production'
  Company.all.find_each &:really_destroy!
  User.all.find_each &:really_destroy!
end
companies = Company.create([{ title: 'Test comp 1' }, { title: 'Test comp 2' }])

User.create(name: 'Aleksandr',
            surname: 'Krulov',
            admin: true,
            email: 'a.krulov@gmail.com',
            company: companies.first,
            password: 'qwerty123')
User.create(name: 'Aleksandr2',
            surname: 'Krulov',
            email: 'a.krulov2@gmail.com',
            company: companies.second,
            password: 'qwerty123')