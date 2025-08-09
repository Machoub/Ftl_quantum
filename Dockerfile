FROM python:3.9-slim-bookworm

RUN --mount=target=/var/lib/apt/lists,type=cache,sharing=locked \
		--mount=target=/var/cache/apt,type=cache,sharing=locked \
		rm -f /etc/apt/apt.conf.d/docker-clean \
		apt-get update && \
		apt-get upgrade -y && \
		apt-get clean

WORKDIR /home/42-ftl-quantum

# Ton fichier est tools/req.txt
COPY ./tools/req.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Dossier présent: "exercices"
COPY exercices ./exercices

EXPOSE 8888
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--allow-root", "--no-browser"]