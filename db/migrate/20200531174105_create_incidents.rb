class CreateIncidents < ActiveRecord::Migration[6.0]
  def change
    create_table :incidents do |t|
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :gender
      t.string :race
      t.string :city
      t.string :state
      t.jsonb :cause_of_death, default: []
      t.datetime :date
      
      t.timestamps
    end
  end
end
