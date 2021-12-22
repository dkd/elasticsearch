This elasticsearch image `v7.10.2` is patched against following `log4j` vulnerabilities:
* CVE-2021-44228
* CVE-2021-45046
* CVE-2021-45105

Since the only two latest versions `7.16.2` and `6.8.22` of `elasticsearch` were patched by vendor, but numerous products use exclusively interim releases *(i.e. [graylog](https://hub.docker.com/r/graylog/graylog))*, we've decided to release a patched image, although is the image according to [elasticsearch blog](https://xeraa.net/blog/2021_mitigate-log4j2-log4shell-elasticsearch/) not vulnerable.

The required steps were applied according to the advisory of [elasticsearch blog](https://xeraa.net/blog/2021_mitigate-log4j2-log4shell-elasticsearch/).

## Usage

Please consult the official `elasticsearch` repo: https://hub.docker.com/_/elasticsearch

## Contributing

* Fork the repo.
* Create a branch from the develop branch and name it 'feature/name-of-feature': `git checkout -b feature/my-new-feature` (We follow [this branching model] (http://nvie.com/posts/a-successful-git-branching-model/))
* Make sure you test your new feature.
* Commit your changes together with specs for them: `git commit -am 'Add some feature'`
* Push your changes to your feature branch.
* Submit a pull request to the **develop** branch. Describe your feature in the pull request. Make sure you commit the specs.
* A pull request does not necessarily need to represent the final, finished feature. Feel free to treat it as a base for discussion.
