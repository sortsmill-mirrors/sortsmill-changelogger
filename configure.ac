#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

# Copyright (C) 2013 Khaled Hosny and Barry Schwartz
# This file is part of Sorts Mill Changelogger.
# 
# Sorts Mill Changelogger is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
# 
# Sorts Mill Changelogger is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/>.

AC_PREREQ([2.69])
AC_INIT([Sorts Mill Changelogger],
        [1.0.0],
        [http://bitbucket.org/sortsmill/sortsmill-changelogger/issues],
        [sortsmill-changelogger],
        [http://bitbucket.org/sortsmill/sortsmill-changelogger])

AC_CONFIG_SRCDIR([sortsmill-changelogger.in.in])

AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_AUX_DIR([config])        dnl Where things like install-sh go.
AC_CANONICAL_BUILD                 dnl On what platform are we compiling?
AC_CANONICAL_HOST                  dnl For what platform are we compiling?
AC_USE_SYSTEM_EXTENSIONS           dnl Define such macros as _GNU_SOURCE.

AM_INIT_AUTOMAKE([1.11 dist-xz -Wall -Wno-portability -Werror])

# I am going to enable silent-rules by default, so builders are
# more likely to see warnings. Use --disable-silent-rules or "make
# V=1" if you need to see the rules.
AM_SILENT_RULES([yes])

VERSION_MAJOR=`AS_ECHO(["${PACKAGE_VERSION}"]) | sed -e 's/^\([[0-9]][[0-9]]*\).*/\1/'`
VERSION_MINOR=`AS_ECHO(["${PACKAGE_VERSION}"]) | sed -e 's/^[[0-9]][[0-9]]*\.\([[0-9]][[0-9]]*\).*/\1/'`
VERSION_PATCH=`AS_ECHO(["${PACKAGE_VERSION}"]) | sed -e 's/^[[0-9]][[0-9]]*\.[[0-9]][[0-9]]*\.\([[0-9]][[0-9]]*\).*/\1/'`
VERSION_EXTRA=`AS_ECHO(["${PACKAGE_VERSION}"]) | sed -e 's/^[[0-9]][[0-9]]*\.[[0-9]][[0-9]]*\.[[0-9]][[0-9]]*\(.*\)/\1/' \
                                                     -e 's/^_//'`
VERSION_EXTRA_SHORT=`AS_ECHO(["${VERSION_EXTRA}"]) | sed -e 's/alpha/a/' -e 's/beta/b/'`
PACKAGE_VERSION_SHORT=`AS_ECHO(["${VERSION_MAJOR}.${VERSION_MINOR}.${VERSION_PATCH}${VERSION_EXTRA_SHORT}"])`
AC_SUBST([VERSION_MAJOR])
AC_SUBST([VERSION_MINOR])
AC_SUBST([VERSION_PATCH])
AC_SUBST([VERSION_EXTRA])
AC_SUBST([VERSION_EXTRA_SHORT])
AC_SUBST([PACKAGE_VERSION_SHORT])

#--------------------------------------------------------------------------
#
# Checks for programs.

AC_PROG_AWK
AC_PROG_GREP
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P
AC_PROG_SED

AC_PATH_PROGS([HELP2MAN],[help2man],[])
if test x"${HELP2MAN}" = x; then
   AC_MSG_WARN([GNU help2man not found. No manual page will be made.])
fi
AM_CONDITIONAL([HAVE_HELP2MAN],[test x"${HELP2MAN}" != x])

AC_CACHE_CHECK([for `hg log'],
   [ac_cv_path_HG],[
   AC_PATH_PROGS_FEATURE_CHECK([HG],[hg],[
      if LC_ALL=C LANG=C ${ac_path_HG} log --help 2>&1 | \
              LC_ALL=C LANG=C ${EGREP} -q -i '^aliases: history'; then
         ac_cv_path_HG=${ac_path_HG}
         ac_path_HG_found=:
      fi])])

AC_CACHE_CHECK([for `bzr log'],
   [ac_cv_path_BZR],[
   AC_PATH_PROGS_FEATURE_CHECK([BZR],[bzr],[
      dnl Use m4sh quadrigraphs:  [ == @<:@   ] == @:>@
      if LC_ALL=C LANG=C ${ac_path_BZR} log --help 2>&1 | \
              LC_ALL=C LANG=C ${EGREP} -q -i '^Usage:@<:@@<:@:space:@:>@@:>@+bzr log'; then
         ac_cv_path_BZR=${ac_path_BZR}
         ac_path_BZR_found=:
      fi])])

AC_CACHE_CHECK([for `git log'],
   [ac_cv_path_GIT],[
   AC_PATH_PROGS_FEATURE_CHECK([GIT],[git],[
      if LC_ALL=C LANG=C ${ac_path_GIT} help log 2>&1 | \
              LC_ALL=C LANG=C ${EGREP} -q -i 'Show commit logs'; then
         ac_cv_path_GIT=${ac_path_GIT}
         ac_path_GIT_found=:
      fi])])

if test -z "${ac_cv_path_HG}"; then
   AC_MSG_WARN([`hg log' not found. Hg support will be left out.])
   HG=""
   HG_LOG=""
else
   HG="${ac_cv_path_HG}"
   HG_LOG="${HG} log"
fi
AC_SUBST([HG])
AC_SUBST([HG_LOG])

if test -z "${ac_cv_path_BZR}"; then
   AC_MSG_WARN([`bzr log' not found. Bzr support will be left out.])
   BZR=""
   BZR_LOG=""
else
   BZR="${ac_cv_path_BZR}"
   BZR_LOG="${BZR} log"
fi
AC_SUBST([BZR])
AC_SUBST([BZR_LOG])

if test -z "${ac_cv_path_GIT}"; then
   AC_MSG_WARN([`git log' not found. Git support will be left out.])
   GIT=""
   GIT_LOG=""
else
   GIT="${ac_cv_path_GIT}"
   GIT_LOG="${GIT} log"
fi
AC_SUBST([GIT])
AC_SUBST([GIT_LOG])

if test -z "${HG}" -a -z "${BZR}" -a -z "${GIT}"; then
   AC_MSG_WARN([No supported version control systems found.
${PACKAGE} will not be able to generate ChangeLogs.])
fi

#--------------------------------------------------------------------------
#
# Checks for libraries.

#--------------------------------------------------------------------------
#
# Checks for header files.

#--------------------------------------------------------------------------
#
# Checks for typedefs, structures, and compiler characteristics.

#--------------------------------------------------------------------------
#
# Checks for library functions.

#--------------------------------------------------------------------------

AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([sortsmill-changelogger.in])
AC_CONFIG_FILES([sortsmill-changeloggerize],
        [chmod +x sortsmill-changeloggerize])

# Bootstrap our own changeloggerization.
AC_CONFIG_COMMANDS([config/sortsmill-dist-changelog.am],[
   ${SHELL} sortsmill-changeloggerize.in -d config
])
AC_SUBST([SORTSMILL_CHANGELOGGER],["\@S|@(top_builddir)/sortsmill-changelogger"])

AC_OUTPUT

#--------------------------------------------------------------------------
