This elasticsearch image `v7.10.2` is patched against following `log4j` vulnerabilities:
* CVE-2021-44228
* CVE-2021-45046
* CVE-2021-45105

Since the only two latest versions `7.16.2` and `6.8.22` of `elasticsearch` were patched by vendor, but numerous products use exclusively interim releases *(i.e. [graylog](https://hub.docker.com/r/graylog/graylog))*, we've decided to release a patched image, although is the image according to [elasticsearch blog](https://xeraa.net/blog/2021_mitigate-log4j2-log4shell-elasticsearch/) not vulnerable.

The required steps were applied according to the advisory of [elasticsearch blog](https://xeraa.net/blog/2021_mitigate-log4j2-log4shell-elasticsearch/).

## Usage

Please consult the official `elasticsearch` repo: https://hub.docker.com/_/elasticsearch

### Dockerfile
```
FROM docker.elastic.co/elasticsearch/elasticsearch-oss:7.10.2
LABEL maintainer="Ivan Golman <ivan.golman@dkd.de>, dkd Internet Service GmbH."

WORKDIR /usr/share/elasticsearch
RUN zip -d lib/log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class

WORKDIR /usr/share/elasticsearch/config/jvm.options.d
RUN echo -e "# CVE-2021-44228\n-Dlog4j2.formatMsgNoLookups=true" > log4j2.options

WORKDIR /usr/share/elasticsearch
```

##### Run: (without data persistence)
```
docker run --publish 127.0.0.1:9200:9200 --env discovery.type=single-node dkdde/elasticsearch:7.10.2-log4j-patch
```

### Test Log4j Patch:

##### from `localhost`
```
curl -XGET "http://localhost:9200/_nodes/jvm?pretty" | grep formatMsgNoLookups
```

##### from `Container`

```
docker exec -it <Container-ID> bash
[root@1d27b5b5f6b8 elasticsearch]# cat config/jvm.options.d/log4j2.options
# CVE-2021-44228
-Dlog4j2.formatMsgNoLookups=true

[root@1d27b5b5f6b8 elasticsearch]# zip -d lib/log4j-core-*.jar org/apache/logging/log4j/core/lookup/JndiLookup.class
	zip warning: name not matched: org/apache/logging/log4j/core/lookup/JndiLookup.class

zip error: Nothing to do! (lib/log4j-core-2.11.1.jar)
```

## Contributing

* Fork the repo.
* Create a branch from the develop branch and name it 'feature/name-of-feature': `git checkout -b feature/my-new-feature` (We follow [this branching model] (http://nvie.com/posts/a-successful-git-branching-model/))
* Make sure you test your new feature.
* Commit your changes together with specs for them: `git commit -am 'Add some feature'`
* Push your changes to your feature branch.
* Submit a pull request to the **develop** branch. Describe your feature in the pull request. Make sure you commit the specs.
* A pull request does not necessarily need to represent the final, finished feature. Feel free to treat it as a base for discussion.
