Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C411936680F
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520546; cv=none; b=lwTnRGb8F1MmKcirVIBAPEhQoqFnqrDq5CZfwSFP5FTzx4I1LLvasb05MPTDTkedpiI+3tOgGHcWHQYt1OiQ1FVJNzJb+X04LucI392bZNmusvplbRog60TrKhSiQSY6ZjQSY59c7HCFqLKT3sctafRgpR3nTxiEBp9dBdxRGlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520546; c=relaxed/simple;
	bh=xgvEv0TA4T925vChN0E1XX97uyXOBDlMfeiIr+Fzp8U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bZs1YLfdDN6XfgiBf0aURJ+qw0jNrwNrNnUWjkgQWET/4S/vB5kHHRbDhWOJnDwzMmnII8EMiyuH+YlvJJ5r1JlvFsdrI3QcfwRNKObWP16Pc4hFukuK8IgI8JN1Ne6Gx11yamzcNT/TL8CSgTw2pTaEXZ4YZ5htgMWeYzv+4Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2Tg+8tI; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2Tg+8tI"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49041fb8c23so13033625e9.0
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520539; x=1780125339; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH02UeX+qH1Ubr3nK9VaVAyn9HbMTAM5lChYcFZxm+I=;
        b=f2Tg+8tIh3NAdKTaCAz/R3hfZVLYNZZ8cDFT5VLhZM+uIisNq/sLV2r4xURExVAuTg
         D9s9GKm/PrpCJGiepqA61wFNeDVhOOlgKHIpo1KoUUMVbo0k21Gc0zw7ctcIqIRW+vrV
         mZFYHe7YMvSRXQDHaU12dMVrNVRGUxuKEUsuxQt2KU0WZKfoR/zVv637d/NkoYv700f6
         a3xRoHIk88EJciywU0kZ4ia53+0/BjFjoTn5Id7kB62yzP2yeD1CFUeEhVp3LggJWBG0
         b3fbKDacz8W/uytnO7Tpj6VLmPITL7U8vRclDj2GDj3YAzt19oMSBD56SGwCIaYUq2qC
         S2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520539; x=1780125339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XH02UeX+qH1Ubr3nK9VaVAyn9HbMTAM5lChYcFZxm+I=;
        b=q4F1tBCa9LbZakvjtpz48MOVcylHGWgNwhS4ItzNZ8xBLmjM/XXl2/noL95t6RGcZy
         wZt1VBFvmQKeMOVxCjqRRx4MVAqs+/NQSrSecXHmaDNZadW6QC9u4qBcA3c/7y70Bqms
         EKjIF29M+2Spy78sHE7AojHeGVKrKhsdyh7Hugfd67JNm6iqN3g9c2IlE6CTSfwGBWdp
         ksoIxBK2A6g2xRkNGTnPfgx8Z52grgQ4gBHPJSSxXvXeOtWKBNeQJw6X8i/b8OaxbuUM
         SIIQKnBM3Wuu1ypnj5psIQTQQkyBzxHkTHWYE3RjuQSC69fyU3owRYnFCo6YTyJW154M
         9ctg==
X-Forwarded-Encrypted: i=1; AFNElJ+9owUlWWGm5mg5q3h6RrwbtugGafA3xEkMk/BKp/nayapMawvIa8nsIuPVldGG1P/bI2wOtORy31jm@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhc+RdyOTxt/RJMiRzPTEsNvSVhxFRyBGGa99LnMyLaaEjSFIN
	yW/OWJadXhY9jdHlWlLe0+0zDXYVkvyj/j/hfOFP78w0BWrMs791lD/o
