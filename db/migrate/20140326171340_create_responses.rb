class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.column :name, :string
      t.column :questions_id, :integer

      t.timestamps
    end
  end
end
