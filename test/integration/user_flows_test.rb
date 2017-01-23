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

  
  test "create a new task" do
    get "/todo_lists/1/tasks/new"
    assert_response :success
     
    post "/todo_lists/1/tasks",
    params: { task: { title: "Make bed", completed: false } }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "p", "Title:\n  Make bed"
  end

  test "edit a task" do
    get "/todo_lists/1/tasks/1/edit"
    assert_response :success
     
    put "/todo_lists/1/tasks/1",
    params: { task: { title: "Make dinner"} }

    assert tasks(:one).title, "Make dinner"
  end

  test "delete an item" do
    delete "/todo_lists/1/tasks/1"
    assert_select "body", {count: 0, text: /MyString/ }
  end

  test "complete a task" do
    get "/todo_lists/1/tasks/2/edit"
    assert_response :success
     
    put "/todo_lists/1/tasks/2",
    params: { task: {completed: "1"} }
    
    assert tasks(:two).completed
  end
end
