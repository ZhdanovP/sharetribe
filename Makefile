# image_name := $(shell pwd | xargs basename)
image_name := marketplace

base_dir := ~/marketplace

run:
	./script/docker_run.sh $(image_name) $(base_dir)
clean:
	./script/docker_cleanup.sh