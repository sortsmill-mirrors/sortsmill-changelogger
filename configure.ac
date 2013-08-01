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

AC_ARG_ENABLE([hg],
   [AS_HELP_STRING([--disable-hg],[do not support Mercurial])],
   [HG_enabled="${enableval}"],[HG_enabled=yes])

AC_ARG_ENABLE([bzr],
   [AS_HELP_STRING([--disable-bzr],[do not support Bazaar])],
   [BZR_enabled="${enableval}"],[BZR_enabled=yes])

AC_ARG_ENABLE([git],
   [AS_HELP_STRING([--disable-git],[do not support Git])],
   [GIT_enabled="${enableval}"],[GIT_enabled=yes])

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

# FIXME: Make this reusable by putting it in
# sortsmill-autoconf-archive.
#
# StM_PATH_PROGS_CACHED_AND_PRECIOUS(variable, message, progs-to-check-for, feature-test)
# ---------------------------------------------------------------------------------------
AC_DEFUN([StM_PATH_PROGS_CACHED_AND_PRECIOUS],[
AC_ARG_VAR([$1],[$2])
# Override the cache if the precious variable $1 is set.
test -n "${$1}" && unset ac_cv_path_$1
AC_CACHE_CHECK([for $3],[ac_cv_path_$1],
   [AC_PATH_PROGS_FEATURE_CHECK([$1],[$3],[
      if test -n "${$1}"; then
         # Bypass the test if the precious variable $1 is set.
         ac_cv_path_$1="${$1}"
         ac_path_$1_found=:
      else
         # Run the test.
         $4
      fi ])])
$1="${ac_cv_path_$1}"
])

m4_define([my_m4_first],[m4_car(m4_unquote(m4_split(m4_strip($1))))])

AC_DEFUN([my_PATH_PROGS_CACHED_AND_PRECIOUS_WITH_DISABLE],[
if test x"${$1_enabled}" = xyes; then
   StM_PATH_PROGS_CACHED_AND_PRECIOUS([$1],[$2],[$3],[$4])
else
   AC_MSG_WARN(my_m4_first($3)[ disabled])
   $1=""
fi])

StM_PATH_PROGS_CACHED_AND_PRECIOUS([PERL],[Perl interpreter command],
   [perl],[
      if LC_ALL=C LANG=C ${ac_path_PERL} --version 2>&1 | \
              LC_ALL=C LANG=C ${EGREP} -q -i '^This is perl'; then
         ac_cv_path_PERL=${ac_path_PERL}
         ac_path_PERL_found=:
      fi
   ])

StM_PATH_PROGS_CACHED_AND_PRECIOUS([HELP2MAN],[GNU help2man command],
   [help2man],[
      if LC_ALL=C LANG=C ${ac_path_HELP2MAN} --version 2>&1 | \
              LC_ALL=C LANG=C ${EGREP} -q "Brendan O'Dea"; then
         ac_cv_path_HELP2MAN=${ac_path_HELP2MAN}
         ac_path_HELP2MAN_found=:
      fi
   ])
AM_CONDITIONAL([HAVE_HELP2MAN],[test x"${HELP2MAN}" != x])

my_PATH_PROGS_CACHED_AND_PRECIOUS_WITH_DISABLE([HG],[Mercurial VCS command],[hg],[
   if LC_ALL=C LANG=C ${ac_path_HG} log --help 2>&1 | \
           LC_ALL=C LANG=C ${EGREP} -q -i '^aliases: history'; then
      ac_cv_path_HG=${ac_path_HG}
      ac_path_HG_found=:
   fi ])

my_PATH_PROGS_CACHED_AND_PRECIOUS_WITH_DISABLE([BZR],[Bazaar VCS command],[bzr],[
   dnl Use m4sh quadrigraphs:  [ == @<:@   ] == @:>@
   if LC_ALL=C LANG=C ${ac_path_BZR} log --help 2>&1 | \
           LC_ALL=C LANG=C ${EGREP} -q -i '^Usage:@<:@@<:@:space:@:>@@:>@+bzr log'; then
      ac_cv_path_BZR=${ac_path_BZR}
      ac_path_BZR_found=:
   fi ])

my_PATH_PROGS_CACHED_AND_PRECIOUS_WITH_DISABLE([GIT],[Git VCS command],[git],[
   if LC_ALL=C LANG=C ${ac_path_GIT} help log 2>&1 | \
           LC_ALL=C LANG=C ${EGREP} -q -i 'Show commit logs'; then
      ac_cv_path_GIT=${ac_path_GIT}
      ac_path_GIT_found=:
   fi ])

if test -z "${HG}"; then
   AC_MSG_WARN([hg disabled or not found. Mercurial support will be left out.])
fi
if test -z "${BZR}"; then
   AC_MSG_WARN([bzr disabled or not found. Bazaar support will be left out.])
fi
if test -z "${GIT}"; then
   AC_MSG_WARN([git disabled or not found. Git support will be left out.])
   if test -z "${PERL}"; then
      AC_MSG_WARN([perl not found. Git support needs perl, so will be left out.])
      GIT=""
   fi
fi

if test -z "${HG}" -a -z "${BZR}" -a -z "${GIT}"; then
   AC_MSG_WARN([No supported version control systems enabled and found.
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
AC_CONFIG_FILES([sortsmill-changeloggerize.in])
AC_CONFIG_FILES([git-log-processor],
        [chmod +x git-log-processor])

# Bootstrap our own changeloggerization.
AC_SUBST([SORTSMILL_CHANGELOGGER],[dnl
"SORTSMILL_HG_LOG_STYLE=\"\@S|@(abs_top_srcdir)/map-cmdline.sortsmill-changelog\" dnl
SORTSMILL_GIT_LOG_PROCESSOR=\"\@S|@(abs_top_builddir)/git-log-processor\" dnl
${SHELL} \"\@S|@(top_builddir)/sortsmill-changelogger.in\""])

AC_OUTPUT

#--------------------------------------------------------------------------
