class UpgradeService
  def initialize(user, catalog)
    @user = user
    @catalog = catalog
  end

  def acquire(upgrade_key)
    return :invalid_upgrade unless @catalog.key?(upgrade_key)

    if model_user?
      return :already_owned if @user.owned_upgrades.include?(upgrade_key)
      @user.own_upgrade!(upgrade_key)
      :approved
    else
      @user[:owned_upgrades] ||= []
      return :already_owned if @user[:owned_upgrades].include?(upgrade_key)
      @user[:owned_upgrades] << upgrade_key
      :approved
    end
  end

  def self.default_catalog
    {
      'perfil_plus' => {
        'label' => 'Perfil Plus',
        'description' => 'Selo no perfil e destaque Premium no cabeçalho.'
      },
      'heatmap_plus' => {
        'label' => 'Heatmap Plus',
        'description' => 'Libera recursos avançados do mapa de ruído.'
      },
      'historico_ruido_plus' => {
        'label' => 'Histórico de Ruído Plus',
        'description' => 'Libera recursos avançados para explorar seu histórico de ruído.'
      }
    }
  end

  private

  def model_user?
    @user.respond_to?(:owned_upgrades)
  end
end
