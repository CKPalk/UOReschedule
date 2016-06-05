desc "Import courses"
task import: :environment do

  File.open( "courses_201601.csv", "r" ).each do |line|
    coursecode, coursename, gsc, credits, tag, crn, avail_seats, avail_seats, max_seats, time, day, location, instructor, notes = line.strip.split(",")
    dept_code, course_num = coursecode.split(" ")

    course                    = Course.new
    course.crn                = crn
    course.course_name        = coursename
    course.course_num         = course_num

    location                  = Location.new
    location.online           = 
    location.seats_available  = 
    location.seats_max        = 

    course.location           = location
                                


    puts coursename
  end

end
