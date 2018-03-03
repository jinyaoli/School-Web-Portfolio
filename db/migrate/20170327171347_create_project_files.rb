class CreateProjectFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :project_files do |t|
      t.string :name
      t.integer :size
      t.string :path
      t.string :file_type

      t.timestamps
    end
  end
end
