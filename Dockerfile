FROM docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.2
LABEL maintainer="Ivan Golman <ivan.golman@dkd.de>, dkd Internet Service GmbH."

WORKDIR /usr/share/elasticsearch
RUN zip -d lib/log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class

WORKDIR /usr/share/elasticsearch/config/jvm.options.d
RUN echo -e "# CVE-2021-44228\n-Dlog4j2.formatMsgNoLookups=true" > log4j2.options

WORKDIR /usr/share/elasticsearch

