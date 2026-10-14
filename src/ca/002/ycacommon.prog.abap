*&---------------------------------------------------------------------*
*& Include YCACOMMON
*&---------------------------------------------------------------------*
*& Common include for report programs (ALV on docking container).
*& Put it right after the REPORT statement, before program includes:
*&   REPORT ysd00100.
*&   INCLUDE ycacommon.
*&   INCLUDE ysd00100_top.
*&
*& Screen OK code field must be named GV_OKCODE.
*& Changing this include affects every program that uses it.
*&---------------------------------------------------------------------*
INCLUDE ycacommon_top.  " Common global data
INCLUDE ycacommon_f01.  " Common FORMs (CA_*)
