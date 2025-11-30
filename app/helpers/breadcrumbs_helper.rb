module BreadcrumbsHelper
  def add_breadcrumb(name, url = nil)
    @breadcrumbs ||= []
    @breadcrumbs << { name: name, url: url }
  end

  def render_breadcrumbs
    return "" if @breadcrumbs.blank?

    content_tag(:nav, aria: { label: "breadcrumb" }) do
      content_tag(:ol, class: "breadcrumb") do
        @breadcrumbs.map do |bc|
          if bc[:url].present?
            content_tag(:li, class: "breadcrumb-item") do
              link_to bc[:name], bc[:url]
            end
          else
            content_tag(:li, bc[:name], class: "breadcrumb-item active", aria: { current: "page" })
          end
        end.join.html_safe
      end
    end
  end
end
