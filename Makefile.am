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

ACLOCAL_AMFLAGS = -I m4

aclocaldir = $(datadir)/aclocal

nodist_bin_SCRIPTS =
dist_pkgdata_DATA =
dist_aclocal_DATA =
man_MANS =
EXTRA_DIST =
CLEANFILES =
MOSTLYCLEANFILES =

EXTRA_DIST += m4/gnulib-cache.m4

nodist_bin_SCRIPTS += sortsmill-changelogger
dist_pkgdata_DATA += config/gitlog-to-changelog
#dist_aclocal_DATA += sortsmill-changelogger.m4
MOSTLYCLEANFILES += sortsmill-changelogger

sortsmill-changelogger: sortsmill-changelogger.in
	$(SED) -e 's|@GITLOG_TO_CHANGELOG@|$(pkgdatadir)/gitlog-to-changelog|g' $< > $@-tmp
	mv $@-tmp $@
	chmod +x $@

if HAVE_HELP2MAN

man_MANS += sortsmill-changelogger.1
CLEANFILES += sortsmill-changelogger.1

sortsmill-changelogger.1: sortsmill-changelogger
	$(HELP2MAN) --no-info --output=$@					\
		--help-option='-h' --version-option='-V'		\
		--name='Sorts Mill Changelogger'				\
	 	--source='Sorts Mill' ./sortsmill-changelogger

endif HAVE_HELP2MAN

#--------------------------------------------------------------------------
#
# Make a ChangeLog automatically when doing a `make dist'.
#
# FIXME: This snippet should be made easily reusable.

dist-hook: dist-changelog

.PHONY: dist-changelog

dist-changelog: sortsmill-changelogger
	@if ./sortsmill-changelogger -C $(top_srcdir) > ChangeLog-tmp; then \
		mv -f ChangeLog-tmp $(distdir)/ChangeLog; \
	else \
		echo "*************************************************************************"; \
		echo "*****  I could not automatically remake the ChangeLog,              *****"; \
		echo "*****  because the sources are not in a compatible VCS repository.  *****"; \
		echo "*****                                                               *****"; \
		echo "*****  Whether that is a problem is your decision entirely. :)      *****"; \
		echo "*****                                                               *****"; \
		echo "*****  (This message is expected to appear at some point during     *****"; \
		echo "*****  a \`make distcheck'.)                                         *****"; \
		echo "*************************************************************************"; \
	fi

CLEANFILES += ChangeLog-tmp

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
