class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.references :topic, null: false, foreign_key: true
      t.string :task_name
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
