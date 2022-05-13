class CreatePrizes < ActiveRecord::Migration[6.1]
  def change
    create_table :prizes do |t|
      t.string :name
      t.string :image
      t.belongs_to :question, foreign_key: true
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
