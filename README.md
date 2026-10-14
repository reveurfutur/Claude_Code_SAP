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

## 패키지 목록

| 패키지 | 설명 |
|---|---|
| `$YCLAUDE` | 루트 |

## SAP로 가져오기 (abapGit)

1. abapGit 실행 → **New Online**
2. URL: `https://github.com/reveurfutur/Claude_Code_SAP.git`
3. Package: `$YCLAUDE` (없으면 생성), Folder logic: **PREFIX**
4. **Pull** → 가져올 오브젝트 확인 후 실행

## 설정 (.abapgit.xml)

- Starting folder: `/src/`
- Folder logic: `PREFIX`
- Main language: `E` (영어)
