puts "Заполняю базу данных товарами..."

Item.create!([
  { name: "Ноутбук Apple MacBook Air", description: "Процессор M2, 8GB RAM, 256GB SSD", price: 1200.00 },
  { name: "Смартфон Samsung Galaxy S23", description: "Экран 120Гц, камера 50Мп, 128GB", price: 800.00 },
  { name: "Наушники Sony WH-1000XM5", description: "Беспроводные наушники с активным шумоподавлением", price: 350.00 },
  { name: "Механическая клавиатура Keychron K2", description: "Беспроводная клавиатура на свитчах Gateron Brown", price: 100.00 }
])

puts "Готово! Создано #{Item.count} товаров."
