# Amazon Corretto 17 (JDK) 기반 이미지 사용
FROM amazoncorretto:17

# 컨테이너 작업 환경 디렉토리 설정
WORKDIR /app

# 호스트 jar파일을 컨테이너 내부로 복사하는 명령
COPY blog-1.0.0_prod.jar app.jar

# ENV 설정
ENV SPRING_PROFILES_ACTIVE=prod


# 8080 포트 노출 (Spring boot default)
EXPOSE 8080

# JAR 파일 실행
ENTRYPOINT ["java", "-jar", "app.jar"]

# 빌드 및 실행 명령어
# > docker build -t blog-app .
# > docker run --name my-blog -d --network app-net -p 8080:8080 blog-app