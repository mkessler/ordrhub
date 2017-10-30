module OrdersHelper
  def grubhub_items(order)
    if order.details['items']
      order.details['items'].split("\n")
    else
      []
    end
  end

  def order_items_count(order)
    case order.source
      when Source.grubhub
        grubhub_items(order).count
      else
        'TBD'
    end
  end
end
