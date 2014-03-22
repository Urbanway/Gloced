module SettingsHelper
    def resource_name
      :user
    end

    def resource
      @resource = current_user || User.new
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

    def devise_error_messages!
      return "" if resource.errors.empty?

      messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
      sentence = I18n.t("errors.messages.not_saved",
                        :count => resource.errors.count,
                        :resource => resource_name)

      html = <<-HTML
			  <script type="text/javascript">
  				$.gritter.add({
  					title: "#{sentence}",
  					text: "#{messages}"
  				});
			</script>
   HTML

      html.html_safe
    end
end
