# 의료 이미지 뷰어 앱 (태블릿용)

환자 데이터베이스에 저장된 스터디 정보를 효과적으로 관리하고 의사들이 쉽게 이미지를 검토할 수 있도록 설계된 **의료 이미지 뷰어 앱**

## 주요 기능 및 특징:

### 1. 스터디 탭 리스트:

- 사용자가 로그인하면, 앱은 데이터베이스에 저장된 스터디 탭 리스트를 불러와 첫 화면에 표시합니다.
- 각 스터디 탭에는 다음과 같은 정보가 포함되어 있습니다:
  - STUDYKEY: 스터디 고유 식별키
  - PID: 환자 ID
  - PNAME: 환자 이름
  - MODALITY: 검사 방법
  - STUDYDESC: 스터디 설명 (선택 사항)
  - STUDYDATE: 스터디 날짜
  - REPORTSTATUS: 보고서 상태
  - SERIESCNT: 시리즈 수
  - IMAGECNT: 이미지 수
  - EXAMSTATUS: 검사 상태

### 2. 시리즈 리스트 및 썸네일 이미지:

- 사용자가 특정 스터디를 선택하면, 해당 스터디에 속한 시리즈 리스트와 썸네일 이미지를 표시합니다.
- 시리즈에는 다음과 같은 정보가 포함되어 있습니다:
  - SERIESKEY: 시리즈 고유 식별키
  - SERIESDESC: 시리즈 설명 (선택 사항)
  - SCORE: 점수 (선택 사항)
  - IMAGECNT: 이미지 수
  - PATH: 시리즈 경로
  - FNAME: 파일 이름
  - HEADERS: 헤더 정보

### 3. 다이콤 파일 이미지 뷰어:

- 사용자가 특정 시리즈를 선택하면, 해당 시리즈에 속한 다이콤 파일들의 이미지를 뷰어에서 확인할 수 있습니다.
- 뷰어는 다음과 같은 조작을 허용합니다:
  - 흑백 반전
  - 확대 및 축소
  - 회전
  - 윈도우 레벨 조정
  - 감마값 조절

## 사용법:

1. 로그인하여 앱에 접속합니다.
2. 원하는 스터디를 선택하여 해당 스터디의 시리즈 및 이미지를 확인합니다.
3. 시리즈를 선택하면 다이콤 파일 이미지 뷰어가 열리고, 여러 조작을 통해 이미지를 검토합니다.

## 주의사항:

- 본 앱은 의료 전문가들을 위한 간편한 이미지 뷰어로 설계되었습니다.
- 중요한 의료 정보는 본 앱을 통해 진단하지 말고, 전문의의 진료를 받아 주십시오.

이 앱은 의료 이미지 관리와 뷰잉을 효율적으로 지원하여 의사들이 신속하게 이미지를 검토하고 판독할 수 있도록 합니다.


## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
