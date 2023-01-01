# Stage 1: Build the release files
FROM alpine:latest as builder

# Install git
RUN apk add --no-cache git

# Clone the repository
RUN git clone https://github.com/flatpressblog/flatpress.git

# Change to the repository directory
WORKDIR /flatpress

# Check out the specified git tag
ARG GIT_TAG=master
RUN git checkout $GIT_TAG

# Stage 2: Build the web server image
FROM php:8.1-apache

# Copy the release files from the builder stage
COPY --from=builder /flatpress /var/www/html

# Create the user and group
RUN groupadd -g 1000 ci && \
    useradd -u 1000 -g ci ci

# Set the ownership of the web server directory
RUN chown -R ci:ci /var/www/html

# Install the Apache mod_rewrite module
RUN a2enmod rewrite

# Install the PHP gdlib extension
RUN apt-get update && apt-get install -y libgd-dev && docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install gd

# Purge the previous apache2 config
RUN rm /etc/apache2/sites-enabled/000-default.conf /etc/apache2/sites-available/000-default.conf
RUN sed -i "s/Listen 80/Listen 8080/g" /etc/apache2/ports.conf

# Copy the Apache configuration file
COPY httpd.conf /etc/apache2/sites-available/flatpress.conf

# Enable the Apache configuration file
RUN a2ensite flatpress.conf

# Expose port 8080
EXPOSE 8080

# Start the Apache web 
USER ci:ci
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
