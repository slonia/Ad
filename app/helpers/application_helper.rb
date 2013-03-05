module ApplicationHelper
  def flash_class(level)
    case level
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :error then "alert alert-error"
      when :alert then "alert alert-alert"
    end
  end

  def username(ad)
    (ad.user && ad.user.name) || "[DELETED USER]"
  end

end
