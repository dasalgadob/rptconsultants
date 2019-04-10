##Update of degrees table to just modify this tables and avoid running all the seeds of the project
##This script is thought to be run on production
##Run it using rails db:seed:seed2
Degree.update_all("hay =  number+8, ggs = number + 3")
