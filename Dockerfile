FROM ubuntu:18.04

# 비대화식 apt 설정
ENV DEBIAN_FRONTEND=noninteractive

# Rig, Boxes설치
RUN apt-get update ; apt-get -y install rig boxes

# Nginx 설치
RUN apt-get install -y --no-install-recommends nginx ca-certificates \
 && rm -rf /var/lib/apt/lists/*

## (옵션) OpenShift 등 임의 UID 실행 호환을 위한 퍼미션 정리
#RUN mkdir -p /var/cache/nginx /var/run /var/log/nginx /var/lib/nginx \
# && chgrp -R 0 /var/cache/nginx /var/run /var/log/nginx /var/lib/nginx /var/www/html \
# && chmod -R g+rwX /var/cache/nginx /var/run /var/log/nginx /var/lib/nginx /var/www/html

# NGINX가 쓸 수 있는 디렉토리 준비
# (이미지 내부 경로는 root 그룹으로 맞추고 그룹 쓰기 허용)
RUN mkdir -p /var/cache/nginx /var/log/nginx /var/run /usr/share/nginx/html /webdata /tmp/nginx \
 && chgrp -R 0 /var/cache/nginx /var/log/nginx /var/run /usr/share/nginx/html /webdata /tmp/nginx \
 && chmod -R g+rwX /var/cache/nginx /var/log/nginx /var/run /usr/share/nginx/html /webdata /tmp/nginx

# 기본 페이지
RUN printf '%s\n' '<h1>Hello from OpenShift-compatible NGINX</h1>' > /usr/share/nginx/html/index.html \
 && chgrp 0 /usr/share/nginx/html/index.html && chmod g+rw /usr/share/nginx/html/index.html

## OpenShift에서 임의 UID로 돌려도 OK. 로컬 테스트 겸해서 비루트 명시(선택)
#USER 1001


EXPOSE 80

# 포어그라운드 실행
CMD ["nginx", "-g", "daemon off;"]




ENV INTERVAL=5
ENV OPTION=stone

ADD genid.sh /bin/genid.sh
RUN chmod +x /bin/genid.sh

# genid.sh를 백그라운드로
CMD ["sh", "-c", "/bin/genid.sh >> /proc/1/fd/1 2>&1 & exec nginx -g 'daemon off;'"]
