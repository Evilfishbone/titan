def car_list
	car_file = File.open("car_list", "r")
	car_data_raw = car_file.read.split("\n")

	cars = []
	car_data_raw.each do |car_name|
		ignore_list = ["", " ", "Car", "Gr.", "Picture"]
		next if ignore_list.include?(car_name)
		next if !car_name.include?(" ")
		sanitized_name = car_name.split("\t").first
		cars << sanitized_name
	end
	cars
end

def track_list
	track_file = File.open("track_list", "r")
	track_data_raw = track_file.read.split("\n")

	tracks = []

	track_name = ""
	track_data_raw.each do |track|
		unsanitized_track_name = track.split("\t")
		track_name = unsanitized_track_name.first.sub('Flag of ', '') if unsanitized_track_name.first =~ /Flag of/
		if unsanitized_track_name.first !~ /Flag of/
			tracks << "#{track_name} #{unsanitized_track_name.first}"
			tracks << "#{track_name} #{unsanitized_track_name.first} - reverse" if unsanitized_track_name[3] == "Yes"
			next
		end
		tracks << "#{track_name} #{unsanitized_track_name[1]}"
		tracks << "#{track_name} #{unsanitized_track_name[1]} - reverse" if unsanitized_track_name[4] == "Yes"
	end
	tracks
end

puts "Type 'track' for track list, 'car' for car list"

loop do
	print "> "
	command = gets.chomp
	command_list = ["track", "car"]
	next if !command_list.include?(command)	
	puts track_list.sample if command == "track"
	puts car_list.sample if command == "car"
end
