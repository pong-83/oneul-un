# 오늘운

사주와 타로 한 장으로 보는 오늘의 운세, 그리고 작은 미션 앱.

- `index.html` 앱 전체 (HTML·CSS·JS 한 파일)
- `config.js` Supabase 주소와 공개 키 (비어 있으면 로그인 없이 동작)
- `supabase.sql` 기록 저장 테이블과 보안 규칙
- `.nojekyll` GitHub Pages가 파일을 그대로 쓰게 하는 표시

## 1. GitHub Pages로 배포

1. 이 폴더의 파일을 저장소 맨 위(루트)에 올려요.
2. 저장소 → **Settings → Pages** 로 가요.
3. **Source**: `Deploy from a branch`, **Branch**: `main` / `/(root)` 를 고르고 Save.
4. 1~2분 뒤 `https://<아이디>.github.io/<저장소이름>/` 에서 열려요.

이 상태로는 로그인 없이, 기록이 각자의 브라우저에만 저장돼요.

## 2. 로그인 켜기 (Supabase, 무료)

1. https://supabase.com 에서 새 프로젝트를 만들어요.
2. **SQL Editor** 에서 `supabase.sql` 내용을 붙여 넣고 Run.
3. **Authentication → URL Configuration**
   - Site URL: `https://<아이디>.github.io/<저장소이름>/`
   - Redirect URLs 에도 같은 주소를 추가
4. **Authentication → Providers**
   - Email: 기본으로 켜져 있어요 (메일 링크 로그인).
   - Google (선택): Google Cloud Console 에서 OAuth 클라이언트를 만들고,
     승인된 리디렉션 URI 에 Supabase 가 알려주는 Callback URL 을 넣은 뒤
     Client ID / Secret 을 Supabase 에 입력해요.
5. **Project Settings → API** 에서 `Project URL` 과 `anon public` 키를 복사해
   `config.js` 에 넣고 저장소에 다시 올려요.

이제 앱을 열면 로그인 화면이 먼저 나오고, 사주와 일기는 계정별로 저장돼서
폰과 PC 어디서 로그인해도 같은 기록을 볼 수 있어요.

## 설치 없이 잠그기 (PIN 잠금)

로그인을 켜지 않아도 맨 아래 **🔒 잠금**에서 숫자 4~8자리 비밀번호를 정할 수 있어요.

- 기록은 브라우저 내장 암호화(PBKDF2 25만 회 + AES-256-GCM)로 잠근 채 이 기기에만 저장돼요.
- 앱을 열 때마다 비밀번호를 물어보고, 5번 틀리면 30초 동안 기다려야 해요.
- 비밀번호는 어디에도 저장하지 않아서, 잊으면 기록을 되살릴 수 없어요.
- 기기마다 따로 잠기고, 기기 사이 동기화는 되지 않아요. 동기화가 필요하면 아래 Supabase 로그인을 쓰세요.

## 보안 메모

- `anon` 키는 공개용이라 브라우저에 있어도 괜찮아요. 실제 보호는
  `supabase.sql` 의 RLS(행 단위 보안) 규칙이 맡아서, 본인 기록만 읽고 쓸 수 있어요.
- `service_role` 키는 모든 데이터를 열 수 있는 관리자 키라 절대 올리면 안 돼요.
- 로그아웃하면 이 기기에 남은 복사본도 지워져요.
