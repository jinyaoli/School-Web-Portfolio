class AddProjectIdToProjectFile < ActiveRecord::Migration[5.0]
  def change
    add_column :project_files, :project_id, :integer
  end
end
