# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
7.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@gmail.com"
  password = "123456"
  admin = false

  (name = 'Ron22') && (email = 'ron@gmail.com') && (admin = true) if n == 0
  (name = 'Tom22') && (email = 'tom@gmail.com')                   if n == 1

  User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 admin: admin
                )
  if n == 0
    League.create!( name: 'Practice',
                    commissioner_id: 1,
                    balance_revivable: true,
                    start_date: Time.now,
                    end_date: 1000.years.from_now,
                  )

    Exchange.create!( name: 'Binance' )
    ExchangeLeague.create!( exchange_id: 1, league_id: 1)
  end

  LeagueUser.create!(user_id: n + 1, league_id: 1, set_up: true, ready: true)

  Wallet.create!( coin_type: 'BTC',
                  total_quantity: 1.00,
                  exchange_id: 1,
                  league_user_id: n + 1,
                  public_key: SecureRandom.hex(20)
                )

end

League.create!( name: 'Second',
                commissioner_id: 1,
                balance_revivable: true,
                start_date: Time.now,
                end_date: 100.years.from_now,
              )
ExchangeLeague.create!( exchange_id: 1, league_id: 2)
2.times do |n|
  LeagueInvite.create!(receiver_id: n + 2, sender_id: n + 1, league_id: 2)
end


Wallet.create!( coin_type: 'ETH',
                total_quantity: 3.554,
                exchange_id: 1,
                league_user_id: 1,
                public_key: SecureRandom.hex(20)
              )
Wallet.create!( coin_type: 'LTC',
                total_quantity: 4.8394828,
                exchange_id: 1,
                league_user_id: 1,
                public_key: SecureRandom.hex(20)
              )
Wallet.create!( coin_type: 'ADA',
                total_quantity: 5000.8459,
                exchange_id: 1,
                league_user_id: 1,
                public_key: SecureRandom.hex(20)
              )
Wallet.create!( coin_type: 'XRP',
                total_quantity: 100.989797,
                exchange_id: 1,
                league_user_id: 1,
                public_key: SecureRandom.hex(20)
              )
Wallet.create!( coin_type: 'LTC',
                total_quantity: 12.98979,
                exchange_id: 1,
                league_user_id: 4,
                public_key: SecureRandom.hex(20)
              )
Wallet.create!( coin_type: 'LTC',
                total_quantity: 5.9897,
                exchange_id: 1,
                league_user_id: 3,
                public_key: SecureRandom.hex(20)
              )
Wallet.create!( coin_type: 'LTC',
                total_quantity: 15.99797,
                exchange_id: 1,
                league_user_id: 2,
                public_key: SecureRandom.hex(20)
              )
