class AddSourceNameToIncidents < ActiveRecord::Migration[6.0]
  def change
    add_column :incidents, :source_name, :string
  end
end
