# -*- tab-width: 4 -*-

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

ACLOCAL_AMFLAGS = -I m4 --install

# Bootstrapped changeloggerization.
dist-hook: dist-changelog
@dist_changelog_rules@

nodist_bin_SCRIPTS =
nodist_pkglibexec_SCRIPTS =
dist_pkgdata_DATA =
man_MANS =
CLEANFILES =
MOSTLYCLEANFILES =

nodist_bin_SCRIPTS += sortsmill-changelogger
MOSTLYCLEANFILES += sortsmill-changelogger

nodist_pkglibexec_SCRIPTS += git-log-processor
dist_pkgdata_DATA += map-cmdline.sortsmill-changelog

sortsmill-changelogger: sortsmill-changelogger.in Makefile
	$(SED) \
		-e 's|@DEFAULT_GIT_LOG_PROCESSOR@|$(pkglibexecdir)/git-log-processor|g' \
		-e 's|@DEFAULT_HG_LOG_STYLE@|$(pkgdatadir)/map-cmdline.sortsmill-changelog|g' \
		sortsmill-changelogger.in > $@-tmp
	mv $@-tmp $@
	chmod +x $@

if HAVE_HELP2MAN

man_MANS += sortsmill-changelogger.1
CLEANFILES += sortsmill-changelogger.1

MY_HELP2MAN = $(HELP2MAN) --no-info --output=$@				\
				--help-option='-h' --version-option='-V'	\
				--source='Sorts Mill'

sortsmill-changelogger.1: sortsmill-changelogger
	$(MY_HELP2MAN) --name='Sorts Mill Changelogger'		\
		./sortsmill-changelogger

endif HAVE_HELP2MAN

#--------------------------------------------------------------------------
#
# ‘make readme’ regenerates the README file. This target is meant for
# developers and requires groff.

PACKAGE_README = $(srcdir)/README
@make_readme@

#--------------------------------------------------------------------------
