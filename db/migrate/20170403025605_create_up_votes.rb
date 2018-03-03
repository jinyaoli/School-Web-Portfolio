class CreateUpVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :up_votes do |t|
      t.references :comment

      t.timestamps
    end
  end
end
