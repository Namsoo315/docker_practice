## 전체 서비스 빌드 후 실행 (백그라운드 모드)
docker compose up -d

## 컨테이너, 네트워크, 볼륨까지 모두 정리
docker compose down -v --rmi all

## 변경된 이미지 다시 빌드 후 실행
docker compose up -d --build

## 서비스 상태 확인
docker compose ps

## 서비스 로그 확인 (app 서비스, 실시간)
docker compose logs -f app

## 특정 컨테이너 내부로 접속 (db 서비스에 bash)
docker compose exec db bash

## 특정 서비스에 일회성 명령 실행 (psql 접속 예시)
docker compose run --rm db psql -U user1 my_blog

## 설정 파일 확인 (merge된 실제 적용 설정 보기)
docker compose config

## 서비스가 사용하는 이미지 목록 확인
docker compose images

## 실행 중인 컨테이너의 프로세스 확인
docker compose top
