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

include sortsmill-dist-changelog.am

ACLOCAL_AMFLAGS = -I m4 --install

aclocaldir = $(datadir)/aclocal

nodist_bin_SCRIPTS =
nodist_pkglibexec_SCRIPTS =
dist_pkgdata_DATA =
dist_aclocal_DATA =
man_MANS =
CLEANFILES =
MOSTLYCLEANFILES =

nodist_bin_SCRIPTS += sortsmill-changelogger
nodist_bin_SCRIPTS += sortsmill-changeloggerize
MOSTLYCLEANFILES += sortsmill-changelogger

nodist_pkglibexec_SCRIPTS += git-log-processor

dist_pkgdata_DATA += sortsmill-dist-changelog.am
dist_pkgdata_DATA += map-cmdline.sortsmill-changelog

dist_aclocal_DATA += m4/stm_prog_sortsmill_changelogger.m4

sortsmill-changelogger: sortsmill-changelogger.in Makefile
	$(SED) \
		-e 's|@DEFAULT_GIT_LOG_PROCESSOR@|$(pkglibexecdir)/git-log-processor|g' \
		-e 's|@DEFAULT_HG_LOG_STYLE@|$(pkgdatadir)/map-cmdline.sortsmill-changelog|g' \
		sortsmill-changelogger.in > $@-tmp
	mv $@-tmp $@
	chmod +x $@

sortsmill-changeloggerize: sortsmill-changeloggerize.in Makefile
	$(SED) \
		-e 's|@DEFAULT_DIST_CHANGELOG_AM@|$(pkgdatadir)/sortsmill-dist-changelog.am|g' \
		sortsmill-changeloggerize.in > $@-tmp
	mv $@-tmp $@
	chmod +x $@

if HAVE_HELP2MAN

man_MANS += sortsmill-changelogger.1 sortsmill-changeloggerize.1
CLEANFILES += sortsmill-changelogger.1 sortsmill-changeloggerize.1

MY_HELP2MAN = $(HELP2MAN) --no-info --output=$@				\
				--help-option='-h' --version-option='-V'	\
				--source='Sorts Mill'

sortsmill-changelogger.1: sortsmill-changelogger
	$(MY_HELP2MAN) --name='Sorts Mill Changelogger'		\
		./sortsmill-changelogger

sortsmill-changeloggerize.1: sortsmill-changelogger
	$(MY_HELP2MAN) --name='Sorts Mill Changeloggerize'	\
		./sortsmill-changeloggerize

endif HAVE_HELP2MAN

#--------------------------------------------------------------------------
#
# ‘make readme’ regenerates the README file.
#
# This target is meant for developers.
#
# FIXME: This snippet should be made easily reusable.

.PHONY: readme

readme: sortsmill-changelogger.1
#	Turn off justification.
	echo '.na' >  README.nroff
	echo '.de ad' >> README.nroff
	echo '..' >> README.nroff
#	Turn off hyphenation.
	echo '.nh' >> README.nroff
	echo '.de hy' >> README.nroff
	echo '..' >> README.nroff
#	Copy the manpage source.
	cat sortsmill-changelogger.1 >> README.nroff
#	Generate the page.
	groff -man -Tascii -P -c -P -b -P -u README.nroff > $(srcdir)/README

MOSTLYCLEANFILES += README.nroff

#--------------------------------------------------------------------------
