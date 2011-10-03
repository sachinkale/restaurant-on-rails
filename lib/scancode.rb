require 'mysql'
require 'rubygems'
require 'zxing'
mysql = Mysql.init()
mysql.connect("localhost",'dbuser','', "restaurant")

img = "/tmp/img" + rand(100).to_s
#puts img
#begin
#puts "Hold card now"
#sleep 2
#system "streamer -f jpeg -o #{img} 2> /dev/null"
#puts "image saved"
#tmpcontent = ZXing.decode "#{img}"
#end while tmpcontent.nil?
#puts tmpcontent
tmpcontent="B1113"

if not tmpcontent.nil? and tmpcontent.match(/B(.*)/)
  result = mysql.query("select * from guests where gcode like '#{$&}'")
  if result.num_rows() == 0
    puts "Member not found, exiting!"
    exit
  else
    result.each do |r|
      code = rand(1000)
      finalcode =  2000 + code

      time = Time.now.getutc.strftime("%Y-%m-%d %H:%M:%S")
      str = "Insert into discounts(guest_id,created_at,dcode) values('#{r[0]}','#{time}',#{finalcode})"
      #puts str
      mysql.query(str)
      puts "discount code is #{finalcode}"
    end
  end
end



