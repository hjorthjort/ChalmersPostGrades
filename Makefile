default: standard

standard: 
	./install.sh data course_results

custom:
	./install.sh ${dir} ${db}
