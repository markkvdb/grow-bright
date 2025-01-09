require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "displays age in days for newborns" do
    travel_to Time.zone.local(2024, 1, 10) do
      child = Child.new(birth_date: Date.new(2024, 1, 5))
      assert_equal "5 days old", display_age(child)
    end
  end

  test "displays age in weeks for young infants" do
    travel_to Time.zone.local(2024, 1, 25) do
      child = Child.new(birth_date: Date.new(2024, 1, 4))
      assert_equal "21 days old", display_age(child)
    end
  end

  test "displays age in months for older infants" do
    travel_to Time.zone.local(2024, 1, 10) do
      child = Child.new(birth_date: Date.new(2023, 7, 10))
      assert_equal "6 months old", display_age(child)
    end
  end

  test "displays age in years for older children" do
    travel_to Time.zone.local(2024, 1, 10) do
      child = Child.new(birth_date: Date.new(2021, 1, 10))
      assert_equal "3 years old", display_age(child)
    end
  end

  test "handles singular units correctly" do
    travel_to Time.zone.local(2024, 1, 10) do
      assert_equal "1 day old", display_age(Child.new(birth_date: Date.new(2024, 1, 9)))
      assert_equal "7 days old", display_age(Child.new(birth_date: Date.new(2024, 1, 3)))
      assert_equal "1 month old", display_age(Child.new(birth_date: Date.new(2023, 12, 10)))
      assert_equal "12 months old", display_age(Child.new(birth_date: Date.new(2023, 1, 10)))
      assert_equal "3 years old", display_age(Child.new(birth_date: Date.new(2021, 1, 10)))
      assert_equal "2 years old", display_age(Child.new(birth_date: Date.new(2021, 1, 11)))
    end
  end

  test "handles localization" do
    travel_to Time.zone.local(2024, 1, 10) do
      I18n.with_locale(:es) do
        assert_equal "1 día de edad", display_age(Child.new(birth_date: Date.new(2024, 1, 9)))
        assert_equal "14 días de edad", display_age(Child.new(birth_date: Date.new(2023, 12, 27)))
        assert_equal "3 meses de edad", display_age(Child.new(birth_date: Date.new(2023, 10, 10)))
        assert_equal "3 años de edad", display_age(Child.new(birth_date: Date.new(2021, 1, 10)))
      end
    end
  end
end 