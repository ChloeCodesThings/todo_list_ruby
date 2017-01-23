require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "show all tasks" do
    get "/todo_lists/1"
    assert_select "body", /MyString/
  end

  test "show only uncompleted tasks" do
    get "/todo_lists/1?filter_completed=true"
    assert_select "body", /MyString/
  end

  test "show a single item" do
    get "/todo_lists/1/tasks/1"
    assert_select "body", /Title/
  end

  test "add a new item" do
    get "/todo_lists/1/tasks/new"
    assert_select "body", /New Task/
  end

  test "update an item" do
    get "/todo_lists/1/tasks/1/edit"
    assert_select "body", /Editing Task/
  end

  test "delete an item" do
    delete "/todo_lists/1/tasks/1"
    assert_select "body", {count: 0, text: /MyString/ }
  end

end
