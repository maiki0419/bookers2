class DropRelation < ActiveRecord::Migration[6.1]
  def change
    drop_table :book_category_relations
  end
end
