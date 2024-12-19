all: run

run:
	@mkdir -p /home/mbenicho/data/wordpress_volume
	@mkdir -p /home/mbenicho/data/database_volume
	@docker-compose -f ./srcs/docker-compose.yml up --build

stop:
	@docker-compose -f ./srcs/docker-compose.yml down

clean: stop
	@-docker image rm `docker image ls -qa` 2>/dev/null || true
	@-docker volume rm `docker volume ls -q` 2>/dev/null || true
	@docker system prune -af

vclean: stop
	@rm -rf /home/mbenicho/data/wordpress_volume
	@rm -rf /home/mbenicho/data/database_volume

fclean: clean vclean
