require_relative 'basic_seeds'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
WorldDatum.delete_all
Production.delete_all
Stock.delete_all
Material.delete_all
Factory.delete_all
CelestialObject.delete_all
Character.delete_all
Facilities::System.delete_all
ActionTable.delete_all
Ship.delete_all
History.delete_all
FacilityTodo.delete_all

WorldDatum.create!(key: :step, value: 0)

@fuel = Material.create!(name: 'fuel', weigth: 1, base_price: 31)
@titan = Material.create!(name: 'titan', weigth: 100, base_price: 500)
Material.create!(name: 'weapon components', weigth: 80, base_price: 2000)
@credit = Material.create!(name: 'credit', weigth: 0, base_price: 1)

create_fight_objects
