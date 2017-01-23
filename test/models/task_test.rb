require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test "the truth" do
    assert true
  end

    class TodoList < ApplicationRecord
        validates :title, presence: true
    end

    test "should not save list without title" do
        todo_list = TodoList.new
        assert_not todo_list.save
    end


    class Task < ApplicationRecord
        validates :title, presence: true
    end

    test "should not save task without title" do
        task = Task.new
        assert_not task.save
    end


end