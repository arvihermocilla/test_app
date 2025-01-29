class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.bigint :guest_id
      t.datetime :start_date
      t.datetime :end_date
      t.integer :nights
      t.integer :number_of_guests
      t.integer :number_of_adults
      t.integer :number_of_children
      t.integer :number_of_infants
      t.string :status
      t.string :currency
      t.decimal :payout_price, precision: 10, scale: 2
      t.decimal :security_price, precision: 10, scale: 2
      t.decimal :total_price, precision: 10, scale: 2
      t.timestamps
    end

    add_index :reservations, :guest_id
    # add_reference :reservations, :guest, null: false, foreign_key: true
  end
end
