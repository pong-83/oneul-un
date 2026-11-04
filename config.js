// Supabase 프로젝트 정보를 넣으면 로그인이 켜져요.
// 두 값이 비어 있으면 로그인 없이, 기록을 이 브라우저에만 저장하는 모드로 동작해요.
//
// 값은 Supabase 대시보드 → Project Settings → API 에서 복사하세요.
// anon(public) 키는 브라우저에 공개돼도 괜찮은 키예요.
// 기록은 supabase.sql 의 보안 규칙(RLS) 때문에 본인 계정으로만 읽고 쓸 수 있어요.
// service_role 키는 절대 여기에 넣지 마세요.
window.ONEUL_CONFIG = {
  supabaseUrl: "",      // 예: "https://abcdefgh.supabase.co"
  supabaseAnonKey: ""   // 예: "eyJhbGciOi..."
};
