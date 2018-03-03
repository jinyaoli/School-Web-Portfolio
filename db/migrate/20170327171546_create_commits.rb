class CreateCommits < ActiveRecord::Migration[5.0]
  def change
    create_table :commits do |t|
      t.string :author
      t.string :date
      t.string :revision

      t.timestamps
    end
  end
end
