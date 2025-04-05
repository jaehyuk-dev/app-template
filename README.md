# Flutter App Template

플러터 프로젝트 기본 템플릿

## Start Project

1. 탬플릿 클론

```bash
git clone https://github.com/jaehyuk-dev/app-template.git lunch-mate
cd lunch-mate
```

2. 기존 Git 연결 제거 및 초기화

```bash
rm -rf .git
git init
```

3. 아이콘 적용

```bash
flutter pub run flutter_launcher_icons
```

4. 프로젝트 명 변경

```bash
flutter pub run change_app_package_name:main com.<company>.<app_name>
```

5. 의존성 초기화 및 업데이트

```bash
flutter clean
flutter pub get
```

6. 새 GitHub 저장소 등록

```bash
git add .
git commit -m "init"
git branch -M main
git remote add origin https://github.com/jaehyuk-dev/<repository_name>.git
git push -u origin main
```

## Environment
Flutter Version : 3.29.2

Dart Version : 3.7.2

## Dependency
- cupertino_icons: ^1.0.8

- google_mobile_ads: ^5.3.1   # Google Admob

- sqflite: ^2.3.0             # DB - sqlite
- loading_indicator: ^3.1.1   # custom loading indicator
- intl: ^0.20.2               # formating
- url_launcher: ^6.3.1        # link to others

- shared_preferences: ^2.5.2  # storage
- change_app_package_name: ^1.5.0 # chage app package name

- path_provider: ^2.1.2

- provider: ^6.1.2
- logger: ^2.5.0
