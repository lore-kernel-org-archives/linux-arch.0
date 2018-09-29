From: Aleksa Sarai <cyphar@cyphar.com>
Subject: [PATCH 3/3] selftests: vfs: add AT_* path resolution tests
Date: Sat, 29 Sep 2018 23:15:34 +1000
Message-ID: <20180929131534.24472-2-cyphar@cyphar.com>
References: <20180929103453.12025-1-cyphar@cyphar.com>
 <20180929131534.24472-1-cyphar@cyphar.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180929131534.24472-1-cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, "J. Bruce Fields" <bfields@fieldses.org>, Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Andy Lutomirski <luto@kernel.org>, Christian Brauner <christian@brauner.io>, Eric Biederman <ebiederm@xmission.com>, Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, dev@opencontainers.org, containers@lists.linux-foundation.org, Aleksa Sarai <cyphar@cyphar.com>
List-Id: linux-arch.vger.kernel.org

With the addition of so many new scoping flags, it's necessary to have
some sort of validation that they really work. There were no vfs
self-tests in the past, so this also includes a basic framework that
future VFS tests can use.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/vfs/.gitignore        |   1 +
 tools/testing/selftests/vfs/Makefile          |  13 ++
 tools/testing/selftests/vfs/at_flags.h        |  40 +++++
 tools/testing/selftests/vfs/common.sh         |  37 +++++
 .../selftests/vfs/tests/0001_at_beneath.sh    |  72 ++++++++
 .../selftests/vfs/tests/0002_at_xdev.sh       |  54 ++++++
 .../vfs/tests/0003_at_no_proclinks.sh         |  50 ++++++
 .../vfs/tests/0004_at_no_symlinks.sh          |  49 ++++++
 .../selftests/vfs/tests/0005_at_this_root.sh  |  66 ++++++++
 tools/testing/selftests/vfs/vfs_helper.c      | 154 ++++++++++++++++++
 11 files changed, 537 insertions(+)
 create mode 100644 tools/testing/selftests/vfs/.gitignore
 create mode 100644 tools/testing/selftests/vfs/Makefile
 create mode 100644 tools/testing/selftests/vfs/at_flags.h
 create mode 100644 tools/testing/selftests/vfs/common.sh
 create mode 100755 tools/testing/selftests/vfs/tests/0001_at_beneath.sh
 create mode 100755 tools/testing/selftests/vfs/tests/0002_at_xdev.sh
 create mode 100755 tools/testing/selftests/vfs/tests/0003_at_no_proclinks.sh
 create mode 100755 tools/testing/selftests/vfs/tests/0004_at_no_symlinks.sh
 create mode 100755 tools/testing/selftests/vfs/tests/0005_at_this_root.sh
 create mode 100644 tools/testing/selftests/vfs/vfs_helper.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f1fe492c8e17..6f814e49071f 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -43,6 +43,7 @@ ifneq (1, $(quicktest))
 TARGETS += timers
 endif
 TARGETS += user
+TARGETS += vfs
 TARGETS += vm
 TARGETS += x86
 TARGETS += zram
