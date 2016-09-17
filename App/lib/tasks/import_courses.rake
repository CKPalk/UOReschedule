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


  department_map = {}
  File.open( "departments_201601.csv", "r" ).each do |line|
    dep_code, dep_name = line.split(",")
    department_map[ dep_code.strip ] = dep_name.strip
  end

  saved_lines = 0
  unsaved_lines = 0

  File.open( "courses_201601.csv", "r" ).each_with_index do |line, index|
    next if index == 0

    coursecode, coursename, gsc, credits, tag, crn, avail_seats, \
      max_seats, time, day, location, instructor, notes = line.strip.split(",")

    location.upcase!
    day.downcase!
    coursecode.upcase!

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
    new_course.instructor         = instructor if !(instructor.include? "STAFF" or instructor.include? "tba")
    new_course.notes              = notes

    # SETUP LOCATION
    new_location                  = Location.new
    new_location.seats_available  = avail_seats
    new_location.seats_max        = max_seats
    if location.include? "WEB"
      new_location.online         = true
    elsif location.include? "TBA" or location.empty?
      new_location.online         = false
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
        unsaved_lines += 1
        next
      end
    end

    new_course.location           = new_location
    # DONE LOCATION


    # SETUP DEPARTMENT
    new_department                = Department.new
    new_department.code           = dept_code
    new_department.full_name      = department_map[ dept_code ]

    new_course.department         = new_department
    # DONE DEPARTMENT


    # SETUP DATETIME
    new_datetime                  = Datetime.new
    if !time.include? "tba"
      start_time_temp, end_time_temp = time.split("-")
      new_datetime.start_time       = start_time_temp
      new_datetime.end_time         = end_time_temp
    end
    has_days = !(day.empty? or day.include? "tba")
    new_datetime.days_announced   = has_days
    if has_days
      new_datetime.monday           = day.include? "m"
      new_datetime.tuesday          = day.include? "t"
      new_datetime.wednesday        = day.include? "w"
      new_datetime.thursday         = day.include? "r"
      new_datetime.friday           = day.include? "f"
      new_datetime.saturday         = day.include? "s"
      new_datetime.sunday           = day.include? "u"
    end

    new_course.datetime           = new_datetime
    # DONE DATETIME


    # SETUP GROUP_SATISFYING
    new_group_satisfying          = GroupSatisfying.new
    
    new_group_satisfying.AC       = gsc.include? "AC"
    new_group_satisfying.IP       = gsc.include? "IP"
    new_group_satisfying.IC       = gsc.include? "IC"
    new_group_satisfying.group_code = gsc[/\d/].to_i if gsc =~ /\d/

    new_course.group_satisfying   = new_group_satisfying
    # DONE GROUP SATISFYING


    new_course.save
    saved_lines += 1

  end

  puts "Courses saved #{saved_lines}/#{saved_lines + unsaved_lines}"

end
