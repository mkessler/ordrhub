module ZapierHelper
  def order_source_id(template)
    formatted_template = template.downcase

    if formatted_template.include?('grubhub')
      Source.grubhub.id
    else
      nil
    end
  end

  def order_confirmation_link(email, template)
    formatted_template = template.downcase

    if formatted_template.include?('grubhub')
      email.search('a[href*="orderemails.grubhub.com"]').first.attributes['href'].value
    else
      nil
    end
  end
end
