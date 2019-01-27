module ApplicationHelper
  # This is used to render errors in the view in case of validation
  def form_errors(resource)
    return if resource.errors.empty?

    return content_tag(:div, class: "alert alert-danger") do
      content = ""
      content << content_tag(:div, class: "header") do
        "There were some errors saving this #{resource.class.name.titleize.downcase}"
      end

      content << content_tag(:ul) do
        messages = ""
        resource.errors.full_messages.each do |msg|
          messages << content_tag(:li) do
            msg
          end
        end

        messages.html_safe
      end

      content.html_safe
    end
  end
end
