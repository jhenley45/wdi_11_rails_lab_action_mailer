class CreateGreetings < ActiveRecord::Migration
  def change
    create_table :greetings do |t|
      t.text :visitor_email
      t.text :visitor_name
      t.text :subject
      t.text :content

      t.timestamps
    end
  end
end