X-Gm-Gg: Acq92OEzYby8zWdm35TTKStdjvTDr0aiIYYZdxn64hPXYGRkwUEDiTPHiLGiYc06Lvk
	uxODvy7Jj8d75Y0pVqhFPhtvKknB+OssWYHytwxG0n65MNIH/xOrkD+zTuLxyYbOOvuDcekylqI
	sPhA1LCENEIkLtgjV68Y6RqzeyZuISdMlb3fhFADaP//T28JoNX5XNJebF/mgmfuawNim9Zg+jk
	rzQjGfV5c0yrYd0TBSb2Bax9WUMRZP0O9dlv61uDj4YWEtb9GKXlt6WhG1+4le881p/KDUT7PFf
	rL8nvcoRSYLSgVhR7DaLbUTOMyO3CEYtgvN1b2BH+H1kdgKGbPGdsaDcdStanROZ47bhMk2McLC
	suq+7okDx00F8HkxKPMXaoco4TT5IgsxwSxwAXhLsBo9khYp23iY6K0CK2nvTKcoa7YO3vGZoX3
	2iS0eH9tibkRGilblQsxm7A8+rOB14HmA3/+xK4ps=
X-Received: by 2002:a05:600c:458b:b0:490:47e3:929a with SMTP id 5b1f17b1804b1-49047e394a6mr80917335e9.6.1779520539101;
        Sat, 23 May 2026 00:15:39 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:38 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:55 -0600
Subject: [PATCH v2 22/24] selftests-dyndbg: add a dynamic_debug run_tests
 target
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260523-dd-maint-2-v2-22-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 =?utf-8?q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=13075;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=xgvEv0TA4T925vChN0E1XX97uyXOBDlMfeiIr+Fzp8U=;
 b=6JumWzr7aPD4/OsafnoAyhiCGidsWrRAThh6J5u5v7oibliaN4ltidrwy5+RtffI75yUptjoQ
 zViFkZTBeiPDdQtfS1InU3LPfH1k3v715uD1f+weEj8oFU1vg9jkJ9/
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Add a selftest script for dynamic-debug.  The config requires
CONFIG_TEST_DYNAMIC_DEBUG=m and CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m,
which tacitly requires either CONFIG_DYNAMIC_DEBUG=y or
CONFIG_DYNAMIC_DEBUG_CORE=y

ATM this has just basic_tests(), which modify pr_debug() flags in the
builtin params module.  This means they're available to manipulate and
observe the effects in "cat control".

This is backported from another feature branch; the support-fns (thx
Lukas) have unused features at the moment, they'll get used shortly.

The script enables simple virtme-ng testing:

   [jimc@gandalf b0-ftrace]$ vrun_t
   virtme-ng 1.32+115.g07b109d
   doing: vng --name v6.14-rc4-60-gd5f48427de0c \
	  --user root -v -p 4 -a dynamic_debug.verbose=3 V=1 \
	  -- ../tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
   virtme: waiting for virtiofsd to start
   ..

And add dynamic_debug to TARGETS, so `make run_tests` sees it properly
For the impatient, set TARGETS explicitly:

  [root@v6 selftests]# make TARGETS=dynamic_debug run_tests
  make[1]: Nothing to be done for 'all'.
  TAP version 13
  1..1
  # timeout set to 45
  # selftests: dynamic_debug: dyndbg_selftest.sh
  # # BASIC_TESTS    95.422122] dyndbg: query 0: 0"=_" mod:*
  ...

NOTES

check KCONFIG_CONFIG to avoid silly fails

Several tests are dependent upon config choices. Lets avoid failing
where that is noise.

The KCONFIG_CONFIG var exists to convey the config-file around.  If
the var names a file, read it and extract the relevant CONFIG items,
and use them to skip the dependent tests, thus avoiding the fails that
would follow, and the disruption to whatever CI is running these
selftests.

If the envar doesn't name a config-file, ".config" is assumed.

CONFIG_DYNAMIC_DEBUG=y:

basic-tests() and comma-terminator-tests() test for the presence of
the builtin pr_debugs in module/main.c, which I deemed stable and
therefore safe to count.  That said, the test fails if only
CONFIG_DYNAMIC_DEBUG_CORE=y is set.  It could be rewritten to test
against test-dynamic-debug.ko, but that just trades one config
dependence for another.

Co-developed-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2:

drop commit-msg mention of yet-to-be-submitted tests

move RvB after SoB

