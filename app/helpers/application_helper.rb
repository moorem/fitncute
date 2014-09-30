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
end
