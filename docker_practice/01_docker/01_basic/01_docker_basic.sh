# docker 초기화
docker system prune -af --volumes

# 윈도우는 wsl에서 실습할것 권장
# docker 버전 / 명령어 확인
docker --version
docker --help


# 1. docker 이미지 명령어
# 1) docker pull
# 원격 저장소(Docker Hub, ECR 등)에 있는 이미지를 로컬 환경으로 다운로드하는 명령어이다.
docker search postgres

# 사용 말것 (tag 꼭 붙여넣어라)
docker pull postgres
docker pull postgres:latest
docker pull amazoncorretto


docker pull postgres:17.6
docker pull amazoncorretto:17

docker pull amazoncorretto@sha256:7b2a0022a2ad5814577d1c88ac703475dd9465b81871c12d97a0b796c90532c3

# 2) docker images
# 현재 로컬 환경에 다운로드 되어 있는 Docker 이미지 목록을 조회하는 명령어이다.

# 모든 이미지 보기
docker images
docker image ls

# 특정 이미지만 보기
docker images postgres
docker images amazoncorretto

# 사용하지 않는 이미지만 보기 (dangling)
docker images --filter "dangling=true"

# 이미지 ID 만 표시
docker images -q

# 3) docker rmi
# 불필요한 이미지를 삭제하여 디스크 공간을 확보할 수 있다.

# 이미지 ID로 삭제
docker rmi [Image ID]

# 이미지 이름:태그로 삭제
docker rmi amazoncorretto:17

# 사용하지 않는 이미지 모두 삭제
docker image prune

# 강제 삭제 (컨테이너가 사용하고 있어도 삭제 가능!)
docker rmi -f amazoncorretto:17
docker rmi -f [image Id, Image Name:Tag]