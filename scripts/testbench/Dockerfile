FROM ubuntu:noble

# Update apt and install curl and git
RUN apt update && \
    apt install -y \
        curl git build-essential \
    && rm -rf /var/lib/apt/lists/*

# Remove the 'ubuntu' user if it exists
RUN if id "ubuntu" >/dev/null 2>&1; then deluser --remove-home ubuntu; fi

# Create a new group and user with UID and GID 1000, if not already taken
RUN if ! getent group 1000; then groupadd -g 1000 gno; fi && \
    useradd -m -u 1000 -g 1000 gno

# Set the default user to gno
USER gno

RUN echo "\
echo Welcome to the dotfiles testbench! Type run to start.\n\
echo "" \n\
alias run=\"bash $HOME/dotfiles/scripts/install-dotfiles.sh && source $HOME/.bashrc\"\n" >> $HOME/.bashrc

