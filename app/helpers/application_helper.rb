module ApplicationHelper
	def asset_exists?(path)
		if Rails.application.assets.respond_to?(:find_asset)
			Rails.application.assets.find_asset(path).present?
		else
			File.exist?(Rails.root.join('app', 'assets', 'images', path)) ||
				File.exist?(Rails.root.join('public', 'assets', path))
		end
	end
end
