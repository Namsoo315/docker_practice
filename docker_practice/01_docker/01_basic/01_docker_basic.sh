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

sha256:7b2a0022a2ad5814577d1c88ac703475dd9465b81871c12d97a0b796c90532c3