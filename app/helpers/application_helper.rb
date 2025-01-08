module ApplicationHelper
  def display_age(child)
    days_old = (Time.current.to_date - child.birth_date).to_i

    distance_of_time_in_words_to_now(child.birth_date, { scope: 'baby_age' })
  end
end
