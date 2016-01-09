require 'faker'
User.create([
  { email: 'admin@admin.com', password: 'rootroot', confirmed_at: Time.now}
])

Category.create([
    { id: 0, name: 'Ruby' },
    { id: 1, name: 'Design-Patterns'},
    { id: 2, name: 'Testing'},
  ])

Author.create([
    { id: 0, name: 'Sandi Metz', desc: 'I am a programmer.'\
      'In the past 30+ years I have written innumerable'\
      'applications, many of which are still running today.' },
    { id: 1, name: 'John Ferguson Smart' },
    { id: 2, name: 'Matt Wynne' },
    { id: 3, name: 'Aslak Hellesoy' },
    { id: 4, name: 'Russ Olsen' }
  ])

Book.create([
    { id: 0, title: 'Practical Object-Oriented Design in Ruby: '\
        'An Agile Primer (Addison-Wesley Professional Ruby)',
      desc: 'The first title to focus squarely on object-oriented Ruby '\
              'application design, Practical Object-Oriented Design in '\
              'Ruby will guide you to superior outcomes, whatever your '\
              'previous Ruby experience.',
      price: 29.99, quantity: 10, category_ids: [0, 1],
      author_ids: [0] },
    { id: 1, title: 'BDD in Action: Behavior-driven development for '\
        'the whole software lifecycle',
      desc: 'BDD in Action teaches you the Behavior-Driven Development model '\
        'and shows you how to integrate it into your existing development '\
        'process. ',
      price: 47.29, quantity: 5, category_ids: [2], author_ids: [1] },
    { id: 2, title: 'The Cucumber Book: Behaviour-Driven Development for '\
        'Testers and Developers (Pragmatic Programmers)',
      desc: "The Cucumber Book dives straight into the core of the problem:"\
        " communication between people. Cucumber saves the day; it's a "\
        "testing, communication, and requirements tool - all rolled into one.",
      price: 28.50, quantity: 2, category_ids: [2], author_ids: [2, 3] },
    { id: 3, title: 'Eloquent Ruby (Addison-Wesley Professional Ruby',
      desc: 'It’s easy to write correct Ruby code, but to gain the fluency '\
        'needed to write great Ruby code, you must go beyond syntax and absorb'\
        'the “Ruby way” of thinking and problem solving.',
      price: 38.66, quantity: 4, category_ids: [0], author_ids: [4] }
  ])


# Some Completely Non-Sense info
Book.create(
  20.times.inject([]) do |array, i|
    array << {
      id: Book.count + i,           # For some reason PG fails to auto-set ;(
      title: Faker::Book.title,
      desc: Faker::Lorem.sentence(20),
      price: Faker::Number.decimal(2).to_f,
      quantity: Faker::Number.between(1, 10),
      category_ids: (0...Category.count).to_a.sample(rand(Category.count)),
      author_ids: (0...Author.count).to_a.sample(rand(Author.count))
    }
  end
)

puts "Seed completed."


#
#             SEEDED
#
#               v .   ._, |_  .,
#            `-._\/  .  \ /    |/_
#                \\  _\, y | \//
#          _\_.___\\, \\/ -.\||
#            `7-,--.`._||  / / ,
#            /'     `-. `./ / |/_.'
#                      |    |//
#                      |_    /
#                      |-   |
#                      |   =|
#                      |    |
# --------------------/ ,  . \--------._
