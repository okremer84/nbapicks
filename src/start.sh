SRCDIR="c:/Users/Omer/Documents/nbapicks/src"

docker pull fauria/lamp

docker run --name ubuntu --rm -p 80:80 -v c:/Users/Omer/Documents/nbapicks/src:/var/www/html fauria/lamp
