class AddProjectFileIdToCommit < ActiveRecord::Migration[5.0]
  def change
    add_column :commits, :project_file_id, :integer
  end
end
