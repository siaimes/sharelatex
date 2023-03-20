# Sharelatex

Sharelatex image with full installation and Chinese support.

Users just need to change the share latex image tag from `sharelatex/sharelatex` to `siaimes/sharelatex`, for example, change [this line](https://github.com/overleaf/toolkit/blob/7c754add39b9dee81da2b798a17cec7365335a50/bin/docker-compose#L65) by using the following command before running `bin/up`:

```
sed -i 's/image_name="sharelatex/image_name="siaimes/' ./bin/docker-compose
```

After 2023/03/20, users just need to add env `SHARELATEX_IMAGE_NAME=siaimes/sharelatex` in `config/overleaf.rc`。

If [version](https://github.com/overleaf/toolkit/blob/master/lib/config-seed/version#L1) of sharelatex updated, please let me know.