script fixups per sashiko review

   1. CONFIG_DYNAMIC_DEBUG=y is set correctly.
   2. All subshell captures $( ( ... ) 2>&1 ) are fixed.
   3. All echo variables are safely quoted to prevent word-splitting.
   4. Standardized on modern /sys/kernel/tracing/ paths.
   5. exit $exp_exit_code correctly propagates failure status.
---
 MAINTAINERS                                        |   1 +
 tools/testing/selftests/Makefile                   |   1 +
 tools/testing/selftests/dynamic_debug/Makefile     |   9 +
 tools/testing/selftests/dynamic_debug/config       |   8 +
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 257 +++++++++++++++++++++
 5 files changed, 276 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e87bfe2e9e62..3f1c7dd278d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9083,6 +9083,7 @@ F:	include/asm-generic/dyndbg.lds.h
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
 F:	lib/test_dynamic_debug.c
+F:	tools/testing/selftests/dynamic_debug/*
 
 DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@nvidia.com>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6e59b8f63e41..17c4ddbcee89 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -27,6 +27,7 @@ TARGETS += drivers/net/team
 TARGETS += drivers/net/virtio_net
 TARGETS += drivers/platform/x86/intel/ifs
 TARGETS += dt
+TARGETS += dynamic_debug
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += fchmodat2
diff --git a/tools/testing/selftests/dynamic_debug/Makefile b/tools/testing/selftests/dynamic_debug/Makefile
new file mode 100644
index 000000000000..6d06fa7f1040
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# borrowed from Makefile for user memory selftests
+
+# No binaries, but make sure arg-less "make" doesn't trigger "run_tests"
+all:
+
+TEST_PROGS := dyndbg_selftest.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/dynamic_debug/config b/tools/testing/selftests/dynamic_debug/config
new file mode 100644
index 000000000000..ec478b17873d
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/config
@@ -0,0 +1,8 @@
+
+# basic tests ref the builtin params module
+CONFIG_DYNAMIC_DEBUG=y
+
+# more testing is possible with these,
+# but insisting on them here skips testing entirely for such configs
+# CONFIG_TEST_DYNAMIC_DEBUG=m
+# CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
new file mode 100755
index 000000000000..01c035fe8c9a
--- /dev/null
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -0,0 +1,257 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+
+V=${V:=0}  # invoke as V=1 $0  for global verbose
+RED="\033[0;31m"
+GREEN="\033[0;32m"
+YELLOW="\033[0;33m"
+BLUE="\033[0;34m"
+MAGENTA="\033[0;35m"
+CYAN="\033[0;36m"
+NC="\033[0;0m"
+error_msg=""
+
+[ -e /proc/dynamic_debug/control ] || {
+    echo -e "${RED}: this test requires CONFIG_DYNAMIC_DEBUG=y ${NC}"
+    exit 0 # nothing to test here, no good reason to fail.
+}
+
+# need info to avoid failures due to untestable configs
+
+[ -f "$KCONFIG_CONFIG" ] || KCONFIG_CONFIG=".config"
+if [ -f "$KCONFIG_CONFIG" ]; then
+    echo "# consulting KCONFIG_CONFIG: $KCONFIG_CONFIG"
+    grep -q "CONFIG_DYNAMIC_DEBUG=y" $KCONFIG_CONFIG ; LACK_DD_BUILTIN=$?
+    grep -q "CONFIG_TEST_DYNAMIC_DEBUG=m" $KCONFIG_CONFIG ; LACK_TMOD=$?
+    grep -q "CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD=m" $KCONFIG_CONFIG ; LACK_TMOD_SUBMOD=$?
+    if [ $V -eq 1 ]; then
+	echo LACK_DD_BUILTIN: $LACK_DD_BUILTIN
+	echo LACK_TMOD: $LACK_TMOD
+	echo LACK_TMOD_SUBMOD: $LACK_TMOD_SUBMOD
+    fi
+else
+    LACK_DD_BUILTIN=0
+    LACK_TMOD=0
+    LACK_TMOD_SUBMOD=0
+fi
+
+function vx () {
+    echo "$1" > /sys/module/dynamic_debug/parameters/verbose
+}
+
+function ddgrep () {
+    grep "$1" /proc/dynamic_debug/control
+}
+
+function doprints () {
+    cat /sys/module/test_dynamic_debug/parameters/do_prints
+}
+
+function ddcmd () {
+    exp_exit_code=0
+    num_args=$#
+    if [ "${@:$#}" = "pass" ]; then
+	num_args=$#-1
+    elif [ "${@:$#}" = "fail" ]; then
+        num_args=$#-1
+	exp_exit_code=1
+    fi
+    args=${@:1:$num_args}
+    output=$( (echo "$args" > /proc/dynamic_debug/control) 2>&1)
+    exit_code=$?
+    error_msg=$(echo "$output" | cut -d ":" -f 5 | sed -e 's/^[[:space:]]*//')
+    handle_exit_code $BASH_LINENO $FUNCNAME $exit_code $exp_exit_code
+}
+
+function handle_exit_code() {
+    local exp_exit_code=0
+    [ $# == 4 ] && exp_exit_code=$4
+    if [ $3 -ne $exp_exit_code ]; then
+        echo -e "${RED}: $BASH_SOURCE:$1 $2() expected to exit with code $exp_exit_code"
+	[ $3 == 1 ] && echo "Error: '$error_msg'"
+        exit $exp_exit_code
+    fi
+}
+
+# $1 - pattern to match, pattern in $1 is enclosed by spaces for a match ""\s$1\s"
+# $2 - number of times the pattern passed in $1 is expected to match
+# $3 - optional can be set either to "-r" or "-v"
+#       "-r" means relaxed matching in this case pattern provided in $1 is passed
+#       as is without enclosing it with spaces
+#       "-v" prints matching lines
+# $4 - optional when $3 is set to "-r" then $4 can be used to pass "-v"
+function check_match_ct {
+    pattern="\s$1\s"
+    exp_cnt=0
+
+    [ "$3" == "-r" ] && pattern="$1"
+    let cnt=$(ddgrep "$pattern" | wc -l)
+    if [ $V -eq 1 ] || [ "$3" == "-v" ] || [ "$4" == "-v" ]; then
+        echo -ne "${BLUE}" && ddgrep $pattern && echo -ne "${NC}"
+    fi
+    [ $# -gt 1 ] && exp_cnt=$2
+    if [ $cnt -ne $exp_cnt ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO check failed expected $exp_cnt on $1, got $cnt"
+        exit
+    else
+        echo ": $cnt matches on $1"
+    fi
+}
+
+# $1 - trace instance name
+# #2 - if > 0 then directory is expected to exist, if <= 0 then otherwise
+# $3 - "-v" for verbose
+function check_trace_instance_dir {
+    if [ -e /sys/kernel/tracing/instances/$1 ]; then
+        if [ "$3" == "-v" ] ; then
+            echo "ls -l /sys/kernel/tracing/instances/$1: "
+            ls -l /sys/kernel/tracing/instances/$1
+        fi
+	if [ $2 -le 0 ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error trace instance \
+		    '/sys/kernel/tracing/instances/$1' does exist"
+	    exit
+	fi
+    else
+	if [ $2 -gt 0 ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error trace instance \
+		    '/sys/kernel/tracing/instances/$1' does not exist"
+	    exit
+        fi
+    fi
+}
+
+function tmark {
+    echo $* > /sys/kernel/tracing/trace_marker
+}
+
+# $1 - trace instance name
+# $2 - line number
+# $3 - if > 0 then the instance is expected to be opened, otherwise
+# the instance is expected to be closed
+function check_trace_instance {
+    output=$(tail -n9 /proc/dynamic_debug/control | grep ": Opened trace instances" \
+	    | xargs -n1 | grep $1)
+    if [ "$output" != $1 ] && [ $3 -gt 0 ]; then
+        echo -e "${RED}: $BASH_SOURCE:$2 trace instance $1 is not opened"
+        exit
+    fi
+    if [ "$output" == $1 ] && [ $3 -le 0 ]; then
+        echo -e "${RED}: $BASH_SOURCE:$2 trace instance $1 is not closed"
+        exit
+    fi
+}
+
+function is_trace_instance_opened {
+    check_trace_instance $1 $BASH_LINENO 1
+}
+
+function is_trace_instance_closed {
+    check_trace_instance $1 $BASH_LINENO 0
+}
+
+# $1 - trace instance directory to delete
+# $2 - if > 0 then directory is expected to be deleted successfully, if <= 0 then otherwise
+function del_trace_instance_dir() {
+    exp_exit_code=1
+    [ $2 -gt 0 ] && exp_exit_code=0
+    output=$( (rmdir /sys/kernel/tracing/instances/$1) 2>&1)
+    exit_code=$?
+    error_msg=$(echo "$output" | cut -d ":" -f 3 | sed -e 's/^[[:space:]]*//')
+    handle_exit_code $BASH_LINENO $FUNCNAME $exit_code $exp_exit_code
+}
+
+function error_log_ref {
+    # to show what I got
+    : echo "# error-log-ref: $1"
+    : echo cat \$2
+}
+
+function ifrmmod {
+    lsmod | grep $1 2>&1>/dev/null && rmmod $1
+}
+
+# $1 - text to search for
+function search_trace() {
+    search_trace_name 0 1 $1
+}
+
+# $1 - trace instance name, 0 for global event trace
+# $2 - line number counting from the bottom
+# $3 - text to search for
+function search_trace_name() {
+	if [ "$1" = "0" ]; then
+	    buf=$(cat /sys/kernel/tracing/trace)
+	    line=$(tail -$2 /sys/kernel/tracing/trace | head -1 | sed -e 's/^[[:space:]]*//')
+	else
+	    buf=$(cat /sys/kernel/tracing/instances/$1/trace)
+	    line=$(tail -$2 /sys/kernel/tracing/instances/$1/trace | head -1 | \
+		   sed -e 's/^[[:space:]]*//')
+	fi
+	if [ $2 = 0 ]; then
+	    # whole-buf check
+	    output=$(echo "$buf" | grep "$3")
+	else
+	    output=$(echo "$line" | grep "$3")
+	fi
+	if [ "$output" = "" ]; then
+            echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO search for '$3' failed \
+		    in line '$line' or '$buf'"
+	    exit
+	fi
+	if [ $V = 1 ]; then
+	    echo -e "${MAGENTA}: search_trace_name in $1 found: \n$output \nin:${BLUE} $buf ${NC}"
+        fi
+}
+
+# $1 - error message to check
+function check_err_msg() {
+    if [ "$error_msg" != "$1" ]; then
+        echo -e "${RED}: $BASH_SOURCE:$BASH_LINENO error message '$error_msg' \
+		does not match with '$1'"
+        exit
+    fi
+}
+
+function basic_tests {
+    echo -e "${GREEN}# BASIC_TESTS ${NC}"
+    if [ $LACK_DD_BUILTIN -eq 1 ]; then
+	echo "SKIP"
+	return
+    fi
+    ddcmd =_ # zero everything
+    check_match_ct =p 0
+
+    # module params are builtin to handle boot args
+    check_match_ct '\[params\]' 4 -r
+    ddcmd module params +mpf
+    check_match_ct =pmf 4
+
+    # multi-cmd input, newline separated, with embedded comments
+    cat <<"EOF" > /proc/dynamic_debug/control
+      module params =_				# clear params
+      module params +mf				# set flags
+      module params func parse_args +sl		# other flags
+EOF
+    check_match_ct =mf 3
+    check_match_ct =mfsl 1
+    ddcmd =_
+}
+
+tests_list=(
+    basic_tests
+)
+
+# Run tests
+
+ifrmmod test_dynamic_debug_submod
+ifrmmod test_dynamic_debug
+
+for test in "${tests_list[@]}"
+do
+    $test
+    echo ""
+done
+echo -en "${GREEN}# Done on: "
+date
+echo -en "${NC}"

-- 
2.54.0

