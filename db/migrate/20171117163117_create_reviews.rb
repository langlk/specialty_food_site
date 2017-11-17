class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.column :author, :string
      t.column :content_body, :string
      t.column :rating, :integer

      t.timestamps
    end
  end
end
