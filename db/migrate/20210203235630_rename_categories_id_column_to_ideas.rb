class RenameCategoriesIdColumnToIdeas < ActiveRecord::Migration[6.0]
  def change
    rename_column :ideas, :categories_id, :category_id
  end
end
