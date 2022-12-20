ARG BUILD_IMG
FROM $BUILD_IMG as release

COPY ./requirements.txt /

RUN \
  python3 -m pip install -r requirements.txt && rm -rf ~/.cache && \
  rm requirements.txt

RUN \
  python3 -m pip install nuitka==1.2.7 && rm -rf ~/.cache

FROM release as binaries

COPY . /build

RUN \
  cd build && \
  python3 -m nuitka --plugin-enable=numpy --standalone --onefile main.py && \
  cp main.bin /main.bin && \
  cd / && \
  rm -rf /build
