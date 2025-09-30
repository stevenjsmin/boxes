# boxes
 /webdata/index.html 파일을 계속해서 Boxes로 업데이트한다.             

### Install 그리고 테스트
- docker build -t boxes:latest .
- docker tag boxes:latest stevenmin/boxes:latest
- docker push stevenmin/boxes:latest

80으로 컨테이너 내부에서 서비스되고있는 nginx를 호스트에서 8080으로 접속가능하도록 실행
- docker run -d --name boxes -p 8080:80 docker.io/stevenmin/boxes

- docker exec -it boxes bash

# 호스트에서 다음과 같이 테스트한다.
curl http://localhost:8080



### 핵심 사용법 (자주 쓰는 옵션)

- 디자인 목록 보기: boxes -l
- 디자인 선택: echo "hello" | boxes -d parchment
- 정렬/배치: -a
  - 수평: hl|c|r (왼/가운데/오른쪽)
  - 수직: vt|c|b (위/가운데/아래)
  - 줄 맞춤: jl|c|r
  - 축약: -a c = 가운데 정렬(수평/수직/줄맞춤 모두), 기본값은 hlvt

- 크기 지정: -s WIDTHxHEIGHT (예: -s 40x5)
- 패딩(여백): -p (예: -p a2 전체 2칸, -p h4t1 가로 4칸 + 위 1줄)
- 박스 제거: -r (이미 둘러진 상자를 인식해서 제거)
- 복원(수선) 후 다시 그리기: -m (깨진 박스를 고치고 다시 그림)
- 디자인 태그로 찾기(스크립트용): -q (예: boxes -q programming,-comment)
- 설정 파일 지정: -f <config> (커스텀 디자인 사용 시)

### Examples

```angular2html
# 1) 기본: 문자열을 박스로
echo "BOXES!" | boxes

# 2) 디자인 지정 + 가운데 정렬
printf "OpenShift\nImageStream Test\n" | boxes -d parchment -a c

# 3) 크기와 패딩을 강제
echo "Hi" | boxes -d stone -s 30x5 -p a2 -a c

# 4) 이미 박스쳐진 텍스트를 제거
cat boxed.txt | boxes -r > plain.txt

# 5) 상자를 '수선'해서 다시 그리기(여백/정렬 재적용)
cat maybe-broken.txt | boxes -m -d parchment -p h4 -a c

- echo "Important Note" | boxes -d parchment
- echo "System Status"  | boxes -d columns
- rig | boxes -d stone
- rig | boxes -d diamonds | lolcat
- figlet "boxes . . . !" | lolcat -f | boxes -d unicornthink
- rig | boxes -d diamonds | lolcat


```

https://boxes.thomasjensen.com/boxes-man-1.html

```angular2html
docker tag stevenmin/boxes trialqdcy13.jfrog.io/stevenlab-docker-local/boxes:1.0
docker push trialqdcy13.jfrog.io/stevenlab-docker-local/boxes:1.0
docker push trialqdcy13.jfrog.io/stevenlab-docker-local/<DOCKER_IMAGE>:<DOCKER_TAG>

docker login -u[USERNAME-NORMALLY EMAIL] trialqdcy13.jfrog.io
docker login yourcompany.jfrog.io -us[USERNAME-NORMALLY EMAIL] -p xXxxxxxxxxxxxxxxx[should be copy from set me up]


docker pull trialqdcy13.jfrog.io/stevenlab-docker-local/boxes:1.0


docker run -d --name boxes -p 8080:80 docker.io/stevenmin/boxes
docker run -d --name boxes -p 8080:80 trialqdcy13.jfrog.io/stevenlab-docker-loc
```
