#encoding: utf-8

20.times do
  Notification.create({
    active: [true, false].sample,
    title: 'Criança precisa da sua ajuda',
    company: Company.all.to_a.shuffle.first,
    blood: Blood.all.to_a.shuffle.first,
    blood_type: Blood.all.to_a.shuffle.first.name,
    situation: ['Urgente', 'Moderado'].sample,
    quantity: rand(99),
    person_notifications: [PersonNotification.create(person: Person.all.to_a.sample)]
  })
end