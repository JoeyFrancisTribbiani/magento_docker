FROM php:7.4-fpm

#COPY ./sources.list.buster /etc/apt/sources.list
#uncomment above line if your server is in China mainland

ADD cacert.pem /var/www/html/cacert.pem

RUN ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#Change the timezone according to your own requirement

# install libraries required by the extensions
RUN apt-get update \
  && apt-get install -y \
    cron \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt1-dev \
    libfreetype6-dev \
    zlib1g-dev \
    libonig-dev \
    libzip-dev

# install extensions
RUN docker-php-ext-configure gd \
    --with-jpeg \
    --with-freetype && \
    docker-php-ext-install \
      bcmath \
      gd \
      intl \
      mbstring \
      pdo_mysql \
      soap \
      xsl \
      zip \
      sockets \
      opcache

RUN apt-get update -qq \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y git \
    mariadb-client wget curl \
    ca-certificates lsb-release apt-transport-https gnupg bsdmainutils

RUN echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee -a /etc/apt/sources.list.d/php.list \
    && curl https://packages.sury.org/php/apt.gpg | apt-key add - \
    && apt-get update -qq

RUN cd ~ \
    && curl -sS https://getcomposer.org/installer -o composer-setup.php \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer

WORKDIR /var/www/html
RUN chown -R www-data:www-data  &&  chmod -R 777 /var/www/html

CMD ["php-fpm", "-R"]

