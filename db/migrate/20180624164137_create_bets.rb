class CreateBets < ActiveRecord::Migration[5.1]
  def change
    create_table :bets do |t|
      t.references :leverage,                    null: false
      t.references :league_user,                 null: false
      t.decimal    :baseline,                    null: false
      t.decimal    :liquidation,                 null: false
      t.decimal    :post_value,                  null: false
      t.integer    :round,                       null: false
      t.boolean    :active,      default: true,  null: false
      t.timestamps
    end
  end
end
