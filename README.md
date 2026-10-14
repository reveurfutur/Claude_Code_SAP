# Claude_Code_SAP

Claude Code로 만든 ABAP 개발물을 abapGit으로 관리하는 저장소입니다.

## 패키지 구조

| 단계 | 패키지 이름 | GitHub 폴더 | 예시 |
|---|---|---|---|
| 루트 | `$YCLAUDE` | `src/` | |
| 대표 모듈 | `$YCLAUDE_<모듈>` | `src/<모듈>/` | `$YCLAUDE_SD` → `src/sd/` |
| 모듈 하위 | `$YCLAUDE_<모듈>_00X` | `src/<모듈>/00X/` | `$YCLAUDE_SD_001` → `src/sd/001/` |

- 모두 **로컬 패키지**(`$`)입니다. 이관(TR) 대신 GitHub + abapGit으로 시스템 간 이동합니다.
- 오브젝트 이름은 `Y`로 시작합니다.
- 하위 패키지는 Pull 시 abapGit이 자동으로 생성합니다.

## 오브젝트 배치 기준

| 패키지 | 무엇을 두나 | 예시 |
|---|---|---|
| 대표 모듈 (`$YCLAUDE_MD`) | 하위 영역 **두 곳 이상이 공통으로** 쓰는 오브젝트 | BP·MM 공통 클래스, 도메인, 구조 |
| 모듈 하위 (`$YCLAUDE_MD_001`) | **한 업무 영역**에서만 쓰는 오브젝트 | `_MD_001` BP, `_MD_002` MM |

- 처음엔 한 영역에서만 쓰다가 다른 영역에서도 쓰게 되면 대표 모듈 패키지로 옮깁니다.
- 참조는 하위 → 대표 모듈 방향만 허용합니다. (하위끼리, 대표 → 하위 참조 금지)
- 루트 `$YCLAUDE`에는 오브젝트를 두지 않습니다.

## 패키지 목록

### 대표 모듈 패키지

| 패키지 | 폴더 | 모듈 |
|---|---|---|
| `$YCLAUDE` | `src/` | 루트 (오브젝트 없음) |
| `$YCLAUDE_CA` | `src/ca/` | 모듈 간 공통 (여러 모듈이 함께 쓰는 유틸 등) |
| `$YCLAUDE_MD` | `src/md/` | 기준정보 (BP, 자재 마스터) |
| `$YCLAUDE_FI` | `src/fi/` | 재무회계 |
| `$YCLAUDE_CO` | `src/co/` | 관리회계 |
| `$YCLAUDE_TR` | `src/tr/` | 자금관리 |
| `$YCLAUDE_SD` | `src/sd/` | 영업/유통 |
| `$YCLAUDE_MM` | `src/mm/` | 자재관리 |
| `$YCLAUDE_PP` | `src/pp/` | 생산계획 |
| `$YCLAUDE_QM` | `src/qm/` | 품질관리 |
| `$YCLAUDE_PM` | `src/pm/` | 설비관리 |
| `$YCLAUDE_WM` | `src/wm/` | 창고관리 (WM/EWM) |
| `$YCLAUDE_LE` | `src/le/` | 물류실행 |
| `$YCLAUDE_PS` | `src/ps/` | 프로젝트 |
| `$YCLAUDE_HR` | `src/hr/` | 인사 (HCM) |

### 모듈 하위 패키지

| 패키지 | 업무 영역 |
|---|---|
| _(아직 없음)_ | |

## SAP로 가져오기 (abapGit)

1. abapGit 실행 → **New Online**
2. URL: `https://github.com/reveurfutur/Claude_Code_SAP.git`
3. Package: `$YCLAUDE` (없으면 생성), Folder logic: **PREFIX**
4. **Pull** → 가져올 오브젝트 확인 후 실행

## 설정 (.abapgit.xml)

- Starting folder: `/src/`
- Folder logic: `PREFIX`
- Main language: `E` (영어)
