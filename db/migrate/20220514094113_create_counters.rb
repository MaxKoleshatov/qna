class CreateCounters < ActiveRecord::Migration[6.1]
  def change
    create_table :counters do |t|
      t.integer :value, default: 0
      t.references :counterable, polymorphic: true
      t.belongs_to :user, foreign_key: true
      t.string :vote_user, array: true, default: []
      

      t.timestamps
    end
  end
end
