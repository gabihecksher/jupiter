install:
	wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.0-linux-x86_64.tar.gz
	tar zxf julia-1.0.0-linux-x86_64.tar.gz
	rm julia-1.0.0-linux-x86_64.tar.gz
	# ln -s julia-1.0.0/bin/julia /usr/local/bin/julia
	# ln -s julia-1.0.0/bin/julia /usr/local/sbin/julia
	# echo $(PATH)
run:
	cd julia-1.0.0/bin
	./julia
	using Pkg
	Pkg.add("ParserCombinator")
	exit()
	cd ../../
	julia-1.0.0/bin/julia main.jl 
clean:
	rm -r julia-1.0.0
