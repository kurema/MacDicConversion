require 'zlib'

def file_write(fn,data)
	g = open(fn, "w")
	g.puts(data)
	g.close
end


open(ARGV[0],"rb") do |f|
        f.seek(0x40)
        r = f.read(4).unpack("i")[0]
        i = 0
	j = 0
	f.seek(0x60)
        while true do
                s = f.read(4).unpack("i")[0] # len of data
                t = f.read(4).unpack("i")[0] # len of compd+4?
                u = f.read(4).unpack("i")[0] # len of raw
                v = f.read(s - 8)
                w = Zlib::Inflate.inflate(v)

                file_write("out/"+j.to_s+".xml" , w)
		j += 1

                i += 12 + t
                if i >= r
                        break
                end
        end
end