diff --git a/tools/testing/selftests/vfs/.gitignore b/tools/testing/selftests/vfs/.gitignore
new file mode 100644
index 000000000000..c57ebcba14c0
--- /dev/null
+++ b/tools/testing/selftests/vfs/.gitignore
@@ -0,0 +1 @@
+/vfs_helper
diff --git a/tools/testing/selftests/vfs/Makefile b/tools/testing/selftests/vfs/Makefile
new file mode 100644
index 000000000000..8ca3cef43dc3
--- /dev/null
+++ b/tools/testing/selftests/vfs/Makefile
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Author: Aleksa Sarai <cyphar@cyphar.com>
+# Copyright (C) 2018 SUSE LLC.
+
+# Makefile for mount selftests.
+CFLAGS = -Wall \
+         -O2 \
+         -I../../../../usr/include/
+
+TEST_PROGS := $(wildcard tests/*.sh)
+TEST_GEN_FILES := vfs_helper
+
+include ../lib.mk
diff --git a/tools/testing/selftests/vfs/at_flags.h b/tools/testing/selftests/vfs/at_flags.h
new file mode 100644
index 000000000000..a8ca8f689753
--- /dev/null
+++ b/tools/testing/selftests/vfs/at_flags.h
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2018 SUSE LLC.
+ */
+
+#ifndef __AT_FLAGS_H__
+#define __AT_FLAGS_H__
+
+/* These come from <uapi/asm-generic/linux/fcntl.h> */
+#ifndef O_BENEATH
+# define O_BENEATH	00040000000
+# define O_XDEV		00100000000
+# define O_NOPROCLINKS	00200000000
+# define O_NOSYMLINKS	01000000000
+# define O_THISROOT	02000000000
+#endif
+#ifndef AT_BENEATH
+# define AT_BENEATH		0x8000
+# define AT_XDEV		0x10000
+# define AT_NO_PROCLINKS	0x20000
+# define AT_NO_SYMLINKS		0x40000
+# define AT_THIS_ROOT		0x80000
+#endif
+
+struct flag {
+	const char *name;
+	unsigned int at_flag, open_flag;
+};
+
+struct flag AT_FLAGS[] = {
+	{ .name = "beneath",	  .at_flag = AT_BENEATH,      .open_flag = O_BENEATH },
+	{ .name = "xdev",	  .at_flag = AT_XDEV,	      .open_flag = O_XDEV },
+	{ .name = "no_proclinks", .at_flag = AT_NO_PROCLINKS, .open_flag = O_NOPROCLINKS },
+	{ .name = "no_symlinks",  .at_flag = AT_NO_SYMLINKS,  .open_flag = O_NOSYMLINKS },
+	{ .name = "this_root",	  .at_flag = AT_THIS_ROOT, .open_flag = O_THISROOT },
+	{ 0 }, /* terminate */
+};
+
+#endif /* !defined(__AT_FLAGS_H__) */
diff --git a/tools/testing/selftests/vfs/common.sh b/tools/testing/selftests/vfs/common.sh
new file mode 100644
index 000000000000..82ac8ad2a5a5
--- /dev/null
+++ b/tools/testing/selftests/vfs/common.sh
@@ -0,0 +1,37 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Author: Aleksa Sarai <cyphar@cyphar.com>
+# Copyright (C) 2018 SUSE LLC.
+
+set -e -o pipefail
+
+tmpdir="$(mktemp -d --tmpdir vfs_test.XXXXXX)"
+trap "rm -rf $tmpdir" EXIT
+
+root="$tmpdir/root"
+mkdir -p "$root"
+
+function fail() {
+	echo "# not ok" "$@"
+	exit 1
+}
+
+ksft_skip=4
+function skip() {
+	echo "# skip" "$@"
+	exit "$ksft_skip"
+}
+
+function run() {
+	local old_flags="$-"
+	set +eET
+	output="$("$@" 2>&1)"
+	status="$?"
+	set "-$old_flags"
+}
+
+testrootdir="$(readlink -f "$(dirname "$BASH_SOURCE")")"
+function vfs_helper() {
+	run "$testrootdir/vfs_helper" "$@"
+}
+vfs_ops=( "open" "stat" "lstat" )
diff --git a/tools/testing/selftests/vfs/tests/0001_at_beneath.sh b/tools/testing/selftests/vfs/tests/0001_at_beneath.sh
new file mode 100755
index 000000000000..9a03b0953032
--- /dev/null
+++ b/tools/testing/selftests/vfs/tests/0001_at_beneath.sh
@@ -0,0 +1,72 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Author: Aleksa Sarai <cyphar@cyphar.com>
+# Copyright (C) 2018 SUSE LLC.
+
+sourcedir="$(readlink -f "$(dirname "$BASH_SOURCE")")"
+source "$sourcedir/../common.sh"
+
+touch "$root/inside"
+ln -s / "$root/rootlink"
+ln -s .. "$root/dotdot"
+ln -s "/../../../../../../$root" "$root/badlink"
+
+mkdir -p "$root/subdir"
+ln -s ../inside "$root/subdir/dotdotinside"
+ln -s ../subdir "$root/subdir/dotdotsubdir"
+ln -s subdir "$root/subdirlink"
+ln -s ../subdirlink/../../inside "$root/subdir/complexlink"
+
+for op in "${vfs_ops[@]}"
+do
+	vfs_helper -o "$op" -F beneath -d "$root" ..
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op beneath [/root/].."
+
+	vfs_helper -o "$op" -F beneath -d "$root" ../root
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op beneath [/root/]../root"
+
+	vfs_helper -o "$op" -F beneath -d "$root" dotdot/root
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op beneath [/root/]dotdot(=..)/root"
+
+	vfs_helper -o "$op" -F beneath -d "$root" "$root"
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op beneath [/root/]/root"
+
+	vfs_helper -o "$op" -F beneath -d "$root" rootlink
+	if [[ "$op" == "lstat" ]]
+	then
+		[[ "$status" = 0 ]] || fail "$op beneath [/root/]rootlink(=/)"
+	else
+		[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op beneath [/root/]rootlink(=/)"
+	fi
+
+	vfs_helper -o "$op" -F beneath -d "$root" rootlink/
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op beneath [/root/]rootlink(=/)/"
+
+	vfs_helper -o "$op" -F beneath -d "$root" "rootlink/$root"
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op beneath [/root/]rootlink(=/)/root"
+
+	vfs_helper -o "$op" -F beneath -d "$root" badlink
+	if [[ "$op" == "lstat" ]]
+	then
+		[[ "$status" = 0 ]] || fail "$op beneath [/root/]badlink(=/../.../root)"
+	else
+		[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op beneath [/root/]badlink(=/../.../root)"
+	fi
+
+	vfs_helper -o "$op" -F beneath -d "$root" subdir/../inside
+	[[ "$status" -eq 0 ]] || fail "$op beneath [/root/]subdir/../inside"
+
+	vfs_helper -o "$op" -F beneath -d "$root" subdir/dotdotinside
+	[[ "$status" -eq 0 ]] || fail "$op beneath [/root/]subdir/dotdotinside(=../inside)"
+
+	vfs_helper -o "$op" -F beneath -d "$root" subdir/dotdotsubdir/
+	[[ "$status" -eq 0 ]] || fail "$op beneath [/root/]subdir/dotdotsubdir(=../subdir)/"
+
+	vfs_helper -o "$op" -F beneath -d "$root" subdir/complexlink
+	if [[ "$op" == "lstat" ]]
+	then
+		[[ "$status" = 0 ]] || fail "$op beneath [/root/]complexlink(=../subdirlink/../../inside)"
+	else
+		[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op beneath [/root/]complexlink(=../subdirlink/../../inside)"
+	fi
+done
diff --git a/tools/testing/selftests/vfs/tests/0002_at_xdev.sh b/tools/testing/selftests/vfs/tests/0002_at_xdev.sh
new file mode 100755
index 000000000000..06be58a8ffe7
--- /dev/null
+++ b/tools/testing/selftests/vfs/tests/0002_at_xdev.sh
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Author: Aleksa Sarai <cyphar@cyphar.com>
+# Copyright (C) 2018 SUSE LLC.
+
+sourcedir="$(readlink -f "$(dirname "$BASH_SOURCE")")"
+source "$sourcedir/../common.sh"
+
+( mountpoint -q "/tmp" ) || skip "/tmp is not a mountpoint"
+
+touch /tmp/foo
+
+ln -s /tmp "$root/link_tmp"
+
+for op in "${vfs_ops[@]}"
+do
+	vfs_helper -o "$op" -F xdev -d / tmp/
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op xdev [/]tmp/"
+
+	vfs_helper -o "$op" -F xdev -d / tmp/foo
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op xdev [/]tmp/foo"
+
+	vfs_helper -o "$op" -F xdev -d "$root" /tmp
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op xdev [/root/]/tmp"
+
+	vfs_helper -o "$op" -F xdev -d "$root" /tmp/
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op xdev [/root/]/tmp/"
+
+	vfs_helper -o "$op" -F xdev -d "$root" /tmp/foo
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op xdev [/root/]/tmp/foo"
+
+	vfs_helper -o "$op" -F xdev -d /tmp foo
+	[[ "$status" = 0 ]] || fail "$op xdev [/tmp/]foo"
+
+	vfs_helper -o "$op" -F xdev -d /tmp ..
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op xdev [/tmp/].."
+
+	vfs_helper -o "$op" -F xdev -d /tmp ../
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op xdev [/tmp/]../"
+
+	vfs_helper -o "$op" -F xdev -d /tmp ../tmp
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op xdev [/tmp/]../tmp"
+
+	vfs_helper -o "$op" -F xdev -d "$root" link_tmp
+	if [[ "$op" == "lstat" ]]
+	then
+		[[ "$status" = 0 ]] || fail "$op xdev [/root/]link_tmp(=/tmp)"
+	else
+		[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op xdev [/root/]link_tmp(=/tmp)"
+	fi
+
+	vfs_helper -o "$op" -F xdev -d "$root" link_tmp/
+	[[ "$(errno "$status")" =~ "EXDEV "* ]] || fail "$op xdev [/root/]link_tmp(=/tmp)/"
+done
diff --git a/tools/testing/selftests/vfs/tests/0003_at_no_proclinks.sh b/tools/testing/selftests/vfs/tests/0003_at_no_proclinks.sh
new file mode 100755
index 000000000000..41d9655a1e46
--- /dev/null
+++ b/tools/testing/selftests/vfs/tests/0003_at_no_proclinks.sh
@@ -0,0 +1,50 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Author: Aleksa Sarai <cyphar@cyphar.com>
+# Copyright (C) 2018 SUSE LLC.
+
+sourcedir="$(readlink -f "$(dirname "$BASH_SOURCE")")"
+source "$sourcedir/../common.sh"
+
+[ -e "/proc/$$/cwd" ] || skip "/proc/$$/cwd doesn't exist"
+
+ln -s / "$root/testlink"
+
+for op in "${vfs_ops[@]}"
+do
+	for flags in {no_proclinks,no_symlinks,"no_proclinks,no_symlinks"}
+	do
+		vfs_helper -o "$op" -F "$flags" "/proc/$$/stat"
+		[[ "$status" = 0 ]] || fail "$op $flags /proc/$$/stat"
+
+		vfs_helper -o "$op" -F "$flags" "/proc/$$/cwd"
+		if [[ "$op" == "lstat" ]]
+		then
+			[[ "$status" = 0 ]] || fail "$op $flags /proc/$$/cwd"
+		else
+			[[ "$(errno "$status")" =~ "ELOOP "* ]] || fail "$op $flags /proc/$$/cwd"
+		fi
+
+		vfs_helper -o "$op" -F "$flags" -d "$root" "testlink/"
+		if [[ "$flags" == "no_proclinks" ]]
+		then
+			[[ "$status" = 0 ]] || fail "$op $flags [/root/]testlink/"
+		else
+			[[ "$(errno "$status")" =~ "ELOOP "* ]] || fail "$op $flags [/root/]testlink/"
+		fi
+
+		vfs_helper -o "$op" -F "$flags" "/proc/$$/cwd/"
+		[[ "$(errno "$status")" =~ "ELOOP "* ]] || fail "$op $flags /proc/$$/cwd/"
+
+		vfs_helper -o "$op" -F "$flags" "/proc/$$/cwd/$BASH_SOURCE"
+		[[ "$(errno "$status")" =~ "ELOOP "* ]] || fail "$op $flags /proc/$$/cwd/$BASH_SOURCE"
+
+		vfs_helper -o "$op" -F "$flags" -d "/proc/self" cwd
+		if [[ "$op" == "lstat" ]]
+		then
+			[[ "$status" = 0 ]] || fail "$op $flags [/proc/self/]cwd"
+		else
+			[[ "$(errno "$status")" =~ "ELOOP "* ]] || fail "$op $flags [/proc/self]/cwd"
+		fi
+	done
+done
diff --git a/tools/testing/selftests/vfs/tests/0004_at_no_symlinks.sh b/tools/testing/selftests/vfs/tests/0004_at_no_symlinks.sh
new file mode 100755
index 000000000000..f7ec7e37f06a
--- /dev/null
+++ b/tools/testing/selftests/vfs/tests/0004_at_no_symlinks.sh
@@ -0,0 +1,49 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Author: Aleksa Sarai <cyphar@cyphar.com>
+# Copyright (C) 2018 SUSE LLC.
+
+sourcedir="$(readlink -f "$(dirname "$BASH_SOURCE")")"
+source "$sourcedir/../common.sh"
+
+mkdir -p "$root/dir"
+touch "$root/foo"
+
+ln -s . "$root/link_dot"
+ln -s .. "$root/link_dotdot"
+ln -s foo "$root/link_foo"
+
+for op in "${vfs_ops[@]}"
+do
+	vfs_helper -o "$op" -F no_symlinks -d "$root" foo
+	[[ "$status" = 0 ]] || fail "$op no_symlinks [/root/]foo"
+
+	vfs_helper -o "$op" -F no_symlinks -d "$root" ../root/foo
+	[[ "$status" = 0 ]] || fail "$op no_symlinks [/root/]../root/foo"
+
+	vfs_helper -o "$op" -F no_symlinks -d "$root" link_foo
+	if [[ "$op" == "lstat" ]]
+	then
+		[[ "$status" = 0 ]] || fail "$op no_symlinks [/root/]link_foo(=foo)"
+	else
+		[[ "$(errno "$status")" =~ "ELOOP "* ]] || fail "$op no_symlinks [/root/]link_foo(=foo)"
+	fi
+
+	vfs_helper -o "$op" -F no_proclinks -d "$root" link_foo
+	[[ "$status" = 0 ]] || fail "$op no_proclinks [/root/]link_foo(=foo)"
+
+	vfs_helper -o "$op" -F no_symlinks -d "$root" link_dotdot/
+	[[ "$(errno "$status")" =~ "ELOOP "* ]] || fail "$op no_symlinks [/root/]link_dotdot(=..)/"
+
+	vfs_helper -o "$op" -F no_proclinks -d "$root" link_dotdot/
+	[[ "$status" = 0 ]] || fail "$op no_proclinks [/root/]link_dotdot(=..)/"
+
+	vfs_helper -o "$op" -F no_symlinks -d "$root" link_dot/dir
+	[[ "$(errno "$status")" =~ "ELOOP "* ]] || fail "$op no_symlinks [/root/]link_dot(=.)/dir"
+
+	vfs_helper -o "$op" -F no_proclinks -d "$root" link_dot/dir
+	[[ "$status" = 0 ]] || fail "$op no_proclinks [/root/]link_dot(=.)/dir"
+
+	vfs_helper -o "$op" -F no_symlinks -d "$root" ../root/link_dot/link_dotdot/root/dir
+	[[ "$(errno "$status")" =~ "ELOOP "* ]] || fail "$op no_symlinks [/root/]../root/link_dot(=.)/link_dotdot(=..)/root/dir"
+done
diff --git a/tools/testing/selftests/vfs/tests/0005_at_this_root.sh b/tools/testing/selftests/vfs/tests/0005_at_this_root.sh
new file mode 100755
index 000000000000..aba23c28a7b7
--- /dev/null
+++ b/tools/testing/selftests/vfs/tests/0005_at_this_root.sh
@@ -0,0 +1,66 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Author: Aleksa Sarai <cyphar@cyphar.com>
+# Copyright (C) 2018 SUSE LLC.
+
+sourcedir="$(readlink -f "$(dirname "$BASH_SOURCE")")"
+source "$sourcedir/../common.sh"
+
+mkdir -p "$root/var" "$root/etc" "$root/usr/bin" "$root/usr/local/bin"
+ln -s bash "$root/usr/bin/sh"
+ln -s ../../bin/bash "$root/usr/local/bin/bash"
+ln -s /bin/sh "$root/usr/local/bin/sh"
+ln -s ../bin3 "$root/var/bin"
+ln -s /usr/bin "$root/bin"
+ln -s /usr/local/bin "$root/bin4"
+ln -s ../../../../../../../../../bin "$root/bin2"
+ln -s /../../../../../../../../../bin "$root/bin3"
+touch "$root/etc/passwd" "$root/usr/bin/bash"
+
+# How should each path be mapped to a host path, in the form
+# 'path:hostpath[:hostpath_trailing]'. Everything is assumed to be ${root}
+# prefixed.
+host_mappings=(
+	# Basic paths.
+	"..:."
+	"/:."
+	"/../../../../../../:."
+	"../var/../../../../../etc/passwd:etc/passwd"
+	"/var/../../../../../etc/passwd:etc/passwd"
+	"/../../../../../../var/../../../../../etc/passwd:etc/passwd"
+	"etc/passwd:etc/passwd"
+	"/etc/passwd:etc/passwd"
+
+	# Basic symlink paths.
+	"/bin/bash:usr/bin/bash"
+	"/bin/sh:usr/bin/bash:usr/bin/sh"
+	"/bin2/bash:usr/bin/bash"
+	"/bin2/sh:usr/bin/bash:usr/bin/sh"
+	"/bin3/sh:usr/bin/bash:usr/bin/sh"
+	"/bin3/bash:usr/bin/bash"
+
+	# More complicated symlink paths.
+	"/bin4/../../local/bin/bash:usr/bin/bash:usr/local/bin/bash"
+	"/bin4/../../local/bin/sh:usr/bin/bash:usr/local/bin/sh"
+	"/bin4/../../../../../../../../../../usr/local/bin/bash:usr/bin/bash:usr/local/bin/bash"
+	"/bin4/../../../../../../../../../../usr/local/bin/sh:usr/bin/bash:usr/local/bin/sh"
+	"/bin/../../bin4/../../local/bin/bash:usr/bin/bash:usr/local/bin/bash"
+	"/bin/../../bin4/../../local/bin/sh:usr/bin/bash:usr/local/bin/sh"
+)
+
+for op in "${vfs_ops[@]}"
+do
+	for mapping in "${host_mappings[@]}"
+	do
+		IFS=":" read path hostpath hostpath_trailing <<< "$mapping"
+		[[ "$hostpath_trailing" ]] || export hostpath_trailing="$hostpath"
+		[[ "$op" == "lstat" ]] && export hostpath="$hostpath_trailing"
+
+		# Compare with and without this_root...
+		vfs_helper -o "$op" -d "$root" "$hostpath"
+		old_status="$status" old_output="$output"
+		vfs_helper -o "$op" -F this_root -d "$root" "$path"
+		[[ "$status" = "$old_status" ]] || fail "$op this_root $path=$status neq $old_status"
+		[[ "$output" == "$old_output" ]] || fail "$op this_root $path=$output neq $old_output"
+	done
+done
diff --git a/tools/testing/selftests/vfs/vfs_helper.c b/tools/testing/selftests/vfs/vfs_helper.c
new file mode 100644
index 000000000000..d67ec74a3fca
--- /dev/null
+++ b/tools/testing/selftests/vfs/vfs_helper.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Author: Aleksa Sarai <cyphar@cyphar.com>
+ * Copyright (C) 2018 SUSE LLC.
+ */
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <limits.h>
+
+#include "at_flags.h"
+#include "../kselftest.h"
+
+#define bail(...)							\
+	do {								\
+		fprintf(stderr, __VA_ARGS__);				\
+		fputs("\n", stderr);					\
+		exit(1);						\
+	} while (0)
+
+extern char *__progname;
+#define usage()								\
+	bail("usage: %s -o {open|stat|lstat} [-d <dirfd-path>] "	\
+			"[-F [<flag1>,...<flagN>] <path>", __progname)
+
+static unsigned int parse_at_flags(char *opts)
+{
+	char *opt, *saveptr = NULL;
+	unsigned int flags = 0;
+
+	opt = strtok_r(opts, ",", &saveptr);
+	do {
+		unsigned int found = 0;
+
+		if (!*opt)
+			continue;
+		for (struct flag *flag = AT_FLAGS; flag->name != NULL; flag++) {
+			if (!strcmp(opt, flag->name))
+				found |= flag->at_flag;
+		}
+		if (!found)
+			bail("unknown openat(2) flag: %s", opt);
+		flags |= found;
+	} while ((opt = strtok_r(NULL, ",", &saveptr)) != NULL);
+
+	return flags;
+}
+
+int stat_wrapper(int dirfd, const char *pathname, unsigned int flags)
+{
+	struct stat st = {0};
+	int err;
+
+	err = fstatat(dirfd, pathname, &st, flags);
+	if (err < 0)
+		return err;
+
+	printf("%lu:%lu\n", st.st_dev, st.st_ino);
+	return 0;
+}
+
+int lstat_wrapper(int dirfd, const char *pathname, unsigned int flags)
+{
+	return stat_wrapper(dirfd, pathname, flags | AT_SYMLINK_NOFOLLOW);
+}
+
+int openat_wrapper(int dirfd, const char *pathname, unsigned int flags)
+{
+	int fd;
+	char *fdpath = NULL, fullpath[PATH_MAX] = {0};
+
+	fd = openat(dirfd, pathname, flags);
+	if (fd < 0)
+		return fd;
+
+	/* Print the fully-qualified path using /proc/pid/fd/... */
+	if (asprintf(&fdpath, "/proc/self/fd/%d", fd) < 0)
+		bail("asprintf /proc/self/fd/%d: %m", fd);
+	if (readlink(fdpath, fullpath, PATH_MAX) < 0)
+		bail("readlink %s: %m", fdpath);
+	puts(fullpath);
+	return fd;
+}
+
+int main(int argc, char **argv)
+{
+	int opt, ret, dirfd;
+	unsigned int flags = 0;
+	char *opstr = NULL, *dir_path = NULL, *path = NULL;
+	int (*opfunc)(int dirfd, const char *pathname, unsigned int flags);
+
+	while ((opt = getopt(argc, argv, "o:d:F:")) != -1) {
+		switch (opt) {
+		case 'o':
+			opstr = optarg;
+			break;
+		case 'd':
+			dir_path = optarg;
+			break;
+		case 'F':
+			flags |= parse_at_flags(optarg);
+			break;
+		default:
+			usage();
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc != 1)
+		usage();
+	path = argv[0];
+
+	if (!opstr)
+		usage();
+	else if (!strcmp(opstr, "stat"))
+		opfunc = stat_wrapper;
+	else if (!strcmp(opstr, "lstat"))
+		opfunc = lstat_wrapper;
+	else if (!strcmp(opstr, "open"))
+		opfunc = openat_wrapper;
+	else
+		usage();
+
+	if (opfunc == openat_wrapper) {
+		unsigned int open_flags = 0;
+
+		for (struct flag *flag = AT_FLAGS; flag->name != NULL; flag++) {
+			if (flags & flag->at_flag)
+				open_flags |= flag->open_flag;
+		}
+		flags = open_flags;
+	}
+
+	dirfd = AT_FDCWD;
+	if (dir_path) {
+		dirfd = open(dir_path, O_PATH|O_DIRECTORY);
+		if (dirfd < 0)
+			bail("cannot open dir_path: %m");
+	}
+
+	ret = opfunc(dirfd, path, flags);
+	if (ret < 0)
+		ret = -errno;
+	return (ret < 0) ? -ret : 0;
+}
-- 
2.19.0
