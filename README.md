# AGENTOR

> **Cognitive Engineering OS** — El sistema operativo cognitivo para ingeniería de software.

No es un asistente de código. Es un runtime autónomo de ingeniería que
construye, audita, despliega y aprende de sistemas reales de software.

## Supera 4:1 a la competencia

| Capacidad                         | Hermes | OpenClaw | Pi+Engram | **AGENTOR** |
|-----------------------------------|:------:|:--------:|:---------:|:-----------:|
| Council pre-código (6 agentes)    | ❌     | ❌       | ❌        | ✅          |
| Triple audit gate automático      | ❌     | ❌       | ❌        | ✅          |
| ADR autogenerado y firmado        | ❌     | ❌       | Manual    | ✅          |
| Skills de fallos (no solo éxitos) | ❌     | ❌       | ❌        | ✅          |
| Production feedback loop nativo   | ❌     | ❌       | ❌        | ✅          |
| Memoria semántica (pgvector)      | SQLite | Markdown | SQLite    | ✅ pgvector |
| Peers gRPC (no jerarquía)         | ❌     | ❌       | Cadena    | ✅          |

## Leer antes de tocar código

1. `AGENTS.md` — Master System Prompt (ADN del sistema)
2. `CLAUDE.md` — Config para Claude Code
3. `docs/adrs/ADR-0001-initial-architecture.md` — Decisiones fundacionales
4. `.agentor/prompts/` — System prompt de cada agente
5. `.agentor/agents/council.yaml` — Configuración del council

## Estructura

```
/daemon     → Go 1.22+    (council orchestrator, gRPC server)
/engine     → Rust        (context engine, skill store, vectorización)
/agents     → Python 3.12 (council agents + audit agents)
/dashboard  → Next.js 15+ (UI, ADRs, skills, sessions)
/api        → Laravel 11  (SaaS, billing, auth, REST)
/shared     → Protobuf    (contratos inter-servicio)
/docs/adrs  → ADRs firmados
/skills     → Skill Store seed
/.agentor   → Config interna (prompts + council.yaml)
```

## El protocolo

```
Request del developer
  ↓
COUNCIL — 6 agentes en paralelo (claims + challenges)
  ↓
ADR firmado por los 6 agentes
  ↓
PLAN-AUDIT — coherencia del ADR
  ↓
IMPLEMENTACIÓN — agentes especializados
  ↓
IMPL-AUDIT — divergencia vs ADR en tiempo real
  ↓
MERGE
  ↓
REG-AUDIT — regresiones cross-feature
  ↓
SKILLS ENGINE — aprende el patrón y el fallo
  ↓
PRODUCTION LOOP — métricas reales retroalimentan al council
```

## Levantar infraestructura

```bash
docker-compose up -d
# PostgreSQL+pgvector en :5432
# Redis en :6379
# MinIO en :9000
```

## Regla de oro

> No existe código en este repo sin ADR aprobado y auditado.
