# Phusion Passenger server based on openSUSE Leap 15
FROM fcrespel/base-image:opensuse15

# Arguments
ARG RACK_VERSION="2.0.7"
ARG BUNDLER_VERSION="1.17.3"
ARG PASSENGER_VERSION="6.0.4"

# Environment
ENV PASSENGER_ENVIRONMENT="production"
ENV RAILS_ENV="${PASSENGER_ENVIRONMENT}"

# Build tools and libraries
RUN zypper in -y gcc gcc-c++ make patch \
	libcurl-devel libmysqlclient-devel libopenssl-devel libxml2-devel libxslt-devel zlib-devel &&\
	zypper clean -a

# Ruby
RUN zypper in -y ruby ruby-devel &&\
	zypper clean -a

# Passenger and other gems
RUN gem install \
	rack:${RACK_VERSION} \
	passenger:${PASSENGER_VERSION} \
	bundler:${BUNDLER_VERSION} \
	--no-ri --no-doc --no-format-executable

# Files
COPY ./root /
RUN chmod +x /run.sh

# Ports
EXPOSE 3000
