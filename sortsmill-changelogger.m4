# -*- autoconf -*-
#
# Copyright (C) 2013 Khaled Hosny and Barry Schwartz
#
# This file is free software; Khaled Hosny and Barry Schwartz give
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.

# StM_PROG_SORTSMILL_CHANGELOGGER
# -------------------------------
AC_DEFUN([StM_PROG_SORTSMILL_CHANGELOGGER],[
   AC_PATH_PROGS([SORTSMILL_CHANGELOGGER],[sortsmill-changelogger],[])
])
