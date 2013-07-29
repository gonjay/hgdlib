class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :ToUserName
      t.string :FromUserName
      t.string :CreateTime
      t.string :MsgType
      t.text :Content
      t.integer :FuncFlag
      t.boolean :Status

      t.timestamps
    end
  end
end
