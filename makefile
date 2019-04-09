install:
	apt install julia

clean:
	apt-get --purge remove julia
	apt-get clean	

