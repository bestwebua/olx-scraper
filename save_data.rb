# Record collected data to the file.

def save_data(grab_data)
  data = File.new("#{File.expand_path(File.dirname(__FILE__))}/data.txt", 'a+')
    File.open(data, 'a+') { |data| data.puts grab_data }
end