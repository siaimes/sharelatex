FROM sharelatex/sharelatex:3.3.0

# Install TexLive
# ---------------
# CTAN mirrors occasionally fail, in that case install TexLive using a
# different server, for example https://ctan.crest.fr
#
# # docker build \
#     --build-arg TEXLIVE_MIRROR=https://ctan.crest.fr/tex-archive/systems/texlive/tlnet \
#     -f Dockerfile-base -t sharelatex/sharelatex-base .
ARG TEXLIVE_MIRROR=https://mirror.ox.ac.uk/sites/ctan.org/systems/texlive/tlnet

RUN $(find /usr/local/texlive -name tlmgr) path remove \
&&  rm -rf /usr/local/texlive/ \
&&  mkdir /install-tl-unx \
&&  wget --quiet https://tug.org/texlive/files/texlive.asc \
&&  gpg --import texlive.asc \
&&  rm texlive.asc \
&&  wget --quiet ${TEXLIVE_MIRROR}/install-tl-unx.tar.gz \
&&  wget --quiet ${TEXLIVE_MIRROR}/install-tl-unx.tar.gz.sha512 \
&&  wget --quiet ${TEXLIVE_MIRROR}/install-tl-unx.tar.gz.sha512.asc \
&&  gpg --verify install-tl-unx.tar.gz.sha512.asc \
&&  sha512sum -c install-tl-unx.tar.gz.sha512 \
&&  tar -xz -C /install-tl-unx --strip-components=1 -f install-tl-unx.tar.gz \
&&  rm install-tl-unx.tar.gz* \
&&  echo "tlpdbopt_autobackup 0" >> /install-tl-unx/texlive.profile \
&&  echo "tlpdbopt_install_docfiles 0" >> /install-tl-unx/texlive.profile \
&&  echo "tlpdbopt_install_srcfiles 0" >> /install-tl-unx/texlive.profile \
&&  echo "selected_scheme scheme-full" >> /install-tl-unx/texlive.profile \
    \
&&  /install-tl-unx/install-tl \
      -profile /install-tl-unx/texlive.profile \
      -repository ${TEXLIVE_MIRROR} \
    \
&&  $(find /usr/local/texlive -name tlmgr) path add \
&&  rm -rf /install-tl-unx

# Install Fonts
RUN apt-get update && apt-get install xfonts-wqy python3-pygments inkscape fonts-font-awesome -y

COPY ./fonts /usr/share/

RUN cd /usr/share/fonts

RUN mkfontscale

RUN mkfontdir

RUN fc-cache -fv

RUN fc-list :lang=zh-cn
