FROM c7-systemd
MAINTAINER "Shujin Wu"
LABEL name="Elastic Search Node"

RUN yum -y install java-1.8.0-openjdk
RUN curl 'https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/2.4.4/elasticsearch-2.4.4.rpm' -o 'elasticsearch-2.4.4.rpm'
RUN rpm -ivh elasticsearch-2.4.4.rpm
RUN systemctl enable elasticsearch.service

EXPOSE 9200

CMD ["/usr/sbin/init"]
