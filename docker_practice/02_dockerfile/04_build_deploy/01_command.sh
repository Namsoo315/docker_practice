# 1. docker buildx build

# 단일 아키텍처 빌드
docker buildx build -t my-app:1.0 .

# 멀티 아키텍처 빌드
docker buildx build --platform linux/amd64,linux/arm64 -t my-dockerhub-id/my-app:1.0 .

# 멀티 아키텍처 빌드 및 푸시
docker buildx build --platform linux/amd64,linux/arm64 -t my-dockerhub-id/my-app:1.0 --push .

# 2. 이미지 태깅 (Tagging)
# 형식: repository:tag
# repository = 이미지 이름 (ex: nginx, my-dockerhub-id/my-app)
# tag = 버전 또는 구분자 (ex: latest, 1.0, prod), 태그가 없으면 자동으로 latest가 붙는다.

# 빌드하면서 태그 붙이기
docker build -t my-app:1.0 .

# 태그 추가
docker tag my-app:1.0 my-dockerhub-id/my-app:1.0


# 3. DockerHub 배포 하기

# 1. 로그인
docker login

# 2. 태그 지정(아이디로 지정해야함)
docker tag my-app:1.0 haesung7lee/my-app:1.0

# 3. 푸시
docker push haesung7lee/my-app:1.0

# 4. 확인
# - 기존 이미지 지우고 확인 가능
docker pull haesung7lee/my-app:1.0

# 5. 삭제
# 계정 들어가서 진행할것!