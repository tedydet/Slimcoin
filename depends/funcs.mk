define fetch_file
	@echo "Fetching $1..."
	@mkdir -p $2
	@if [ ! -f "$2/$3" ]; then \
		curl -L -o "$2/$3" "$1"; \
	fi
endef
