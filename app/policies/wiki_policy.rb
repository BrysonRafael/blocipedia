class WikiPolicy < ApplicationPolicy
  attr_reader :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user == 'admin'
        wikis = scope.all #admin should be able to view all wikis
      elsif user.is_premium == true
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private || wiki.user_id == user.id || wiki.collaborators.include?(user.id)
            wikis << wiki
          end
        end
      else #users with basic plans
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if !wiki.private || wiki.collaborators.include?(user.id)
            wikis << wiki #basic users can only see public wikis and private wikis the collaborate on
          end
        end
      end
      wikis #return the wikis array that was built
    end
  end
end
