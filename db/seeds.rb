
# Create sample users
user1 = User.create!(first_name: 'John', last_name: 'Doe', email: 'john.doe@example.com', password: 'password123', admin: true)
user2 = User.create!(first_name: 'Jane', last_name: 'Smith', email: 'jane.smith@example.com', password: 'password123', admin: false)

# Create sample teams
team1 = Team.create!(name: 'Development Team', description: 'Team working on development')
team2 = Team.create!(name: 'Marketing Team', description: 'Team working on marketing')

# Create sample stocks
stock1 = Stock.create!(symbol: 'AAPL', company_name: 'Apple Inc.')
stock2 = Stock.create!(symbol: 'GOOGL', company_name: 'Alphabet Inc.')

# Create wallets for each entity
[User, Team, Stock].each do |model|
  model.find_each do |entity|
    entity.create_wallet(balance: 1000.00)
  end
end
