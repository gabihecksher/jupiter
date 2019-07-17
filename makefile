install:
	git checkout p3
	wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.0-linux-x86_64.tar.gz
	tar zxf julia-1.0.0-linux-x86_64.tar.gz
	rm julia-1.0.0-linux-x86_64.tar.gz
	echo "Installing Dependencies..."
	julia-1.0.0/bin/julia install_packages.jl 
	


clean:
	rm -r julia-1.0.0
