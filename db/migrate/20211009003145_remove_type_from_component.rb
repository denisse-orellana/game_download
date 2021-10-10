class RemoveTypeFromComponent < ActiveRecord::Migration[5.2]
  def change
    remove_column :components, :type, :integer
  end
end
