Sequel.migration do
  up do
    create_table :posts do
      primary_key :id
      column :title, :text
      String :content
      index :title
    end
  end

  down do
    drop_table(:posts)
  end
end
