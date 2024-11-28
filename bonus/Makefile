SCRIPTS := ./install.sh ./k3d-setup.sh

all:
	chmod +x $(SCRIPTS)
	for script in $(SCRIPTS); do \
		$$script; \
	done

clean:
	kubectl delete ns argocd
	kubectl delete ns dev
	kubectl cluster delete argocd
	docker system prune -fa

app:
	 # kubectl port-forward svc/wil-service -n dev 8888:8888
	 chmod +x app-port.sh
	 sh app-port.sh

re : clean all


.PHONY: all clean re app
