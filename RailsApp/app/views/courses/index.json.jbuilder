json.array!(@courses) do |course|
  json.extract! course, :id, :coursecode, :coursename, :gsc, :credits, :tag, :crn, :avail_seats, :max_seats, :time, :day, :location, :notes, :instructor
  json.url course_url(course, format: :json)
end
