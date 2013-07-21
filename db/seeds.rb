Deck.create({title: "mc2 members"})
deck = Deck.all.first
id = deck.id
Card.create({question: "He signs a capella", answer: "Clint", deck_id: id})
Card.create({question: "She can pole dance", answer: "Maria", deck_id: id})
Card.create({question: "Disco Lumberjack", answer: "Cole", deck_id: id})

User.create({username: 'test', password: 'test'})

Deck.create({title: "State Capitals"})
capitals_id = Deck.where(title: "State Capitals").first.id
Card.create({question: "California", answer: "Sacramento", deck_id: capitals_id})
Card.create({question: "Arizona", answer: "Phoenix", deck_id: capitals_id})
Card.create({question: "Colorado", answer: "Denver", deck_id: capitals_id})
