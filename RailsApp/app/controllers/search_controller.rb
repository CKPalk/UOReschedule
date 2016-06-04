class SearchController < ApplicationController

  def index
  end

  def results
    @courses = Course.where cleanQueryHash
    if not @courses
      # Redirect/render a courses not found page, possible redirect to :back
      # Looking into notice or flash events which can pass a message between views
      # Redirect to search and show that no courses were found
      redirect_to( :back, alert: "No courses found" ) and return
    end
  end

  private
    # Build query hash
    def cleanQueryHash
      permitParams.select { |_,val| not val.empty?  }
    end

    def permitParams
      params.permit(:coursecode, :coursename, :gsc, :credits, :tag, :crn, :avail_seats, :max_seats, :time, :day, :location, :notes, :instructor)
    end

end
