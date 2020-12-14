module ApplicationHelper
    def gravatar_for(user, options={size:80})
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt:user.chefname, class:"rounded-circle")
    end

    def liked_by_me?(recipe)
        recipe.likes.exists?(chef_id: current_chef, liked: true )
    end

    def disliked_by_me?(recipe)
        recipe.likes.exists?(chef_id: current_chef, liked: false )
    end
end
