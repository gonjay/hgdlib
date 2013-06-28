class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :name
      t.string :content

      t.timestamps
    end
    create_table :books do |t|
      t.string :name

      t.timestamps
    end
  end
end
