class WikiCollaborators < ActiveRecord::Migration
  def change
    create_table :wiki_collaborators do |t|
      t.integer :wiki_id
      t.integer :user_id
    end

    add_index :wiki_collaborators, :id, unique: true
    add_index :wiki_collaborators, :wiki_id
    add_index :wiki_collaborators, :user_id
  end
end
