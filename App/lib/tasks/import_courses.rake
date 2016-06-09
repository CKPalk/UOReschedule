desc "Importing courses"


def parseTag( tag )
  matches = /[A-Za-z]/.match( tag )
  return matches.nil? ? nil : matches[0]
end

def parseCredits( credits )
  matches = /[1-9+]/.match( credits )
  case matches.length
  when 1
    return [ matches[0] ]
  when 2
    return [ matches[0], matches[1] ]
  else
    puts "Cannot handle credits: \"#{credits}\""
  end
end


task import: :environment do

  File.open( "courses_201601.csv", "r" ).each_with_index do |line, index|
    next if index == 0

    #print "Adding \"#{line}\""

    coursecode, coursename, gsc, credits, tag, crn, avail_seats, \
      max_seats, time, day, location, instructor, notes = line.strip.split(",")
    dept_code, course_num = coursecode.split(" ")


    new_course                    = Course.new
    next if crn.nil?
    new_course.crn                = crn
    new_course.course_name        = coursename
    new_course.course_num         = course_num
    parsedTag = parseTag( tag )
    new_course.type_tag           = parsedTag if not parsedTag.nil?
    parsedCredits = parseCredits( credits )
    case parsedCredits.length
    when 1
      new_course.max_credits      = parsedCredits[0]
    when 2
      new_course.min_credits      = parsedCredits[0]
      new_course.max_credits      = parsedCredits[1]
    end
    new_course.instructor         = instructor
    new_course.notes              = notes

    # SETUP LOCATION
    new_location                  = Location.new
    new_location.seats_available  = avail_seats
    new_location.seats_max        = max_seats
    if location == "WEB"
      new_location.online         = true
    else
      new_location.online         = false
      loc_split = location.split(" ")
      case loc_split.length
      when 1
        new_location.room         = loc_split[0]
      when 2
        new_location.building     = loc_split[0]
        new_location.room         = loc_split[1]
      else
        puts "I don't know how to handle location: #{location}"
        next
      end
    end

    print "Location"
    new_course.location           = new_location
    # DONE LOCATION


    # SETUP DEPARTMENT
    new_department                = Department.new
    new_department.code           = "code"
    new_department.full_name      = "full name"

    print " | Department"
    new_course.department         = new_department
    # DONE DEPARTMENT


    # SETUP DATETIME
    new_datetime                  = Datetime.new
    new_datetime.start_time       = 000000
    new_datetime.end_time         = 000000
    new_datetime.monday           = true
    new_datetime.tuesday          = false
    new_datetime.wednesday        = true
    new_datetime.thursday         = false
    new_datetime.friday           = true
    new_datetime.saturday         = false
    new_datetime.sunday           = false

    print " | Datetime"
    new_course.datetime           = new_datetime
    # DONE DATETIME


    # SETUP GROUP_SATISFYING
    new_group_satisfying          = GroupSatisfying.new
    new_group_satisfying.AL       = false
    new_group_satisfying.SCC      = false
    new_group_satisfying.SC       = false
    new_group_satisfying.AC       = false
    new_group_satisfying.IP       = false
    new_group_satisfying.IC       = false

    print " | Group Satisfying"
    new_course.group_satisfying   = new_group_satisfying
    # DONE GROUP SATISFYING


    new_course.save
    puts " >> Course #{index} saved"

  end

end
