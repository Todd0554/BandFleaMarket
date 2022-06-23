# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
categories = ["guitar&bass","pedal","amplifier","others"]

if Category.count == 0
    categories.each do |c|
        Category.create(category: c)
        puts "created #{c} category"
    end
end


sorts = ["guitar","bass", "overdrive", "distortion", "fuzz", "reverb", "delay", "pitch", "octave", "tuner", "eq", "compressor", "phaser", "flanger", "acoustic amp", "high gain amp", "others"]

if Sort.count == 0
    sorts.each do |s|
        Sort.create(sort: s)
        puts "created #{s} sort"
    end
end