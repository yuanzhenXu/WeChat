class CreateFaqs < ActiveRecord::Migration[5.1]
  def change
    create_table :faqs do |t|
      t.string :title
      t.integer :position
      t.text :content
      t.boolean :is_online, default: false

      t.timestamps
    end
    add_index :faqs, :position
    add_index :faqs, :is_online
  end
end
