Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132549;
	b=l2PDOd+OoYSX6AhkoioDIpiFqH3+M8SKLFC4zhnsu9yX6ZalhnC5OmSpCV8IGgax0OyE
	 C4xKOIgdHJ5eG8e9FV5KxnoPzLo+sbeMuzmeQpMDxQVTKsnZj2qyDOSenwpXiHnVFpfR5
	 wt/WSttPhFgfoJ/CbOC1RK39b8AsbBsmdQb0RBBE5FGHGLkMkg5v0P0UrL4eum2j9gLmQ
	 bDq8r+3760WheGlY1fBkP+EG7s9FBSvT8y4wUrJtEm4Xr1Vgsh88revIQU4j1jeCcaOAw
	 edrWN6w6Oc7KGi/NdB3IHFT+qboC6eGj4If8xi+4vWTppxj2KKNE7oXFEwRjsTdXlHQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=d00B/axbe541XmQwx6bV6jZO6cdSKtEjdde1KD5/soc=;
	b=ho/pUlfx6/JwkQeDqdP7dRxpxc1zsbb0DuV3l0D7V4nOWgHWR2I0jId9bKNqCZy440Nn
	 T/0QThhHBip60hxyQuHK8IICHMGqc/Ds99G1xPpnZEo9mS607j0bzqi97RXBWKThvNCK8
	 DdoyKfnI4RIbjbmhKi+woZ648i127mmimaSOw4k70qi942fneWFjnmc5PFATcMRLD+jHU
	 yoQj5qLmGbtXK+fpIYHkrvOcCTdjmL5NaMPPcfhHikOKJF024WTAIfaCCujOkMxJQRhce
	 DSgpPsowlTpj3CO7n9ON7MAHFCiN1V5yr2wXpmjsWW+0UZROb5LkhsD2M3dVM6h56Mg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ZtvTnP/T";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7F86073559;
	Tue, 27 Oct 2026 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtvTnP/T
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132549;
	b=Elit4d0R6GwEliLJ+v10igWZ+cM+m2Mez160wODpawz4N99cBf6N9MBTrwIAv6JbMt/o
	 ilC2bsR8sjJAkrW6h1rr32SoOg0fZp69Gz8DVxjri1jW+KCAOuiZEHO/ipo6M8m3QoAyc
	 RTKDqjVewS6v7eGRzlLorZ7yzSF6VRXB7DN/UpLm7/a/w+cXj5AP/Fo0SbXphy9RT8fVr
	 UA22jodZ/O/n0Kqs0CkmuD6duOMT57JRNrmggU6bYd2PDCUHIAc8Fl4Nadl33eM43jgrW
	 UjQ+qB+Cth82arBdstAAI2oTDS+9zSj5KQCjpOSsqcAML1nHMr3jdJM7gPKeWgq0QrQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132549;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=d00B/axbe541XmQwx6bV6jZO6cdSKtEjdde1KD5/soc=;
	b=V4YTDX9bQdg0OQvfkLM06NRfsvInHE7UXWZ36Ag9gRfadRoma2WF7CPwD2qtIQ3bW7m8
	 kTJo601NDtv1HPim/OKWxzWgYoQo6W2cCiJjOxNvycWhxwuC5CnwlCcO3m5mlDLz7yHDc
	 pI++oiiqns4/PNVfHP/EYKG8SLteBDDzPcgXVp+MdT+vPEqMA0M4WLULzJkC0J206+Eu/
	 0y6HGZS6mD++YkphoE30owNkRhPY4ze1gnHWTSzdKSx8utSXZ4WJzN42IbN73u2KdudNL
	 GfUGHYTZmjVm3giLD4A6IC62OsFDiQUU2vGJoue4fsYZc+gw3cZmH17IzYIFYUEiS0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 65A0C1F01369;
	Tue, 27 Oct 2026 20:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132549;
	bh=d00B/axbe541XmQwx6bV6jZO6cdSKtEjdde1KD5/soc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ZtvTnP/T9F3bL7AJR6yYG6C2BqQ5f/dyfE9v2LHyW/5X9SxvfuNF3p7wQWGqrJiAb
	 48/M6Y3Aq9Na9vONRv8EWkANXGGJIu2ykhSfzgxEQxT/NirrazluJbe9Izklt3IpzY
	 02l2aXn5XYCZpIzJpCDQFkyWCX39DFve7AbPIASPUYXJBvV/PS+88fwuQdgjcV8hDu
	 xdZ5flPULQzdZH+yDcNpcngsWX83/hYQeZ0whWWMVJNQf9dlbGWQeD8wrmqYbYDVk7
	 136Etc/OcqNuRT8XAbH/N5eWz3IMoFMOUYkb04BAvyG1nJPO61Vo+pORFtVb8BXXz9
	 g9LYy1b2UazRA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6254545284;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:37 -0600
Subject: [PATCH v13 37/39] selftests/dyndbg: Add FT_count_calls to test +c
 flag
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-dd-cmap-part2-clean-v13-37-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=8322;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=cIB24g7cuii5uoOAyZOcS4iOPai9vYPfelCZ7TkNh8Y=;
 b=uVFxSZKD7EQ2lmIfr/105bJf4U9DRkLC3y9ONugnlLks4wgLAOEdvgmBBHle0IA77BtnGY46/
 yzMeBBPmfjIAVIsppA1a8BS5ifUXMStpxAPfZPJ9ExRDyJ7WxAjTmqC
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

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
index a4f78f6dbec2..fd9a3dff4099 100755
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


