class CreateLeagueUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :league_users do |t|
      t.references :league,                         null: false
      t.references :user,                           null: false
      t.boolean :ready,             default: false, null: false
      t.boolean :set_up,            default: false, null: false
      t.boolean :alive,             default: true,  null: false
      t.integer :rank,              default: 0,     null: false
      t.numeric :portfolio,         default: 0,     null: false
      t.numeric :net_bonus,         default: 0,     null: false
      t.numeric :baseline,          default: 1,     null: false
      t.numeric :score,             default: 0,     null: false
      t.boolean :champ,             default: false, null: false
      t.integer :blocks,            default: 0,     null: false
      t.boolean :shield,            default: false, null: false
      t.boolean :auto_shield,       default: false, null: false

      t.timestamps
    end
    add_index :league_users,
              [:league_id, :user_id],
              unique: true
  end
end
