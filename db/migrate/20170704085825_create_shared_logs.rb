class CreateSharedLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :shared_logs do |t|
      t.integer :user_id
      t.string :uri
      t.text :query

      t.timestamps
    end
    add_index :shared_logs, :user_id
  end
end
