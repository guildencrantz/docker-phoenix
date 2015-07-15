FROM centos:centos6

RUN yum install -y tar && \
    yum clean all

RUN set -x && \
    curl -sOL 'http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.rpm' \
         -H 'Cookie: oraclelicense=accept-securebackup-cookie' && \
    rpm -i jdk-7u51-linux-x64.rpm && \
    rm jdk-7u51-linux-x64.rpm && \
    echo 'export JAVA_HOME=/usr/java/jdk1.7.0_51/' >> ~/.bashrc

ENV ZOOKEEPER_PACKAGE zookeeper-3.4.6
RUN set -x && \
    curl -sL "http://archive.apache.org/dist/zookeeper/${ZOOKEEPER_PACKAGE}/${ZOOKEEPER_PACKAGE}.tar.gz" | \
    tar xz --null && \
    ln -s "${ZOOKEEPER_PACKAGE}" zookeeper && \
    cp /zookeeper/conf/zoo{_sample,}.cfg

CMD ["/zookeeper/bin/zkServer.sh", "start-foreground"]

