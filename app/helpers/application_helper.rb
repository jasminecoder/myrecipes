module ApplicationHelper
    def gravatar_for(user, options={size:80})
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt:user.chefname, class:"rounded-circle")
    end

    def liked_by_me?(recipe)
        recipe.likes.any? {|like| like.chef == current_chef }
    end
end
