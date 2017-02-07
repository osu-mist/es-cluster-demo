FROM centos:7
MAINTAINER "Shujin Wu"
LABEL name="Elastic Search Node"

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

RUN yum -y install java-1.8.0-openjdk
RUN curl 'https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.4.4/elasticsearch-2.4.4.rpm' -o 'elasticsearch-2.4.4.rpm'
RUN rpm -ivh elasticsearch-2.4.4.rpm

RUN mkdir -p /var/data/elasticsearch
RUN chown elasticsearch /var/data/elasticsearch/
RUN cp /etc/elasticsearch/elasticsearch.yml /etc/elasticsearch/elasticsearch_org.yml
COPY elasticsearch.yml /etc/elasticsearch/elasticsearch.yml

RUN systemctl enable elasticsearch.service

EXPOSE 9200

CMD ["/usr/sbin/init"]
