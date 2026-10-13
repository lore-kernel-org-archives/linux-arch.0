Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E85147F3BC;
	Tue, 13 Oct 2026 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859001; cv=none; b=IS4nxyX0et3p+7ri4T4mzETwUsVDRVjZWX0JdwoBAUmJiBXGLZnnbICYgKp+DZOuAEgOOJngNxAKkTKrTwcK5fHEkESK9PYBBAZLMX99OoDtcLfmn2p9DhZ37nCqV0JEaIhumvVQ9COpXin2sSaSX6glFD0CgsXN9JLE/zsn1nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859001; c=relaxed/simple;
	bh=AlavCVyuJccvuR42WtiN2+PViWpWMh5AIJacGjGit24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QDEMbGYLd0OOjWRw3Qh5KJ/f8Ehmkb3dcocy7kbvx1tuMJhEwXtvmGRXLDKDIIOO58XEwK4kuog22GYvqpvEIIfnc8p83BE5c+U1en0iXLPvs7hmcPWypn1FxmCkSntMCh5eFlKPcQTm/tMVxOxynTeYeCwNMA3/p5v12Er/pt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyCNuRC3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyCNuRC3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2747AC2BCFD;
	Tue, 13 Oct 2026 02:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791859001;
	bh=AlavCVyuJccvuR42WtiN2+PViWpWMh5AIJacGjGit24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YyCNuRC32nYrHxR5TCThhc4GRmaXmh7vt5bniYCUPsyFA3WDSMSyqBwz+ATkB1YF/
	 v4R3tn7NuLEt6j5RRPbisVP+ldkibS08umOUKkgLl0GzxuU/IfKN9Yr8FLQvyRqFV6
	 kwPZfQ5ZpiQmxc2XsBwibr8nBWDCnaErCEjTc4nikkuN4FPPYdABQhj3SP+5RUZwGm
	 c+Az7EyRAHtxMng0lB8vaWjIedMLv+hsL7PIb2gdMVhczSARmIIlAhkdugpIUHOMfM
	 1mRPk56S1PbIQnCWQh4dk5bctdKP4A4Fhl0EHSS9CQ244EMfFFHiEqbegttRqM4mjU
	 H08nwgp0hLWIQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A67CC6B0A;
	Tue, 13 Oct 2026 02:36:41 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:37:10 -0600
Subject: [PATCH v12 39/40] selftests/dyndbg: Add FT_count_calls to test +c
 flag
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-dd-cmap-part2-clean-v12-39-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791858995; l=8322;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=bPJUHC0eXquS3qpx9N/zW+391hcPqSH5I9vyZib0ng0=;
 b=A0MZS14DB0BpKSeobUshR3gs4cdeu3DDskFuyaeJ/F8UhipAJQeIZVgjRVAOCbryaFu0ApfBv
 +1aIrS8NMa6DKUTUee4lVyUoEkOR5AJq1KXKzfvVOm8HI0ZEZsppMZu
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

