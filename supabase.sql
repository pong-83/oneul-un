-- 오늘운: 사용자별 기록 저장 테이블
-- Supabase 대시보드 → SQL Editor 에 붙여 넣고 Run 하세요.

create table if not exists public.user_state (
  user_id    uuid primary key references auth.users (id) on delete cascade,
  data       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- 행 단위 보안: 로그인한 본인 행만 읽고 쓸 수 있어요.
alter table public.user_state enable row level security;

drop policy if exists "read own state"   on public.user_state;
drop policy if exists "insert own state" on public.user_state;
drop policy if exists "update own state" on public.user_state;
drop policy if exists "delete own state" on public.user_state;

create policy "read own state"   on public.user_state
  for select using (auth.uid() = user_id);
create policy "insert own state" on public.user_state
  for insert with check (auth.uid() = user_id);
create policy "update own state" on public.user_state
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "delete own state" on public.user_state
  for delete using (auth.uid() = user_id);
