# 이 저장소의 작업 규칙

ABAP 개발물을 abapGit 형식으로 저장하는 저장소입니다. 사용자는 한국어로 소통합니다.
SAP 시스템에는 abapGit Online repo(Folder logic PREFIX, Starting folder `/src/`)로 연결됩니다.

## 패키지 / 폴더 규칙

- 루트 패키지: `$YCLAUDE` → `src/`
- 대표 모듈 패키지: `$YCLAUDE_<모듈>` → `src/<모듈 소문자>/` (예: `$YCLAUDE_SD` → `src/sd/`)
- 모듈 하위 패키지: `$YCLAUDE_<모듈>_001`, `_002`, ... 순번 → `src/<모듈>/001/`
- 새 하위 패키지는 해당 모듈의 기존 최대 번호 + 1을 사용합니다.
- 모든 패키지는 로컬(`$`)입니다. 패키지 이름은 30자 이내, 대문자.
- 각 패키지 폴더에는 `package.devc.xml`(패키지 설명 `CTEXT` 포함)을 둡니다.
- 루트 패키지에는 데이터 엘리먼트(`YE…`)와 도메인(`YD…`)만 둡니다.
- 대표 모듈은 아래 14개로 고정입니다. 새 모듈 약어를 임의로 만들지 않습니다 (필요하면 사용자에게 확인).
  `CA`(모듈 간 공통), `MD`(기준정보), `FI`, `CO`, `TR`, `SD`, `MM`, `PP`, `QM`, `PM`, `WM`(WM/EWM), `LE`, `PS`, `HR`(HCM)
- 여러 **모듈**이 함께 쓰는 오브젝트는 `$YCLAUDE_CA`(또는 그 하위 `_CA_00X`)에 둡니다.

## 오브젝트 배치 기준

- 하위 패키지(`_00X`) = 업무 영역 하나. 예: `_SD_001` 수주, `_SD_002` 출하, `_SD_003` 대금청구 / `_MD_001` BP, `_MD_002` MM
- 대표 모듈 패키지(`_SD`, `_MD`) = 그 모듈의 **두 개 이상 하위 영역이 공통으로 쓰는** 오브젝트 (공통 클래스, 공통 메시지 클래스 `Y<모듈>_000` 등)
- 예외: 테이블·구조·테이블 타입은 한 영역에서만 쓰더라도 항상 대표 모듈 패키지에 둡니다. 데이터 엘리먼트·도메인은 항상 루트 `$YCLAUDE`에 둡니다.
- 한 영역에서만 쓰이면 해당 `_00X`에 둡니다. 다른 영역에서도 쓰게 되면 대표 모듈 패키지로 옮깁니다.
- 참조 방향: `_00X` → 대표 모듈 패키지 참조는 허용. `_00X`끼리 서로 참조 금지, 대표 모듈 패키지 → `_00X` 참조 금지.
- 하위 패키지의 번호와 업무 영역 할당은 `README.md`의 "모듈 하위 패키지" 표가 기준입니다. 오브젝트를 넣기 전에 이 표와 "헷갈리기 쉬운 경계" 표를 확인합니다.
- 기존 영역에 해당하면 그 패키지에 추가합니다. 표에 없는 새 업무 영역은 사용자에게 확인한 뒤 해당 모듈의 마지막 번호 + 1로 만들고, README 표에 한 줄 추가합니다.
- 번호는 한번 할당하면 바꾸거나 재사용하지 않습니다.

## 오브젝트 규칙

- 모든 오브젝트 이름은 `Y`로 시작합니다. 유형별 명명 규칙은 `README.md`의 "오브젝트 명명 규칙" 표를 따릅니다. 표에 아직 없는 유형은 만들기 전에 사용자에게 규칙을 확인합니다.
- 클래스: `YCL_<모듈>_<목적>` (번호 없음)
  - `<모듈>`은 14개 모듈 약어, `<목적>`은 영어 대문자 단어를 `_`로 연결 (예: `YCL_SD_ORDER_CREATE`, `YCL_CA_EXCEL_UPLOAD`)
  - 전체 30자 이내. 같은 모듈에 같은 이름이 이미 있으면 목적을 더 구체적으로 짓습니다.
  - 클래스는 모듈 약어만 이름에 넣고, 실제 위치는 배치 기준에 따라 대표 모듈 또는 `_00X` 패키지에 둡니다.
- 인터페이스: `YIF_<모듈>_<목적>`, 예외 클래스: `YCX_<모듈>_<목적>`
- 프로그램: `Y<모듈><패키지 3자리><순번 2자리>` — 대표 모듈 패키지 = `000` (예: `$YCLAUDE_MD` → `YMD00000`~`YMD00099`, `$YCLAUDE_MD_001` → `YMD00100`~`YMD00199`). 해당 패키지에 만들고, 대역 안에서 비어 있는 다음 번호를 씁니다.
  - Include: `<프로그램>_TOP`(전역), `_SCR`(선택 화면), `_C01`(ALV 로컬 클래스), `_O01`(PBO), `_I01`(PAI), `_F01`, `_F02` …(FORM, 목적별)
