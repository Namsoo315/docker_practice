# docker 초기화
docker system prune -af --volumes

# 윈도우는 wsl에서 실습할것 권장

# docker 버전 / 명령어 확인
docker --version
docker --help

# ■ 1. docker 이미지 명령어

# 1) docker pull
# 원격 저장소(Docker Hub, ECR 등)에 있는 이미지를 로컬 환경으로 다운로드하는 명령어이다.
docker search postgres

# 최신 버전 다운로드 (쓰지 말것! 반드시 버전 tag 기입 권장!)
docker pull postgres
docker pull postgres:latest
docker pull amazoncorretto

# 특정 버전 다운로드
docker pull postgres:17.6
docker pull amazoncorretto:17

# 특정 다이제스트로 다운로드
docker pull amazoncorretto@sha256:1397178f7c09672b941f8c0190d073ff5e1800179d2c991392ddf86740208f50


# 2) docker images
# - 현재 로컬 환경에 다운로드 되어 있는 Docker 이미지 목록을 조회하는 명령어이다.

# 모든 이미지 보기
docker images
docker image ls

# 특정 이미지만 보기
docker images postgres
docker images amazoncorretto

# 사용하지 않는 이미지만 보기 (dangling)
docker images --filter "dangling=true"

# 이미지 ID만 표시
docker images -q

# 3) docker rmi
# - 불필요한 이미지를 삭제하여 디스크 공간을 확보할 수 있다.

# 이미지 ID로 삭제
docker rmi 0f4f20021a06

# 이미지 이름:태그로 삭제
docker rmi amazoncorretto:17

# 사용하지 않는 이미지 모두 삭제
docker image prune

# 강제삭제 (컨데이너가 사용하고 있어도 삭제 가능!)
docker rmi -f amazoncorretto:17
docker rmi -f postgres:17.6


# ■ 2. docker 컨테이너 명령어

# docker run
# 컨테이너 이미지를 기반으로 새 컨테이너를 생성하고 지정한 프로세스를 실행하는 명령이다.
# 이미지가 없으면 pull을 실행한다.

# 기본 실행
docker run --name my-tomcat -d tomcat
docker ps
docker stop my-tomcat
docker rm my-tomcat

# 포트 매핑 추가(host/container)
docker run --name my-tomcat -p 80:8080 -d tomcat
docker ps
docker rm -f my-tomcat

# 환경변수 + 포트매핑 + 볼륨마운트 추가
docker run --name my-postgres \
  -e POSTGRES_USER=user1 \
  -e POSTGRES_PASSWORD=1234 \
  -e POSTGRES_DB=mydb \
  -p 5000:5432 \
  -v postgres-data:/var/lib/postgresql/data \
  -d postgres:17.6

# datagrip을 통해 접속하기
# 강제 + 볼륨 삭제
docker rm -fv my-postgres


# docker ps
# 실행  컨테이너 목록을 출력하는 명령어, 컨테이너 ID, 이미지, 상태, 포트 매핑과 같은 주요 정보를 확인

# 실행 중인 컨테이너만 표시
docker ps

# 모든 컨테이너 표시 (중지된 컨테이너 포함)
docker ps -a

# 최근에 생성된 컨테이너만 표시
docker ps -l

# 특정 이름 패턴으로 필터링
docker ps --filter "name=postgres"

# 컨테이너 ID만 표시
docker ps -q

# start / stop / restart

# 컨테이너 시작
docker start my-postgres
docker start a1b2c3d4e5f6 # id로 제어 가능

# 컨테이너 중지
docker stop my-postgres
docker stop a1b2c3d4e5f6 # id로 제어 가능

# 컨테이너 재시작
docker restart my-postgres
docker restart a1b2c3d4e5f6 # id로 제어 가능

# 타임아웃 설정 (10초 후 강제 종료)
docker stop -t 10 my-postgres

# docker exec
# - 실행 중인 컨테이너 안에서 추가 명령어를 실행할 때 사용하는 명령어이다.

# 대화형 쉘로 접속
docker exec -it my-postgres bash

# 직접 psql 실행
docker exec -it my-postgres psql -U user1 -d mydb

# 단일 명령 실행
docker exec my-postgres pg_isready


# docker logs
# 실행 중이거나 종료된 컨테이너의 표준 출력(stdout)과 표준 에러(stderr) 로그를 확인하는 명령어다

# 모든 로그 출력
docker logs my-postgres

# 실시간 로그 추적
docker logs -f my-postgres

# 최근 10줄만 표시
docker logs --tail 10 my-postgres

# 타임스탬프 표시
docker logs -t my-postgres

# 최근 10분간 로그만 출력
docker logs --since 10m my-postgres


# docker cp
# 컨테이너와 호스트 간 파일을 주고받는 명령어이다.

# 호스트 → 컨테이너 복사
# hello.jsp를 my-tomcat 컨테이너의 ROOT 디렉토리로 복사
docker run --name my-tomcat2 -p 81:8080 -d tomcat:11-jdk21
docker exec my-tomcat2 mkdir -p /usr/local/tomcat/webapps/ROOT
docker cp hello.jsp my-tomcat2:/usr/local/tomcat/webapps/ROOT/hello.jsp
docker restart my-tomcat2
# http://localhost:81/hello.jsp

# my-tomcat 컨테이너의 logs 디렉토리를 로컬 logs 폴더로 복사
docker cp my-tomcat2:/usr/local/tomcat/logs ./logs

# 컨테이너 → 호스트 복사
# my-postgres 컨테이너의 데이터 디렉토리를 로컬로 백업
docker cp my-postgres:/var/lib/postgresql/data ./data-backup


# docker rm
# 컨테이너를 삭제하는 명령어이다. 컨테이너를 삭제하면 해당 컨테이너의 파일시스템, 설정, 네트워크 정보가 사라진다.

# Postgres 컨테이너 삭제 (중지 상태일 때)
docker rm my-postgres

# Tomcat 컨테이너 강제 삭제 (실행 중 포함)
docker rm -f my-tomcat

# 컨테이너와 연결된 볼륨까지 함께 삭제 (현재 docker 버전에서는 안됨!)
docker rm -v my-postgres

# 여러 컨테이너 한 번에 삭제
docker rm my-postgres my-tomcat


# 3. 네트워크 관련 명령어
docker network ls
docker network prune

# 사용자 정의 bridge 네트워크 생성
docker network create --driver bridge my-bridge-network

# 컨테이너를 사용자 정의 bridge 네트워크에 연결하여 실행
docker run --name postgres-db \
--network my-bridge-network \
-e POSTGRES_PASSWORD=mysecretpassword \
-d postgres:17.3

# 같은 네트워크의 다른 컨테이너에서는 'postgres-db'라는 호스트명으로 접근 가능
docker run --name app --network my-bridge-network -d myapp

# 네트워크 없이 컨테이너 실행
docker run --name isolated-container --network none -d alpine sleep infinity

# overlay 네트워크 생성 (Docker Swarm 모드에서)
docker network create --driver overlay my-overlay-network


# 4. 볼륨 관련 명령어

# 볼륨 목록 확인
docker volume ls

# 볼륨 생성
docker volume create postgres-data2

# 볼륨 정보 확인
docker volume inspect postgres-data2

# 볼륨 삭제
docker volume rm postgres-data2

# 사용하지 않는 볼륨 삭제
docker volume prune