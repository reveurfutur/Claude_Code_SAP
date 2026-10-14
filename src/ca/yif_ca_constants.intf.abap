INTERFACE yif_ca_constants
  PUBLIC.

  " Message types
  CONSTANTS:
    gc_msgty_success TYPE sy-msgty VALUE 'S',
    gc_msgty_error   TYPE sy-msgty VALUE 'E',
    gc_msgty_warning TYPE sy-msgty VALUE 'W',
    gc_msgty_info    TYPE sy-msgty VALUE 'I',
    gc_msgty_abort   TYPE sy-msgty VALUE 'A'.

  " Common function codes
  CONSTANTS:
    gc_ucomm_back    TYPE sy-ucomm VALUE 'BACK',
    gc_ucomm_exit    TYPE sy-ucomm VALUE 'EXIT',
    gc_ucomm_canc    TYPE sy-ucomm VALUE 'CANC',
    gc_ucomm_save    TYPE sy-ucomm VALUE 'SAVE',
    gc_ucomm_refresh TYPE sy-ucomm VALUE 'REFRESH'.

  " ALV
  CONSTANTS:
    gc_alv_save_all  TYPE char01 VALUE 'A',
    gc_alv_sel_multi TYPE lvc_libox VALUE 'D'.

ENDINTERFACE.
