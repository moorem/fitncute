module ApplicationHelper
  def display_cost_price(product)
    money = Spree::Money.new(product.cost_price, :currency => product.cost_currency, :html => false)
    return money.to_s
  end

  def is_active?(link_path)
    if current_page?(link_path)
      'active'
    else
      'inactive'
    end
  end

  def taxonomy_taxons_tree(root_taxon, current_taxon, max_level = 1)
    max_level = 2
    return '' if max_level < 1 || root_taxon.children.empty?
    content_tag :div, class: 'sub-categories' do
      root_taxon.children.map do |taxon|
        content_tag :div, class: 'sub-category-column' do
          css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'sub-sub-category-list active' : 'sub-sub-category-list'
          link_to(taxon.name, seo_url(taxon), class: css_class) + taxons_tree(taxon, current_taxon, max_level - 1)
        end
      end.join("\n").html_safe
    end
  end
end
