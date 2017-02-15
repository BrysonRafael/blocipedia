class Wiki < ActiveRecord::Base
  belongs_to :user, dependent: :destroy

  def collaborators
    WikiCollaborator.where(wiki_id: id)
  end
end
