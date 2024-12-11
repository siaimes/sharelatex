# Sharelatex

Sharelatex image with full installation and Chinese support.

Users just need to change the share latex image tag from `sharelatex/sharelatex` to `siaimes/sharelatex`, for example, change [this line](https://github.com/overleaf/toolkit/blob/7c754add39b9dee81da2b798a17cec7365335a50/bin/docker-compose#L65) by using the following command before running `bin/up`:

```
sed -i 's/image_name="sharelatex/image_name="siaimes/' ./bin/docker-compose
```

After 2023/03/20, users just need to add env `SHARELATEX_IMAGE_NAME=siaimes/sharelatex` in `config/overleaf.rc`。

Update[December 2024] :

Delete previously created config files in `config/` if it exists. 
Add `SHARELATEX_IMAGE_NAME=siaimes/sharelatex` in the `overleaf.rc` file located in `/previous-path/overleaf-toolkit/lib/config-seed/`. Then run,

```bash
$ bin/init   
```
Check the `config/version` value if it matches with the latest version from the [Official Docker Hub](https://registry.hub.docker.com/r/siaimes/sharelatex/tags). If not, change it manually. Then run,

```bash
$ bin/up     # First time building
$ bin/up -d  # there exists sharelatex/sharelatex already. 
```

If [version](https://github.com/overleaf/toolkit/blob/master/lib/config-seed/version#L1) of sharelatex updated, please let me know.
