module ApplicationHelper
  def display_age(child)
    today = Time.current.to_date
    days_old = (today - child.birth_date).to_i

    if days_old < 30
      I18n.t("baby_age.x_days", count: days_old)
    elsif days_old < 700
      n_months = (today.year * 12 + today.month) - (child.birth_date.year * 12 + child.birth_date.month)
      I18n.t("baby_age.x_months", count: n_months)
    else
      birthday_happened = child.birth_date.month > today.month || (child.birth_date.month == today.month && child.birth_date.day <= today.day)
      n_years = today.year - child.birth_date.year - (birthday_happened ? 0 : 1)
      I18n.t("baby_age.x_years", count: n_years)
    end
  end
end
