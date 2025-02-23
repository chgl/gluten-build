FROM docker.io/library/ubuntu:24.04
ENV DEBIAN_FRONTEND=noninteractive
ENV MAVEN_ARGS="-Pdelta -DskipTests"
ENV TREAT_WARNINGS_AS_ERRORS=0
ARG NUM_THREADS=8
ENV NUM_THREADS=${NUM_THREADS}

RUN <<EOF
apt-get update
apt-get install -y cmake gcc g++ maven git python3 python3-pip openjdk-17-jdk sudo libre2-dev libsimdjson-dev tzdata curl zip unzip tar
EOF


RUN git clone https://github.com/apache/incubator-gluten.git --depth 1 --branch v1.3.0

RUN <<EOF
cd incubator-gluten
./dev/buildbundle-veloxbe.sh --enable_vcpkg=ON --enable_s3=ON --spark_version=3.5 --build_arrow=ON --build_tests=OFF --build_benchmarks=OFF --build_examples=OFF --enable_gcs=OFF --enable_hdfs=OFF --enable_abfs=OFF
EOF
