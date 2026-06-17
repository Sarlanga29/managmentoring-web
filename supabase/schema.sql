-- Managmentoring private portal schema.
-- Run this in Supabase SQL Editor after creating the project.
-- Keep Row Level Security enabled before loading real client data.

create extension if not exists pgcrypto;

create type public.user_role as enum ('admin', 'client');
create type public.client_status as enum ('lead', 'diagnosis', 'active', 'follow_up', 'paused', 'completed');
create type public.program_status as enum ('draft', 'active', 'archived');
create type public.enrollment_status as enum ('invited', 'active', 'paused', 'completed');
create type public.material_type as enum ('pdf', 'video', 'document', 'link', 'exercise');
create type public.payment_status as enum ('pending', 'paid', 'overdue', 'waived');

create table public.profiles (
  id uuid primary key references auth.users(id) on delete cascade,
  full_name text not null,
  email text not null unique,
  role public.user_role not null default 'client',
  phone text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.clients (
  id uuid primary key default gen_random_uuid(),
  profile_id uuid references public.profiles(id) on delete set null,
  display_name text not null,
  company_name text,
  email text,
  phone text,
  status public.client_status not null default 'lead',
  source text,
  private_notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.programs (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  description text,
  status public.program_status not null default 'draft',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.enrollments (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references public.clients(id) on delete cascade,
  program_id uuid not null references public.programs(id) on delete restrict,
  status public.enrollment_status not null default 'invited',
  progress_percent integer not null default 0 check (progress_percent between 0 and 100),
  start_date date,
  target_end_date date,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  unique (client_id, program_id)
);

create table public.sessions (
  id uuid primary key default gen_random_uuid(),
  enrollment_id uuid not null references public.enrollments(id) on delete cascade,
  title text not null,
  scheduled_at timestamptz,
  duration_minutes integer not null default 90,
  location text,
  client_visible_summary text,
  private_notes text,
  completed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.materials (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  type public.material_type not null default 'document',
  url text,
  description text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.enrollment_materials (
  id uuid primary key default gen_random_uuid(),
  enrollment_id uuid not null references public.enrollments(id) on delete cascade,
  material_id uuid not null references public.materials(id) on delete cascade,
  assigned_at timestamptz not null default now(),
  due_at timestamptz,
  completed_at timestamptz,
  unique (enrollment_id, material_id)
);

create table public.tasks (
  id uuid primary key default gen_random_uuid(),
  enrollment_id uuid not null references public.enrollments(id) on delete cascade,
  title text not null,
  details text,
  due_at timestamptz,
  completed_at timestamptz,
  client_visible boolean not null default true,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table public.payments (
  id uuid primary key default gen_random_uuid(),
  client_id uuid not null references public.clients(id) on delete cascade,
  enrollment_id uuid references public.enrollments(id) on delete set null,
  amount numeric(12, 2) not null,
  currency text not null default 'USD',
  status public.payment_status not null default 'pending',
  due_date date,
  paid_at timestamptz,
  notes text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index clients_profile_id_idx on public.clients(profile_id);
create index enrollments_client_id_idx on public.enrollments(client_id);
create index sessions_enrollment_id_idx on public.sessions(enrollment_id);
create index enrollment_materials_enrollment_id_idx on public.enrollment_materials(enrollment_id);
create index tasks_enrollment_id_idx on public.tasks(enrollment_id);
create index payments_client_id_idx on public.payments(client_id);

create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger profiles_set_updated_at before update on public.profiles
for each row execute function public.set_updated_at();

create trigger clients_set_updated_at before update on public.clients
for each row execute function public.set_updated_at();

create trigger programs_set_updated_at before update on public.programs
for each row execute function public.set_updated_at();

create trigger enrollments_set_updated_at before update on public.enrollments
for each row execute function public.set_updated_at();

create trigger sessions_set_updated_at before update on public.sessions
for each row execute function public.set_updated_at();

create trigger materials_set_updated_at before update on public.materials
for each row execute function public.set_updated_at();

create trigger tasks_set_updated_at before update on public.tasks
for each row execute function public.set_updated_at();

create trigger payments_set_updated_at before update on public.payments
for each row execute function public.set_updated_at();

create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select exists (
    select 1
    from public.profiles
    where id = auth.uid()
      and role = 'admin'
  );
$$;

create or replace function public.client_ids_for_current_user()
returns setof uuid
language sql
stable
security definer
set search_path = public
as $$
  select id
  from public.clients
  where profile_id = auth.uid();
$$;

alter table public.profiles enable row level security;
alter table public.clients enable row level security;
alter table public.programs enable row level security;
alter table public.enrollments enable row level security;
alter table public.sessions enable row level security;
alter table public.materials enable row level security;
alter table public.enrollment_materials enable row level security;
alter table public.tasks enable row level security;
alter table public.payments enable row level security;

create policy "Admins can manage profiles"
on public.profiles for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

create policy "Users can read their own profile"
on public.profiles for select
to authenticated
using (id = auth.uid());

create policy "Admins can manage clients"
on public.clients for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

create policy "Clients can read their own client record"
on public.clients for select
to authenticated
using (profile_id = auth.uid());

create policy "Admins can manage programs"
on public.programs for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

create policy "Authenticated users can read active programs"
on public.programs for select
to authenticated
using (status = 'active' or public.is_admin());

create policy "Admins can manage enrollments"
on public.enrollments for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

create policy "Clients can read their own enrollments"
on public.enrollments for select
to authenticated
using (client_id in (select public.client_ids_for_current_user()));

create policy "Admins can manage sessions"
on public.sessions for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

create policy "Clients can read their own sessions"
on public.sessions for select
to authenticated
using (
  enrollment_id in (
    select id
    from public.enrollments
    where client_id in (select public.client_ids_for_current_user())
  )
);

create policy "Admins can manage materials"
on public.materials for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

create policy "Assigned clients can read materials"
on public.materials for select
to authenticated
using (
  id in (
    select em.material_id
    from public.enrollment_materials em
    join public.enrollments e on e.id = em.enrollment_id
    where e.client_id in (select public.client_ids_for_current_user())
  )
);

create policy "Admins can manage enrollment materials"
on public.enrollment_materials for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

create policy "Clients can read their assigned materials"
on public.enrollment_materials for select
to authenticated
using (
  enrollment_id in (
    select id
    from public.enrollments
    where client_id in (select public.client_ids_for_current_user())
  )
);

create policy "Admins can manage tasks"
on public.tasks for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

create policy "Clients can read visible tasks"
on public.tasks for select
to authenticated
using (
  client_visible = true
  and enrollment_id in (
    select id
    from public.enrollments
    where client_id in (select public.client_ids_for_current_user())
  )
);

create policy "Admins can manage payments"
on public.payments for all
to authenticated
using (public.is_admin())
with check (public.is_admin());

create policy "Clients can read their own payments"
on public.payments for select
to authenticated
using (client_id in (select public.client_ids_for_current_user()));

insert into public.programs (name, slug, description, status)
values
  ('10 escalones para llegar a tu excelencia', '10-escalones', 'Proceso individual de 10 sesiones para claridad, foco y plan de accion.', 'active'),
  ('Programa corporativo para mandos medios', 'mandos-medios', 'Acompanamiento para roles, comunicacion, motivacion y equipos de alto desempeno.', 'active'),
  ('AgroMENTORING', 'agromentoring', 'Gestion, liderazgo y procesos de cambio para profesionales y organizaciones del agro.', 'active')
on conflict (slug) do nothing;