- 트랜잭션 코드: 프로그램 이름과 동일. 관리자용을 따로 만들면 끝에 `A` (예: `YMD00100A`)
- 폼: Smartforms `Y<모듈>SF<5자리>`, Smart Style `Y<모듈>SS<5자리>`, Adobe Form `Y<모듈>AF<5자리>`, Adobe 인터페이스 `Y<모듈>AI<5자리>` — 번호 대역은 프로그램과 동일
- DDIC
  - 데이터 엘리먼트 `YE<목적>`, 도메인 `YD<목적>` (예: `YEBUKRS`, `YDBUKRS`) → 루트 `$YCLAUDE`. 이미 같은 의미가 있으면 새로 만들지 않고 재사용합니다.
  - 테이블 `Y<모듈>T<5자리>`, 구조 `Y<모듈>S<5자리>`, 테이블 타입 `Y<모듈>TT<5자리>` → 대표 모듈 패키지, 번호는 모듈별 `00001`부터
- CDS: 기본/인터페이스 뷰 `YI_<모듈>_<목적>`, 소비 뷰 `YC_<모듈>_<목적>`, 가능하면 `DEFINE VIEW ENTITY` 사용. 구형 뷰의 SQL 뷰 이름은 `Y<모듈>V<5자리>`. DCL·메타데이터 확장은 뷰와 같은 이름.
- 메시지 클래스: 모듈 공통 `Y<모듈>_000`(대표 모듈 패키지), 영역별 `Y<모듈>_<패키지 3자리>`(해당 `_00X` 패키지, 예: `YMD_001`)
- 새 번호를 할당할 때는 저장소에서 같은 접두어의 기존 파일을 검색해 마지막 번호를 확인합니다.
- 로컬 클래스는 ALV용(이벤트 핸들러 등)으로만 사용하며 `LCL_<목적>`으로 짓습니다 (예: `LCL_ALV_EVENT`). 그 외 로직은 로컬 클래스로 만들지 않고 글로벌 클래스 `YCL_`로 만듭니다.
- 메소드: 로직 목적을 동사로 시작하는 이름으로 짓습니다. 접두어 없음 (예: `CREATE_ORDER`, `CHECK_CREDIT`)
- 함수 모듈: `YF_<모듈>_<목적>` (예: `YF_SD_ORDER_CREATE`)
- 변수·파라미터: `<범위><종류>_<이름>` — README "변수·파라미터 명명 규칙" 표를 반드시 따릅니다.
  - 범위: `L` 로컬, `G` 전역, `I`/`E`/`C`/`R` = IMPORTING/EXPORTING/CHANGING/RETURNING (메소드·함수 모듈 공통)
  - 종류: `V` 변수, `S` 구조체, `T` 내부 테이블, `C` 상수, `O` 참조(REF TO), `R` 레인지
  - TYPES: `TV_` 단일 값, `TS_` 구조체, `TT_` 테이블
  - 클래스 속성은 전역으로 보고 `G`를 씁니다 (`GV_`, `GT_`, `GO_` …).
  - 필드 심볼: 같은 규칙을 `< >` 안에 (`<LS_ITEM>`, `<LT_DATA>`)
  - 선택 화면: `PARAMETERS`는 `P_`, `SELECT-OPTIONS`는 `S_`
- 함수 그룹: `YFG_<모듈><패키지번호>_<순번 3자리>` (예: `$YCLAUDE_MD_001` → `YFG_MD001_001`). 해당 패키지에 만들고 순번은 패키지별로 001부터. 대표 모듈 패키지는 패키지번호 `000` (예: `$YCLAUDE_MD` → `YFG_MD000_001`).
- FORM: 사용합니다. 이름은 로직 목적(동사로 시작), 목적 단위로 묶어 배치합니다.
  - 파라미터: `USING` → `P` + 종류 글자 (`PV_`, `PS_`, `PT_`, `PO_`, `PR_`), `CHANGING` → `C` + 종류 글자 (`CV_`, `CS_`, `CT_`, `CO_`, `CR_`)
  - 선택 화면 `P_`와 겹치지 않도록 USING/CHANGING 파라미터는 반드시 종류 글자를 붙입니다.
  - `TABLES`는 사용하지 않습니다 (변경 여부가 드러나지 않음). 읽기는 `USING`(`PT_`), 변경은 `CHANGING`으로 넘깁니다.
- 파일은 abapGit 직렬화 형식을 따릅니다: `<이름 소문자>.<유형>.abap` + `<이름 소문자>.<유형>.xml`
  (예: `ycl_sd_order_create.clas.abap`, `ycl_sd_order_create.clas.xml`)
