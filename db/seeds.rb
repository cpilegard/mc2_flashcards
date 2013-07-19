Deck.create({title: "mc2 members"})
deck = Deck.all.first
id = deck.id
Card.create({question: "He signs a capella", answer: "Clint", deck_id: id})
Card.create({question: "She can pole dance", answer: "Maria", deck_id: id})
Card.create({question: "Disco Lumberjack", answer: "Cole", deck_id: id})
