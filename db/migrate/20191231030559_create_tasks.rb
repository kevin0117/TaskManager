class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.datetime :task_begin
      t.datetime :task_end
      t.integer :priority
      t.integer :status

      t.timestamps
    end
  end
end
