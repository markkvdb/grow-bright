require "test_helper"

class ChildrenControllerTest < ActionDispatch::IntegrationTest
  setup do
    @child = children(:baby)
  end

  test "should get index" do
    get children_url
    assert_response :success
  end

  test "should get new" do
    get new_child_url
    assert_response :success
  end

  test "should create child" do
    assert_difference("Child.count") do
      post children_url, params: { 
        child: { 
          first_name: "Test Child",
          birth_date: Date.current,
          birth_weight_value: 3.5,
          birth_weight_unit: "kg",
          birth_length_value: 50,
          birth_length_unit: "cm"
        } 
      }
    end

    assert_redirected_to child_url(Child.last)
  end

  test "should show child" do
    get child_url(@child)
    assert_response :success
  end

  test "should get edit" do
    get edit_child_url(@child)
    assert_response :success
  end

  test "should update child" do
    patch child_url(@child), params: { 
      child: { 
        first_name: "Updated Name"
      } 
    }
    assert_redirected_to child_url(@child)
    @child.reload
    assert_equal "Updated Name", @child.first_name
  end

  test "should destroy child" do
    assert_difference("Child.count", -1) do
      delete child_url(@child)
    end

    assert_redirected_to children_url
  end

  test "should not create child with invalid attributes" do
    assert_no_difference("Child.count") do
      post children_url, params: { 
        child: { 
          first_name: "",
          birth_date: nil
        } 
      }
    end

    assert_response :unprocessable_entity
  end

  test "should not update child with invalid attributes" do
    patch child_url(@child), params: { 
      child: { 
        first_name: ""
      } 
    }
    assert_response :unprocessable_entity
  end
end 