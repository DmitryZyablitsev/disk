# Очистите старый ключ
# ssh-keygen -f ~/.ssh/known_hosts -R '45.138.74.25'

# Добавьте новый ключ
# ssh-keyscan -H 45.138.74.25 >> ~/.ssh/known_hosts
hardening-step-1:
	ssh-keygen -f ~/.ssh/known_hosts -R '45.138.74.25'
	ssh-keyscan -H 45.138.74.25 >> ~/.ssh/known_hosts
	ansible-playbook ansible/hardening_step_1.yml -i ansible/inventory1.ini

hardening-step-2:
	ansible-playbook ansible/hardening_step_2.yml -i ansible/inventory2.ini

docker-setup:
	ansible-playbook ansible/docker_setup.yml -i ansible/inventory3.ini

ansible-start:
	$(MAKE) hardening-step-1
	$(MAKE) hardening-step-2
	$(MAKE) docker-setup