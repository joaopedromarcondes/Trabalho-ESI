class AvatarService
  def initialize(user, catalog)
    @user = user
    @catalog = catalog
  end

  def acquire(avatar_key)
    return :invalid_avatar unless @catalog.key?(avatar_key)
    return :already_owned if @user[:owned_avatars].include?(avatar_key)

    @user[:owned_avatars] << avatar_key
    @user[:pending_avatar] = avatar_key
    :approved
  end

  def select(avatar_key)
    if @user[:owned_avatars].include?(avatar_key)
      @user[:pending_avatar] = avatar_key
      :ok
    else
      :not_owned
    end
  end
  def confirm_profile_update
    return :no_pending unless @user[:pending_avatar]

    @user[:current_avatar] = @user[:pending_avatar]
    @user.delete(:pending_avatar)
    :applied
  end
end