- 원본 언어는 `E`입니다. XML 메타데이터의 언어 키도 `E`로 맞춥니다.
- 텍스트 요소, 메시지 등 화면 문구는 영어로 작성합니다.

## 공통 오브젝트

- 상수는 프로그램에 새로 선언하기 전에 `YIF_CA_CONSTANTS`(`src/ca/`)에 있는지 확인하고 있으면 사용합니다 (`yif_ca_constants=>gc_...`).
- 화면/ALV 리포트 프로그램은 `REPORT` 바로 다음에 `INCLUDE ycacommon.`을 넣습니다. `YCACOMMON_TOP`(공통 데이터)·`YCACOMMON_F01`(공통 FORM)에 이미 있는 것은 프로그램에서 다시 선언하지 않습니다. (현재 둘 다 비어 있음 — 작업 전 실제 내용을 확인)
- 프로그램 FORM 이름은 `CA_`로 시작하지 않습니다 (공통 FORM 전용 접두어).
- 공통 Include(`YCACOMMON*`)와 `YIF_CA_CONSTANTS`는 모든 프로그램에 영향을 주므로, 수정·추가 전에 사용자에게 확인합니다. 업무 로직은 넣지 않습니다.

## 개발 규칙

- ALV 컨테이너: 기본은 `CL_GUI_DOCKING_CONTAINER`를 사용합니다. 화면 레이아웃상 특정 영역에 배치해야 하는 등 `CL_GUI_CUSTOM_CONTAINER`가 꼭 필요한 경우에만 Custom Container를 쓰고, 그 이유를 주석과 작업 보고에 남깁니다.
- PBO의 ALV 처리: ALV를 작은 MODULE 여러 개로 쪼개지 않고 **ALV 전체(관련 메시지 포함)를 MODULE 하나**로 묶습니다. MODULE 안에서는 `PERFORM`으로 단계별 모듈화합니다. GUI STATUS/TITLE 설정은 별도 MODULE로 둡니다.
- 화면 MODULE 이름: `<목적>_<화면번호 4자리>` (예: `status_0100`, `display_alv_0100`, `user_command_0100`)
- PAI의 `BACK`, `EXIT`, `CANC` 버튼은 **EXIT COMMAND**로 처리합니다.
  - GUI STATUS에서 세 기능 코드의 기능 유형을 `E`(Exit Command)로 지정합니다.
  - `MODULE exit_<화면번호> AT EXIT-COMMAND`에서 처리하고, 나머지 기능 코드는 `user_command_<화면번호>`에서 처리합니다.
  - OK 코드 필드는 `GV_OKCODE`로 선언하고, `user_command`에서는 값을 로컬로 옮긴 뒤 바로 CLEAR합니다.

  ```abap
  PROCESS AFTER INPUT.
    MODULE exit_0100 AT EXIT-COMMAND.
    MODULE user_command_0100.

  MODULE exit_0100 INPUT.
    CASE gv_okcode.
      WHEN 'BACK' OR 'CANC'.
        LEAVE TO SCREEN 0.
      WHEN 'EXIT'.
        LEAVE PROGRAM.
    ENDCASE.
  ENDMODULE.

  MODULE user_command_0100 INPUT.
    DATA(lv_okcode) = gv_okcode.
    CLEAR gv_okcode.
    CASE lv_okcode.
      WHEN 'SAVE'.
        PERFORM save_data.
    ENDCASE.
  ENDMODULE.
  ```

  ```abap
  PROCESS BEFORE OUTPUT.
    MODULE status_0100.
    MODULE display_alv_0100.

  MODULE display_alv_0100 OUTPUT.
    IF go_docking IS INITIAL.
      PERFORM create_container.
      PERFORM create_alv.
      PERFORM set_fieldcat CHANGING gt_fieldcat.
      PERFORM set_layout   CHANGING gs_layout.
      PERFORM set_event.
      PERFORM display_alv.
    ELSE.
      PERFORM refresh_alv.
    ENDIF.
  ENDMODULE.
  ```

## 작업할 때

- 새 하위 패키지를 만들면 `<폴더>/package.devc.xml`(CTEXT: `<모듈>_<번호>: <영문 설명>`, 60자 이내)을 만들고 `README.md`의 "모듈 하위 패키지" 표에 한 줄 추가합니다.
- 요청받은 패키지 폴더만 수정합니다.
- 실제 SAP 시스템 없이 작성하므로, 생성/수정한 오브젝트 목록과 SAP에서 Pull 후 확인할 점(활성화, 문법 체크)을 마지막에 알려줍니다.

## 공개 저장소 주의

공개(public) 저장소입니다. 실제 회사 데이터, 시스템 접속 정보, 고객/거래처명 등 내부 정보를 커밋하지 않습니다.
