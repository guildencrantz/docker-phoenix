FROM centos:centos6

RUN set -x             && \
    yum install -y tar && \
    yum clean all

RUN set -x       && \
    curl -sOL 'http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-linux-x64.rpm' \
         -H 'Cookie: oraclelicense=accept-securebackup-cookie' && \
    rpm -i jdk-7u51-linux-x64.rpm && \
    rm jdk-7u51-linux-x64.rpm && \
    echo 'export JAVA_HOME=/usr/java/jdk1.7.0_51/' >> ~/.bashrc

ENV HBASE_VERSION 0.94.24
RUN set -x         && \
    curl -L http://archive.apache.org/dist/hbase/hbase-$HBASE_VERSION/hbase-$HBASE_VERSION.tar.gz | \
    tar zvx --null && \
    echo "export HBASE_HOME=/hbase-$HBASE_VERSION" >> ~/.bashrc

ADD hbase-site.xml /hbase-$HBASE_VERSION/conf/hbase-site.xml
ADD run.sh /hbase-$HBASE_VERSION/bin/LOCAL-run.sh

ENV PHOENIX_VERSION 3.2.0
RUN set -x && \
    curl -L http://archive.apache.org/dist/phoenix/phoenix-$PHOENIX_VERSION/bin/phoenix-$PHOENIX_VERSION-bin.tar.gz | \
    tar zvx --null && \
    cp /phoenix-$PHOENIX_VERSION-bin/common/phoenix-core-$PHOENIX_VERSION.jar /hbase-$HBASE_VERSION/lib/


CMD ["/hbase-0.94.24/bin/LOCAL-run.sh"]

# vim: set ts=4 sw=4 sts=4 ai et :
