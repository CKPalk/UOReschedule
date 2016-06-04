class CoursesController < ApplicationController

  def index
    @courses = Course.all
    if @courses.empty?
      render plain: "No classes found, sorry."
    else
      puts "I found some courses"
    end
  end

end
