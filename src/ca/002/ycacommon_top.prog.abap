*&---------------------------------------------------------------------*
*& Include YCACOMMON_TOP
*&---------------------------------------------------------------------*
*& Common global data for screens and ALV
*&---------------------------------------------------------------------*
DATA:
  gv_okcode   TYPE sy-ucomm,                          " Screen OK code
  go_docking  TYPE REF TO cl_gui_docking_container,   " ALV container
  go_grid     TYPE REF TO cl_gui_alv_grid,            " ALV grid
  gt_fieldcat TYPE lvc_t_fcat,                        " Field catalog
  gs_layout   TYPE lvc_s_layo,                        " Layout
  gs_variant  TYPE disvariant,                        " Layout variant
  gt_exclude  TYPE ui_functions.                      " Excluded toolbar functions
