module ZapierHelper
  def order_source_id(template)
    formatted_template = template.downcase

    if formatted_template.include?('grubhub')
      Source.grubhub.id
    else
      nil
    end
  end
end
