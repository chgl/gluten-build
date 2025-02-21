FROM docker.io/library/ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive
ENV MAVEN_ARGS="-Pdelta"
ENV TREAT_WARNINGS_AS_ERRORS=0

RUN <<EOF
apt-get update
apt-get install -y cmake gcc g++ maven git python3 python3-pip openjdk-17-jdk sudo
EOF


RUN git clone https://github.com/apache/incubator-gluten.git --depth 1 --branch v1.3.0

RUN <<EOF
cd incubator-gluten
./dev/buildbundle-veloxbe.sh --enable_s3=true --spark_version=3.5
EOF
