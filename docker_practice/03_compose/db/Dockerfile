# 최신 Postres (17.6) 버전 기반
FROM postgres:17.6

# timezone 설정
#ENV TZ=Asiz/Seoul  # docker compose로 선언할 예정

# DB, 계정, 비밀번호 설정 (hard 코딩)
#ENV POSTGRES_DB=my_blog \
#    POSTGRES_USER=user1 \
#    POSTGRES_PASSWORD=1234

# 파일 COPY를 통해 최초 실행시 스키마 + 데이터 초기화
COPY schema.sql /docker-entrypoint-initdb.d/01_schema.sql
COPY data.sql   /docker-entrypoint-initdb.d/02_data.sql

EXPOSE 5432

EXPOSE 5432
VOLUME ["/var/lib/postgresql/data"]

# 이후 명령어
# > docker build -t my-postgres:17.6 ./
# > docker network create app-net
# > docker volume create pgdata_dev
# > docker run --name my-postgres -d --network app-net -p 5432:5432 -v pgdata_dev:/var/lib/postgresql/data my-postgres:17.6