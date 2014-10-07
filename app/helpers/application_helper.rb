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
    puts '************************************************************'
    puts max_level
    puts '************************************************************'
    return '' if max_level < 1 || root_taxon.children.empty?
    content_tag :div, class: 'list-group dropdown' do
      root_taxon.children.map do |taxon|
        css_class = (current_taxon && current_taxon.self_and_ancestors.include?(taxon)) ? 'list-group-item active' : 'list-group-item dropdown-toggle'
        link_to(taxon.name, seo_url(taxon), class: css_class) + taxons_tree(taxon, current_taxon, max_level - 1)
      end.join("\n").html_safe
    end
  end
end
