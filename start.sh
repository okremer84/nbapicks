SRCDIR=`cat srcdir.txt`

docker stop ubuntu
docker pull fauria/lamp

docker run --name ubuntu --rm -p 80:80 -e LOG_STDOUT=true -e LOG_STDERR=true -e LOG_LEVEL=debug -v $SRCDIR:/var/www/html fauria/lamp
