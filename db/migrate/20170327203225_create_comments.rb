class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :project_id
      t.string :statement

      t.timestamps
    end
  end
end
