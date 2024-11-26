SCRIPTS := ./install.sh ./k3d-setup.sh

all:
	@chmod +x $(SCRIPTS)
	@for script in $(SCRIPTS); do \
		echo "$(BOLD)$(YELLOW)Executing $$script$(RESET)"; \
		$$script; \
	done

clean:
	@sudo kubectl delete ns argocd
	@sudo kubectl delete ns dev
	@sudo docker system prune -fa

app:
	@sudo kubectl port-forward svc/wil-service -n dev 8888:8888

re : clean all


.PHONY: all clean re app