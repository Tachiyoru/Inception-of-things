all :
	cd scripts; sudo bash install.sh

clean :
	rm -f scripts/get-docker.sh

fclean: clean
	sudo kubectl delete ns argocd
	sudo kubectl delete ns dev
	sudo docker system prune -fa
	sudo k3d cluster delete -a

.PHONY : all clean fclean
