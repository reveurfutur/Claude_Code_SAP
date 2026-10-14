*&---------------------------------------------------------------------*
*& Include YCACOMMON_F01
*&---------------------------------------------------------------------*
*& Common FORMs. All names start with CA_ to avoid clashes with
*& program FORMs.
*&---------------------------------------------------------------------*

*&---------------------------------------------------------------------*
*& Form CA_CREATE_CONTAINER
*&---------------------------------------------------------------------*
*& Create docking container on the current screen
*&---------------------------------------------------------------------*
FORM ca_create_container.

  CREATE OBJECT go_docking
    EXPORTING
      repid     = sy-repid
      dynnr     = sy-dynnr
      side      = cl_gui_docking_container=>dock_at_left
      extension = 3000
    EXCEPTIONS
      OTHERS    = 1.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE yif_ca_constants=>gc_msgty_abort NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CA_CREATE_ALV
*&---------------------------------------------------------------------*
*& Create ALV grid in the docking container
*&---------------------------------------------------------------------*
FORM ca_create_alv.

  CREATE OBJECT go_grid
    EXPORTING
      i_parent = go_docking
    EXCEPTIONS
      OTHERS   = 1.
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE yif_ca_constants=>gc_msgty_abort NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CA_SET_FIELDCAT
*&---------------------------------------------------------------------*
*& Build field catalog from the structure of an internal table.
*& Adjust texts/columns in the program afterwards if needed.
*&---------------------------------------------------------------------*
FORM ca_set_fieldcat USING    pt_data     TYPE STANDARD TABLE
                     CHANGING ct_fieldcat TYPE lvc_t_fcat.

  DATA: lo_salv TYPE REF TO cl_salv_table,
        lo_data TYPE REF TO data.
  FIELD-SYMBOLS <lt_data> TYPE STANDARD TABLE.

  CLEAR ct_fieldcat.

  " Work on an empty copy so the caller's table is not touched
  CREATE DATA lo_data LIKE pt_data.
  ASSIGN lo_data->* TO <lt_data>.

  TRY.
      cl_salv_table=>factory(
        IMPORTING
          r_salv_table = lo_salv
        CHANGING
          t_table      = <lt_data> ).

      ct_fieldcat = cl_salv_controller_metadata=>get_lvc_fieldcatalog(
                      r_columns      = lo_salv->get_columns( )
                      r_aggregations = lo_salv->get_aggregations( ) ).
    CATCH cx_salv_msg.
      CLEAR ct_fieldcat.
  ENDTRY.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CA_SET_LAYOUT
*&---------------------------------------------------------------------*
*& Default ALV layout and variant
*&---------------------------------------------------------------------*
FORM ca_set_layout CHANGING cs_layout  TYPE lvc_s_layo
                            cs_variant TYPE disvariant.

  CLEAR: cs_layout, cs_variant.

  cs_layout-zebra      = abap_true.
  cs_layout-cwidth_opt = abap_true.
  cs_layout-sel_mode   = yif_ca_constants=>gc_alv_sel_multi.

  cs_variant-report    = sy-repid.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CA_DISPLAY_ALV
*&---------------------------------------------------------------------*
*& First display of the ALV grid
*&---------------------------------------------------------------------*
FORM ca_display_alv CHANGING ct_data TYPE STANDARD TABLE.

  go_grid->set_table_for_first_display(
    EXPORTING
      is_layout            = gs_layout
      is_variant           = gs_variant
      i_save               = yif_ca_constants=>gc_alv_save_all
      it_toolbar_excluding = gt_exclude
    CHANGING
      it_outtab            = ct_data
      it_fieldcatalog      = gt_fieldcat
    EXCEPTIONS
      OTHERS               = 1 ).
  IF sy-subrc <> 0.
    MESSAGE ID sy-msgid TYPE yif_ca_constants=>gc_msgty_success NUMBER sy-msgno
      WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4
      DISPLAY LIKE yif_ca_constants=>gc_msgty_error.
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CA_REFRESH_ALV
*&---------------------------------------------------------------------*
*& Refresh ALV keeping the current scroll position
*&---------------------------------------------------------------------*
FORM ca_refresh_alv.

  DATA ls_stable TYPE lvc_s_stbl.

  CHECK go_grid IS BOUND.

  ls_stable-row = abap_true.
  ls_stable-col = abap_true.

  go_grid->refresh_table_display(
    EXPORTING
      is_stable = ls_stable
    EXCEPTIONS
      OTHERS    = 1 ).

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CA_FREE_ALV
*&---------------------------------------------------------------------*
*& Release ALV grid and container
*&---------------------------------------------------------------------*
FORM ca_free_alv.

  IF go_grid IS BOUND.
    go_grid->free( ).
  ENDIF.
  IF go_docking IS BOUND.
    go_docking->free( ).
  ENDIF.
  CLEAR: go_grid, go_docking.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form CA_EXIT_COMMAND
*&---------------------------------------------------------------------*
*& Handle exit commands (BACK / CANC / EXIT).
*& Call from MODULE exit_<screen> AT EXIT-COMMAND.
*&---------------------------------------------------------------------*
FORM ca_exit_command USING pv_okcode TYPE sy-ucomm.

  CASE pv_okcode.
    WHEN yif_ca_constants=>gc_ucomm_back
      OR yif_ca_constants=>gc_ucomm_canc.
      PERFORM ca_free_alv.
      LEAVE TO SCREEN 0.
    WHEN yif_ca_constants=>gc_ucomm_exit.
      PERFORM ca_free_alv.
      LEAVE PROGRAM.
  ENDCASE.

ENDFORM.
