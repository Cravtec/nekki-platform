include .env
DC = $(SUDO) docker-compose -f $(YML)
PY = $(DC) exec backend
FE = $(DC) exec frontend
NX = $(DC) exec nginx

#======================= CONTAINERS_MANAGEMENT =========================
#=======================================================================
# build and run containers and remove orphan containers
up:
	$(DC) up
buildup:
	$(DC) up --build --remove-orphans
down:
	$(DC) down
# down + volumes
down-v:
	$(DC) down -v
logs:
	$(DC) logs
prune:
	docker system prune -a --volumes

#======================= BACKEND FASTAPI ===============================
#=======================================================================

backend_shell:
	$(PY) bash
flake8:
	$(PY) flake8 .
# --preview flag helping with wrapping long strings
black:
	$(PY) black --preview --check .
black-diff:
	$(PY) black --preview --diff .
black-exec:
	$(PY) black --preview .
isort:
	$(PY) isort . --check-only --skip venv
isort-diff:
	$(PY) isort . --diff --skip venv
isort-exec:
	$(PY) isort . --skip venv

#======================= FRONTEND REACT ================================
#=======================================================================

frontend_shell:
	$(FE) sh

#======================= NGINX SERVER ==================================
#=======================================================================

nginx_shell:
	$(NX) sh