class AvatarService
  def initialize(user, catalog)
    @user = user
    @catalog = catalog
  end

  def acquire(avatar_key)
    return :invalid_avatar unless @catalog.key?(avatar_key)

    if model_user?
      return :already_owned if @user.owned_avatars.include?(avatar_key)
      @user.own_avatar!(avatar_key)
      @user.select_pending_avatar!(avatar_key)
      :approved
    else
      return :already_owned if @user[:owned_avatars].include?(avatar_key)
      @user[:owned_avatars] << avatar_key
      @user[:pending_avatar] = avatar_key
      :approved
    end
  end

  def select(avatar_key)
    if model_user?
      if @user.owned_avatars.include?(avatar_key)
        @user.select_pending_avatar!(avatar_key)
        :ok
      else
        :not_owned
      end
    else
      if @user[:owned_avatars].include?(avatar_key)
        @user[:pending_avatar] = avatar_key
        :ok
      else
        :not_owned
      end
    end
  end
  def confirm_profile_update
    if model_user?
      return :no_pending unless @user.pending_avatar
      @user.apply_pending_avatar!
      :applied
    else
      return :no_pending unless @user[:pending_avatar]
      @user[:current_avatar] = @user[:pending_avatar]
      @user.delete(:pending_avatar)
      :applied
    end
  end

  def self.default_catalog
    {
      'gato' => { 'label' => 'Gato' },
      'raposa' => { 'label' => 'Raposa' },
      'coelho' => { 'label' => 'Coelho' }
    }
  end

  private

  def model_user?
    @user.respond_to?(:owned_avatars)
  end
end
