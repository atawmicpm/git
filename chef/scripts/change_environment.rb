 query = ARGV[2]     # i type this in when using shef
 new_environment = ARGV[3]

 my_nodes = search(:node, "#{query}")

 my_nodes.each do |n|
  n.chef_environment new_environment
  n.save
 end

 exit 0