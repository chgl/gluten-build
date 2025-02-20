FROM docker.io/library/ubuntu:24.04

RUN <<EOF
apt-get update
apt-get install -y cmake gcc g++ maven git python3 python3-pip openjdk-17-jdk sudo
EOF


RUN git clone https://github.com/apache/incubator-gluten.git

RUN <<EOF
cd incubator-gluten
export MAVEN_ARGS="-Pdelta"
./dev/buildbundle-veloxbe.sh --enable_s3=true --spark_version=3.5
EOF
