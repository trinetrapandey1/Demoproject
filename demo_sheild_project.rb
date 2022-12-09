$check_status_arr = []
$data_details = []
$mission_arr = ["getstone","gethulk","getgem","getloki","findspiderman"]
$name_arr=[]
require 'byebug'
class Actions
  def check_mission         #1
    if $data_details.empty?()
      puts 'No Mission has been assigned to an Avenger.'
    else
      print "Avenger name\t"
      print "misssion name\t"
      print "mission_details\t\t"
      print "status\t\n"

      $data_details.each do |value|
        value.each do |key, value|
          print "#{value}\t\t"
        end
        puts ""
      end
    end 
    Captainfury.new.display
  end

  def assign_mission         #2
    mission_arr =[]
    print "List of Available Avenger is :\n Thor \n Blackwidow \n Hawkaye \n Ironman \n"
    print "Select Available Avenger: "
    str_name = gets.chomp
    $name_arr.push(str_name)
    $name_arr.tally 
    # byebug
    if $name_arr.tally[str_name] <= 2
      puts "Enter the Mission any of the above \n Get stone \n Get hulk\n Get gem \n Get Loki \n Find Spiderman"
      @mission = gets.chomp.gsub(" ","").downcase
      puts 'Enter the Mission detail'
      @mission_details = gets.chomp.to_s
      @mission_status = 'assigned'
    else
      puts 'Sorry Avenger is Working on two Missions'
    end

    Actions.new.set_mission_details(str_name,@mission,@mission_details,@mission_status)
    Captainfury.new.display
  end

  def set_mission_details(name ,mission , mission_detail , status)
    data_details = {'avenger_name' => name , 'mission_name' => mission ,'mission_details' => mission_detail,'status' => status }
    $data_details << data_details 
    $mission_arr = $mission_arr.append(mission)
  end
  
  def check_mission_details    #3
    puts 'Enter the mission name'
    mission_str = gets.chomp.to_s
    mission_str1 = mission_str.gsub(' ','').downcase
    hash_value ={}
    $data_details.each do |hash_value|
      if hash_value["mission_name"] == mission_str1
        puts "Mission Detail : #{hash_value["mission_details"]}"
        puts "Mission status : #{hash_value["status"]}"
        puts "Avenger Assigned : #{hash_value["avenger_name"]}"
      end
    end
    if !($data_details.map {|hash_value| hash_value['mission_name']}.include?(mission_str1))
      puts "You have entered wrong mission name"
    end    
      # puts "Mission Details :#{$data_details.find {|mission| mission['mission_name']}}"
      # puts "Mission Name : #{$data_details.map {|hash_value| hash_value['mission_name']}[0]}"
      # puts "Avenger Assigned to Mission :#{$data_details.map {|hash_value| hash_value['avenger_name']}[0]}"
    Captainfury.new.display
  end
  
  def check_avenger          #4
    check_avenger_arr =[]
    puts "Enter the name of avenger"
    str1 = gets.chomp.to_s
    str_name = str1.gsub(' ','').downcase
    check_avenger_arr = $data_details.map {|hash_value| hash_value["avenger_name"]}
    $check_status_arr = ($data_details.map {|hash_value| hash_value["status"]})

    if check_avenger_arr.include?('ironman')
      puts "Person Name: iron man, \n Abilities: Highly Intelligent Suit of Armor \n Mission Assigned :  #{$check_status_arr.tally["assigned"]} \n Mission Completed : #{$check_status_arr.tally["completed"]}"
    elsif check_avenger_arr.include?('blackwidow') 
      puts "Person Name: black widow,\n Abilities: Highly trainered solider \n Mission Assigned : #{$check_status_arr.tally["assigned"]} \n Mission Completed : #{$check_status_arr.tally["completed"]}"
    elsif check_avenger_arr.include?('hawkaye')
      puts "Person Name: hawkaye,\n Abilities: Use bow and arrow \n Mission Assigned : #{$check_status_arr.tally["assigned"]} \n Mission Completed : #{$check_status_arr.tally["completed"]}" 
    elsif check_avenger_arr.include?('thor')
      puts "Person Name: Thor,\n Abilities: God of Thunder \n Mission Assigned : #{$check_status_arr.tally["assigned"]} \n Mission Completed : #{$check_status_arr.tally["completed"]}" 
    else
      puts 'You have entered wrong choice'
    end
    Captainfury.new.display
  end
   
  def update_mission          #5
    print "Enter the mission name to update\n"
    puts "Enter the mission any of the above \n Get stone \n Get hulk\n Get gem \n Get Loki \n Find Spiderman"
    update_mission = gets.chomp.to_s
    if ($data_details.map {|hash_value| hash_value['mission_name']}).include?(update_mission)
      puts "Enter the status of mission"
      mission_status = gets.chomp.to_s.gsub(" ","").downcase
      $data_details.find {|mission| mission['status'] = mission_status }
    else
      puts "Wrong format Entered"
    end
    puts $data_details
    Captainfury.new.display
  end 
end

class Captainfury 
  attr_accessor :avenger_name
  attr_accessor :mission
  attr_accessor :mission_details
  attr_accessor :mission_status
  def initialize
    @avenger_name = avenger_name
    @mission = mission
    @mission_details = mission_details
    @mission_status = mission_status
  end
  def display
    puts "Welcome Captainfury"
    print " 1.Check the missions \n 2.Assign mission to Avengers \n 3.Check mission’s details \n 4.Check Avenger’s details \n 5.Update Mission’s status \n 6.List Avengers \n 7.Assign avenger to mission. \n"
    puts 'Enter the option'
    num = gets.chomp.to_i
    case num
    when 1
      Actions.new.check_mission
    when 2
      Actions.new.assign_mission
    when 3
      Actions.new.check_mission_details
    when 4
      Actions.new.check_avenger
    when 5
      Actions.new.update_mission
    when 6
      Actions.new.check_mission
    when 7
      Actions.new.assign_mission
    else
      puts 'wrong choice entered'
    end
  end
end
puts 'Enter your name'
str=gets.chomp.to_s.gsub(' ','')
if str.downcase == 'fury'
  Captainfury.new.display
else
  puts 'invalide user'
end