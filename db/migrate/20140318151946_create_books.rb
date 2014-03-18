class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.text :title
      t.references :user

      t.timestamps
    end
  end
end