Commit a2dafb8fcfc6 ("dyndbg: add +c flag to count pr_debug calls
without printing") introduced the +c call-counting flag and
reset_stats command, and commit 3b77a5088910 ("dyndbg: add epilogue
to dynamic_debug/control file") added the counted_calls epilogue.
However, neither was covered by the selftest script, leaving call
counting, scaling, zeroing, and print suppression unverified.

Add FT_count_calls to dyndbg_selftest.sh to exercise the full
lifecycle (baseline -> change -> verify):
0. Baseline reset: verify reset_stats clears the counted_calls epilogue.
1. Unenabled baseline: verify unflagged callsites yield 0 counts/prints.
2. Pure counting (+c): verify 11 calls counted with 0 syslog prints.
3. Scaling: verify count reaches 32 after additional repeat workload.
4. Zeroing: verify reset_stats drops count to 0 and clears epilogue.
5. Classmap-scoped: verify class D2_CORE +c increments count by 1.
6. Tandem mode (+pc): verify count is 11 and 11 syslog prints appear.
7. Flag clearing (-c): verify count stops while +p logging persists.
8. Teardown: clear flags, zero stats, and unload test_dynamic_debug.

Register FT_count_calls in modular_tests and update the LACK_TMOD
filter to skip it gracefully when modular dependencies are absent.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 146 ++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 109f11b2649e..c763949499eb 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -471,6 +471,148 @@ function FT_modprobe_w_param {
     ddcmd =_
 }
 
+function FT_count_calls {
+    v_echo "${GREEN}# TEST_COUNT_CALLS - verify +c, -c, reset_stats${NC}"
+
+    if [ "${LACK_TMOD:-0}" -eq 1 ]; then
+        echo "SKIP - test requires test_dynamic_debug module"
+        return
+    fi
+
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+    my_modprobe test_dynamic_debug
+    ddcmd =_
+
+    local marker cnt hits
+
+    # 0. Baseline verification: reset_stats clears counter and epilogue
+    ddcmd reset_stats
+    cnt=$(awk '/^#: counted_calls:/ { print $3 }' /proc/dynamic_debug/control)
+    cnt=${cnt:-0}
+    if [ "$cnt" -ne 0 ]; then
+        echo -e "${RED}: baseline count expected 0, got $cnt${NC}"
+        exit $ksft_fail
+    fi
+
+    # 1. Baseline execution: unenabled callsites produce 0 counts and 0 prints
+    marker="FT_CNT_BASE_$$"
+    echo "$marker" > /dev/kmsg
+    set_param 1 /sys/module/test_dynamic_debug/parameters/do_bulk
+    cnt=$(awk '/^#: counted_calls:/ { print $3 }' /proc/dynamic_debug/control)
+    cnt=${cnt:-0}
+    hits=$(dmesg | sed -n "/$marker/,\$p" | grep -v "$marker" | \
+	grep -c "test_dd: ")
+    if [ "$cnt" -ne 0 ] || [ "$hits" -ne 0 ]; then
+        echo -e "${RED}: unenabled callsite counted ($cnt)" \
+            "or logged ($hits)${NC}"
+        exit $ksft_fail
+    fi
+    v_echo "${GREEN}: Baseline: 0 counts, 0 prints on unenabled callsites${NC}"
+
+    # 2. Pure counting (+c): counts call executions without syslog printing
+    ddcmd "module test_dynamic_debug func do_bulk +c"
+    marker="FT_CNT_PURE_$$"
+    echo "$marker" > /dev/kmsg
+    set_param 1 /sys/module/test_dynamic_debug/parameters/do_bulk
+    cnt=$(awk '/^#: counted_calls:/ { print $3 }' /proc/dynamic_debug/control)
+    cnt=${cnt:-0}
+    hits=$(dmesg | sed -n "/$marker/,\$p" | grep -v "$marker" | \
+	grep -c "test_dd: ")
+    # do_bulk(1) executes 1 header + 10 bulk prints = 11 calls
+    if [ "$cnt" -ne 11 ]; then
+        echo -e "${RED}: pure +c count mismatch: expected 11, got $cnt${NC}"
+        exit $ksft_fail
+    fi
+    if [ "$hits" -ne 0 ]; then
+        echo -e "${RED}: pure +c leaked $hits prints to dmesg!${NC}"
+        exit $ksft_fail
+    fi
+    v_echo "${GREEN}: Proven: +c counted exactly $cnt calls with 0 prints${NC}"
+
+    # 3. Scaling verification: additional iterations accumulate accurately
+    set_param 2 /sys/module/test_dynamic_debug/parameters/do_bulk
+    cnt=$(awk '/^#: counted_calls:/ { print $3 }' /proc/dynamic_debug/control)
+    cnt=${cnt:-0}
+    # previous 11 + (1 header + 20 bulk prints = 21) = 32 calls
+    if [ "$cnt" -ne 32 ]; then
+        echo -e "${RED}: accumulated count mismatch: expected 32, got $cnt${NC}"
+        exit $ksft_fail
+    fi
+    v_echo "${GREEN}: Proven: accumulated count scaled to $cnt calls${NC}"
+
+    # 4. reset_stats clears active counter
+    ddcmd reset_stats
+    cnt=$(awk '/^#: counted_calls:/ { print $3 }' /proc/dynamic_debug/control)
+    cnt=${cnt:-0}
+    if [ "$cnt" -ne 0 ]; then
+        echo -e "${RED}: reset_stats failed: expected 0, got $cnt${NC}"
+        exit $ksft_fail
+    fi
+    v_echo "${GREEN}: Proven: reset_stats zeroed counter and epilogue${NC}"
+
+    # 5. Class-mapped call counting: verify +c on class-specific callsites
+    ddcmd =_
+    ddcmd "class D2_CORE +c"
+    set_param 1 /sys/module/test_dynamic_debug/parameters/do_classes
+    cnt=$(awk '/^#: counted_calls:/ { print $3 }' /proc/dynamic_debug/control)
+    cnt=${cnt:-0}
+    # do_classes(1) triggers do_cats() which calls D2_CORE once
+    if [ "$cnt" -ne 1 ]; then
+        echo -e "${RED}: class +c count mismatch: expected 1, got $cnt${NC}"
+        exit $ksft_fail
+    fi
+    v_echo "${GREEN}: Proven: class D2_CORE +c counted exactly $cnt call${NC}"
+
+    # 6. Simultaneous print and count (+pc): both operate in tandem
+    ddcmd reset_stats
+    ddcmd =_
+    ddcmd "module test_dynamic_debug func do_bulk +pc"
+    marker="FT_CNT_PC_$$"
+    echo "$marker" > /dev/kmsg
+    set_param 1 /sys/module/test_dynamic_debug/parameters/do_bulk
+    cnt=$(awk '/^#: counted_calls:/ { print $3 }' /proc/dynamic_debug/control)
+    cnt=${cnt:-0}
+    hits=$(dmesg | sed -n "/$marker/,\$p" | grep -v "$marker" | \
+	grep -c "test_dd: ")
+    if [ "$cnt" -ne 11 ]; then
+        echo -e "${RED}: +pc count mismatch: expected 11, got $cnt${NC}"
+        exit $ksft_fail
+    fi
+    if [ "$hits" -ne 11 ]; then
+        echo -e "${RED}: +pc print mismatch: expected 11, got $hits${NC}"
+        exit $ksft_fail
+    fi
+    v_echo "${GREEN}: Proven: +pc counted $cnt calls" \
+        "and logged $hits prints${NC}"
+
+    # 7. Disabling counter (-c): preserves printing (+p), stops count
+    ddcmd reset_stats
+    ddcmd "module test_dynamic_debug func do_bulk -c"
+    marker="FT_CNT_NOC_$$"
+    echo "$marker" > /dev/kmsg
+    set_param 1 /sys/module/test_dynamic_debug/parameters/do_bulk
+    cnt=$(awk '/^#: counted_calls:/ { print $3 }' /proc/dynamic_debug/control)
+    cnt=${cnt:-0}
+    hits=$(dmesg | sed -n "/$marker/,\$p" | grep -v "$marker" | \
+	grep -c "test_dd: ")
+    if [ "$cnt" -ne 0 ]; then
+        echo -e "${RED}: -c unsetting failed: expected 0, got $cnt${NC}"
+        exit $ksft_fail
+    fi
+    if [ "$hits" -ne 11 ]; then
+        echo -e "${RED}: -c print mismatch: expected 11, got $hits${NC}"
+        exit $ksft_fail
+    fi
+    v_echo "${GREEN}: Proven: -c stopped count accumulation" \
+        "while retaining +p${NC}"
+
+    # Teardown
+    ddcmd =_
+    ddcmd reset_stats
+    ifrmmod test_dynamic_debug
+}
+
 # Built-in Feature Tests (Can run on any CONFIG_DYNAMIC_DEBUG kernel, modular or monolithic)
 builtin_tests=(
     FT_grammar_ok
@@ -485,6 +627,7 @@ modular_tests=(
     FT_test_classes
     FT_classmap_inheritance
     FT_modprobe_w_param
+    FT_count_calls
 )
 
 # ==============================================================================
@@ -637,7 +780,8 @@ EO_DYNDBG_GOLDEN_REFS
                 local label=$(echo "$line" | awk '{print $3}')
                 if [[ "$label" == FT_test_classes* \
 			  || "$label" == FT_classmap_inheritance* \
-			  || "$label" == FT_modprobe_w_param* ]]; then
+			  || "$label" == FT_modprobe_w_param* \
+			  || "$label" == FT_count_calls* ]]; then
                     continue
                 fi
             fi

-- 
2.56.0


