install:
	sudo apt install julia
	# mkdir julia
	# cd julia
	# wget https://julialang-s3.julialang.org/bin/linux/x64/1.0/julia-1.0.0-linux-x86_64.tar.gz
	# echo "Extracting Julia....."
	# tar zxf julia-1.0.0-linux-x86_64.tar.gz
	# rm julia-1.0.0-linux-x86_64.tar.gz
	# echo "Adding to path....."
	# cd julia-1.0.0/bin
	# export PATH="$(pwd):$(PATH)"
	# ln -s /julia/julia-1.0.0/bin/julia /usr/local/bin 
	
clean:
	rm -r julia
	rm -r julia-1.0.0


