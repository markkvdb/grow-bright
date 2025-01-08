module MeasuredHelpers
  def assert_measured_equals(expected, actual, message = nil)
    assert_equal expected.value, actual.value, "#{message} - values do not match"
    assert_equal expected.unit, actual.unit, "#{message} - units do not match"
  end
end 