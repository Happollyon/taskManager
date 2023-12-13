class CreateTopics < ActiveRecord::Migration[7.1]
  def change
    create_table :topics do |t|
      t.references :user, null: false, foreign_key: true
      t.string :topic_name

      t.timestamps
    end
  end
end

