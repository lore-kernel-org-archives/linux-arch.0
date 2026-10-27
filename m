Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132549;
	b=j2LhR+PQda7bW+OiAYSr2hnMp6Yxm3xYTA9i7+Cnvt6yXQ1bWTqnL4h+L/VtMhC0+n8n
	 yI+kLHpBTvzzJtaVWysaBnH/e7gvtOymHeppkhRgR4K0VBumelCdWOTfaux52HMWVgMik
	 jJXjmhixXdunw1wlG1POgGmd1KXUjqV9U8bnHvtIYeZjCQ3h1Fstr5nUUTBJLyIn8FpqJ
	 /wEIOKIHdZYka+GGoLVCnvMUn2avSmKS9qzVPKCLrInyPcwDV8vwWgDt5sacJrpc2dMrm
	 5jqv8nEA5fsdC1fDwZkFd/3FTmRGKR4Zkh9+CZd5IRi2M+YztZ41SubrAyz2VQf5Pqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MOTLZ1AAMCAL6PYhEw2xMEvjABAlgkgES7g/HZNOQrQ=;
	b=XKk31+6aBNXmUZ6Sbg2+M+ZqWyKbZf+r8d3RDmJy3Y9c0bVDcvu5UI4ftlxUS7zzYkPo
	 1Pq/+T8M3edB/VmIZEOvrAXi3LnOgP3kwWrD9hz7CdFYqSC4gWlucf+a80+3Gdx/6qyUk
	 flnw/PI+aiYacbZP4Hkjtg0khxyU6G9BQ2nUHbis4WEB9gDm3bliwlA4xnL3xKYXrjUoI
	 qnL9ihn3+/N9Z/wBL9N1PsATUd9PFCoJ7mj4YoFz+SMA/P5QkMH7lWzsD3EX2AMd/d66h
	 D/LG2Nt1pSEKJDtaHT50YaUI0Fl5DOfcJ95ws3cppJQT0F64f3fLCKCGq+RCulAhrlw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nb9kj68e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F9607354A;
	Tue, 27 Oct 2026 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nb9kj68e
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132548;
	b=uGf/L80OE9CRfCHJNYzF3uFGk7CVhy1bstiIBCMWWqtHI0a+tS6J8QbFy31yt4rwnkx9
	 IR1zr9oHYS2ZLVNin49Bn1QZA8lZoHSXS5omgfxdtNSPoAtyeot86kdXamfD+2WcGLvPs
	 0X6A9zGtlkUxVHXMwvMtaKnQTjRVgLrd4HO4uSHItoEDqQNqIIXRwa2702RfsdjLhGYsO
	 W6BBIit1TFF3eGigKbqQowQy5TBYvlWpULI7Lvcd4plUY3wjKEa0FqfYflRig3miGr6bf
	 BrsXNlTJj/g5RSKjymvrNtvLFFcQD4p3oe77lW6e/6oqDx3BYsF1hzmV3VGpEA+CnIg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132548;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=MOTLZ1AAMCAL6PYhEw2xMEvjABAlgkgES7g/HZNOQrQ=;
	b=BCMqGnbNx531rdEujaU2GDH+dLk5YCrPsIch0kLY8nFbzWKe8rwk9ee2psmKuGMUj7ij
	 tOURpABhf6UYmFQjZQZYLRRgJLO2zfpNtZ3vG4vf4QgZ1AAITTQH+eU4nbMQwh6PMbOkj
	 oyKpJVjm+mQfWkMznFHGKhh8gqsdHNzxl7UqTG1z97daB83qis3z1P9IG1hgYUWCt/1RK
	 +x4DLrhQAJFBZqQr2D8jTbT0NhTmfpEsrSdtFHyBRsMzMZHgJi2dhp/hKYfYy3c7iuyOF
	 XCCOn0+usmA7MvfQu/R65Ls4KZcTMgkElmdtL9UlYydGXk4JpC4wNR88bsJFsDU5tlQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A4EB71F01342;
	Tue, 27 Oct 2026 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132548;
	bh=MOTLZ1AAMCAL6PYhEw2xMEvjABAlgkgES7g/HZNOQrQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=nb9kj68ef8R+4rPra9PTwP0YmnqNKgWsXJp0fBZTg5Nogo6qv9cSjhELMsp/TrgI8
	 XQgaraWK3SCQeH3uWpVU98oQfEkICabMquWB9HV+oJXCWhU7fFJNdhTScHRWwabFRz
	 DuB8OazSZ3P/N2rYwomhWwiDUBFhR+yi2fMweS+eOUs1xysjT6cqnShGFb4buraWRp
	 OtgXaVNQzs3qwXeCJ3KgDG1+2WcF5am96Rv0EUuFvgmZViiI6PJ1L3HOgIKtWhE0Ze
	 fd3U6HUWhAe8awv3THIHdcZJQYsJKZkd3ArMpg3nrPatO66gaOvGcBruPBGWA/syPN
	 hstK2W9dAfOLA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E13CD45259;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:26 -0600
Subject: [PATCH v13 26/39] dyndbg-test: add do_bulk testpoint, rename
 do_prints to do_classes
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-26-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=19693;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Q39kf1DOJrF9z5bag1r7DRN7eoBkbjXNIruiII3FoAg=;
 b=iZmN/oHUUeq5ELVXoMgDRwBmhQ85tGfYRGSnG6vN7oxy60maN64/xfgIkJVKv11Ncai8ohlZo
 zDNCHSvCTloADsWDXogHcQcKNd8G62UL4OQK/6l1j6h7u5/aaLzKKPf
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

test_dynamic_debug.ko currently has the do_prints sysnode to support
testing of the classmaps feature, it calls ~16 class'd pr_debug()s,
*once* for each class defined in the module.

Improve the versatility of this support by:

 1. changing do_prints() to do_classes()
    to better align with its actual purpose

 2. new parameters/do_bulk & do_bulk(N):
    loops over 10 pr_debugs, N times
    creates idempotent non-repetetive (ie 1..N lines) output
    meant for creating high-volume workloads

 3. using common param-ops for both (no reason not to)
    ie: do_classes(N) now accepts work-count.

So now we can generate significant workloads with a single write.

    modprobe test_dynamic_debug dyndbg=+p
    echo 100  > /sys/module/test_dynamic_debug/parameters/do_classes
    echo 2000 > /sys/module/test_dynamic_debug/parameters/do_bulk

TODO: enable do_bulk() callsites by default, since the modprobe is an
explicit act, the user intends to use it, lets turn it on.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v11:
. clamp repeat count input to 10,000 in param_set_do_repeats() and add
  signal_pending(current) break check to do_classes() and do_bulk()
  loops to prevent unbounded print storms and allow interactive aborts.
. add timed execution mode for negative repeats: convert repeat
  parameter to signed int, interpreting -N as duration in seconds
  (clamped to 60s) looping until timeout expires or signal received.

v9:
. use unsigned int for loop index in do_bulk() to prevent wrapping lockups on UINT_MAX.
. add cond_resched() to do_classes() and do_bulk() loops.
v8: fix a test which had commas, from the future, adjust KRECs
---
 lib/test_dynamic_debug.c                           | 162 ++++++++++++++++----
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 167 ++++++++++++++++++---
 2 files changed, 274 insertions(+), 55 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 01ce07001d4c..f78764025c44 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -28,25 +28,57 @@
 #endif
 
 #include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/jiffies.h>
 
-/* re-gen output by reading or writing sysfs node: do_prints */
+#define TEST_MAX_REPEATS 10000
+#define TEST_MAX_SECONDS 60
 
-static void do_prints(void); /* device under test */
-static int param_set_do_prints(const char *instr, const struct kernel_param *kp)
+/* re-trigger debug output by reading or writing sysfs nodes: do_classes or do_bulk */
+static void do_classes(int); /* device under test */
+static void do_bulk(int);    /* device under test */
+
+static int param_set_do_repeats(const char *instr, const struct kernel_param *kp)
 {
-	do_prints();
+	int rc, ct;
+	void (*repeat_fn)(int) = kp->arg;
+
+	rc = kstrtoint(instr, 0, &ct);
+	if (rc) {
+		pr_err("expecting numeric input, using 1 instead\n");
+		ct = 1;
+	}
+	if (ct > TEST_MAX_REPEATS) {
+		pr_warn("%s: clamping %d to %d\n", kp->name, ct, TEST_MAX_REPEATS);
+		ct = TEST_MAX_REPEATS;
+	} else if (ct < -TEST_MAX_SECONDS) {
+		pr_warn("%s: clamping %d seconds to -%d\n",
+			kp->name, ct, TEST_MAX_SECONDS);
+		ct = -TEST_MAX_SECONDS;
+	}
+
+	repeat_fn(ct);
+
 	return 0;
 }
-static int param_get_do_prints(char *buffer, const struct kernel_param *kp)
+
+static int param_get_do_repeats(char *buffer, const struct kernel_param *kp)
 {
-	do_prints();
-	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
+	void (*repeat_fn)(int) = kp->arg;
+
+	repeat_fn(1);
+
+	return scnprintf(buffer, PAGE_SIZE, "did 1 %s\n", kp->name);
 }
-static const struct kernel_param_ops param_ops_do_prints = {
-	.set = param_set_do_prints,
-	.get = param_get_do_prints,
+
+static const struct kernel_param_ops param_ops_do_repeats = {
+	.set = param_set_do_repeats,
+	.get = param_get_do_repeats,
 };
-module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
+
+module_param_cb(do_classes, &param_ops_do_repeats, do_classes, 0600);
+module_param_cb(do_bulk, &param_ops_do_repeats, do_bulk, 0600);
 
 /*
  * Using the CLASSMAP api:
@@ -103,7 +135,10 @@ enum cat_disjoint_bits {
 	D2_DRMRES };
 
 /* numeric verbosity, V2 > V1 related.  V1 is > D2_DRMRES */
-enum cat_level_num { V1 = 16, V2, V3, V4, V5, V6, V7 };
+enum cat_level_num { V1 = 16, V2, V3, V4, V5, V6, V7, V8 };
+
+/* test _USE_ w offset */
+enum cat_level_offset { Vu1 = V1 + 8, Vu2, Vu3, Vu4, Vu5, Vu6, Vu7, Vu8 };
 
 /* recapitulate DRM's multi-classmap setup */
 #if !defined(TEST_DYNAMIC_DEBUG_SUBMOD)
@@ -126,7 +161,7 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
 			      "D2_DRMRES");
 
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
-			      V1, "V1", "V2", "V3", "V4", "V5", "V6", "V7");
+			      V1, "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8");
 
 #ifdef FORCE_CLASSID_CONFLICT
 /*
@@ -136,18 +171,6 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
 #endif
 
-#else /* TEST_DYNAMIC_DEBUG_SUBMOD */
-
-/*
- * in submod/drm-drivers, use the classmaps defined in top/parent
- * module above.
- */
-
-DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
-DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 7);
-
-enum cat_level_offset { Vu1 = V1 + 7, Vu2, Vu3, Vu4, Vu5, Vu6, Vu7 };
-
 #if defined(DD_MACRO_ARGCHECK)
 /*
  * Exersize compile-time arg-checks in DYNAMIC_DEBUG_CLASSMAP_DEFINE.
@@ -160,6 +183,19 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_emptyclass, 0, 0 /* ,empty */);
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_maptype, 3, 10, "no such type");
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_len, 0, 60,
 			      "base", "plus", "classes", "length", "too-big");
+#endif
+
+#else /* TEST_DYNAMIC_DEBUG_SUBMOD */
+
+/*
+ * in submod/drm-drivers, use the classmaps defined in top/parent
+ * module above.
+ */
+
+DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
+DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 8);
+
+#if defined(DD_MACRO_ARGCHECK)
 DYNAMIC_DEBUG_CLASSMAP_USE_(fail_offset_big, 100);
 #endif /* DD_MACRO_ARGCHECK */
 
@@ -202,6 +238,7 @@ static void do_levels(void)
 	prdbg(V5);
 	prdbg(V6);
 	prdbg(V7);
+	prdbg(V8);
 #else
 	prdbg(Vu1);
 	prdbg(Vu2);
@@ -210,20 +247,85 @@ static void do_levels(void)
 	prdbg(Vu5);
 	prdbg(Vu6);
 	prdbg(Vu7);
+	prdbg(Vu8);
 #endif
 }
 
-static void do_prints(void)
+static void do_classes(int ct)
+{
+	if (ct < 0) {
+		unsigned long timeout = jiffies + (-ct) * HZ;
+
+		pr_debug("%s for %d seconds:\n", __func__, -ct);
+		while (time_before(jiffies, timeout)) {
+			if (signal_pending(current))
+				break;
+			do_cats();
+			do_levels();
+			cond_resched();
+		}
+		return;
+	}
+
+	pr_debug("do_classes %u times:\n", ct);
+	for (; ct; ct--) {
+		if (signal_pending(current))
+			break;
+		do_cats();
+		do_levels();
+		cond_resched();
+	}
+}
+
+static void do_bulk(int ct)
 {
-	pr_debug("do_prints:\n");
-	do_cats();
-	do_levels();
+	unsigned int i;
+
+	if (ct < 0) {
+		unsigned long timeout = jiffies + (-ct) * HZ;
+
+		pr_debug("%s for %d seconds:\n", __func__, -ct);
+		for (i = 0; time_before(jiffies, timeout); i++) {
+			if (signal_pending(current))
+				break;
+			pr_debug("bulk msg %u.0\n", i + 1);
+			pr_debug("bulk msg %u.1\n", i + 1);
+			pr_debug("bulk msg %u.2\n", i + 1);
+			pr_debug("bulk msg %u.3\n", i + 1);
+			pr_debug("bulk msg %u.4\n", i + 1);
+			pr_debug("bulk msg %u.5\n", i + 1);
+			pr_debug("bulk msg %u.6\n", i + 1);
+			pr_debug("bulk msg %u.7\n", i + 1);
+			pr_debug("bulk msg %u.8\n", i + 1);
+			pr_debug("bulk msg %u.9\n", i + 1);
+			cond_resched();
+		}
+		return;
+	}
+
+	pr_debug("do_bulk %u times:\n", ct);
+	for (i = 0; i < ct; i++) {
+		if (signal_pending(current))
+			break;
+		pr_debug("bulk msg %u.0\n", i + 1);
+		pr_debug("bulk msg %u.1\n", i + 1);
+		pr_debug("bulk msg %u.2\n", i + 1);
+		pr_debug("bulk msg %u.3\n", i + 1);
+		pr_debug("bulk msg %u.4\n", i + 1);
+		pr_debug("bulk msg %u.5\n", i + 1);
+		pr_debug("bulk msg %u.6\n", i + 1);
+		pr_debug("bulk msg %u.7\n", i + 1);
+		pr_debug("bulk msg %u.8\n", i + 1);
+		pr_debug("bulk msg %u.9\n", i + 1);
+		cond_resched();
+	}
 }
 
 static int __init test_dynamic_debug_init(void)
 {
 	pr_debug("init start\n");
-	do_prints();
+	do_classes(1);
+	do_bulk(1);
 	pr_debug("init done\n");
 	return 0;
 }
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index cfd438dcf965..b9e380899b29 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -178,6 +178,54 @@ function slice_and_hash_ddctrl {
     echo "$slice" | tr -d '\r' | md5sum | cut -d' ' -f1
 }
 
+# ==============================================================================
+
+function verify_modprobe_param_logging {
+    # $1 - parameter name (e.g. do_prints)
+    # $2 - parameter value (e.g. 1)
+    local param="$1"
+    local val="$2"
+
+    # Make sure both modules are completely unloaded to trigger a fresh load
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+
+    # Capture and verify the load-time (modprobe) dmesg logs
+    log_start
+    my_modprobe test_dynamic_debug "${param}=${val}"
+    my_modprobe test_dynamic_debug_submod
+
+    # If it is a state-controlling parameter, trigger the
+    # print-workload 'do_prints=1' inside the same syslog dmesg
+    # capture bookends to verify their actual pr_debug logging!
+
+    if [ "$param" = "p_disjoint_bits" ] || [ "$param" = "p_level_num" ]; then
+        set_param 1 /sys/module/test_dynamic_debug/parameters/do_classes
+    fi
+
+    log_stop
+
+    # Verify param write by direct readback
+    if [ "$param" = "p_disjoint_bits" ] || [ "$param" = "p_level_num" ]; then
+        local readback=$(cat "/sys/module/test_dynamic_debug/parameters/${param}")
+        if (( readback != val )); then
+            echo -e "${RED}: param readback failed: ${param} ${val} != ${readback}${NC}"
+            exit $ksft_fail
+        else
+            [ "$V" -ge 1 ] && \
+		echo -e "${GREEN}✔ Parameter Readback Verified: ${param}=${readback}${NC}"
+        fi
+    fi
+
+    # verify runtime unsetting
+    if [ "$param" = "p_disjoint_bits" ] || [ "$param" = "p_level_num" ]; then
+
+        set_param 0 "/sys/module/test_dynamic_debug/parameters/${param}"
+	verify_control_slice '\[test_dynamic_debug\]'
+
+    fi
+}
+
 # ==============================================================================
 # FEATURE TESTS (FT_*)
 #
@@ -292,33 +340,38 @@ function FT_basic_queries {
     ddcmd "file $f =_" "$f"
 }
 
-function FT_classmap_inheritance {
-    v_echo "${GREEN}# TEST_MOD_SUBMOD ${NC}"
+# testing classmap-based query enablers and class configurations
+function FT_test_classes {
+    v_echo "${GREEN}# TEST_CLASSES - classmap-based query enablers and class configs ${NC}"
 
     ifrmmod test_dynamic_debug_submod
     ifrmmod test_dynamic_debug
+    ddcmd =_
 
-    # modprobe with plain-old +p & 3 class enablements
+    # 1. Verify initial multi-query enablement state via file slice
     my_modprobe test_dynamic_debug \
-	"dyndbg=+p;class D2_CORE +pf;class D2_KMS +pt;class D2_ATOMIC +pm"
+        dyndbg="class D2_CORE,+pf;class D2_KMS,+ps;class D2_ATOMIC +pm"
     verify_control_slice '\[test_dynamic_debug\]'
 
-    set_param 5 /sys/module/test_dynamic_debug/parameters/p_level_num
-    verify_control_slice '\[test_dynamic_debug\]'
+    # 2. Verify state transition and live-printing end-to-end via ddcmd_load!
+    ddcmd_load "class D2_CORE +pmf;class D2_KMS +pls;class D2_ATOMIC +pml" \
+        '\[test_dynamic_debug\]' \
+        "/sys/module/test_dynamic_debug/parameters/do_classes" "1"
 
-    my_modprobe test_dynamic_debug_submod
-    verify_control_slice 'test_dynamic_debug_submod'
+    ifrmmod test_dynamic_debug
+}
+function FT_classmap_inheritance {
+    v_echo "${GREEN}# TEST_MOD_SUBMOD - Classmap state inheritance between supermod and submod ${NC}"
 
-    # fresh start, to clear all above flags (test-fn limits)
     ifrmmod test_dynamic_debug_submod
     ifrmmod test_dynamic_debug
 
-    # load submod, which loads supermod
+    # 1. Load submod directly (which auto-loads supermod with default parameters)
     my_modprobe test_dynamic_debug_submod \
 	"dyndbg=+p;class D2_CORE +pfs;class D2_KMS +pts;class D2_ATOMIC +pmf"
     verify_control_slice 'test_dynamic_debug'
 
-    # runtime changes to both
+    # 2. Runtime parameter changes to supermod propagate to submod descriptors
     set_param 0x57 /sys/module/test_dynamic_debug/parameters/p_disjoint_bits
     set_param 4 /sys/module/test_dynamic_debug/parameters/p_level_num
     verify_control_slice 'test_dynamic_debug'
@@ -326,18 +379,17 @@ function FT_classmap_inheritance {
     ifrmmod test_dynamic_debug_submod
     ifrmmod test_dynamic_debug
 
-    # set super-mod params at load-time
+    # 3. Pre-initialize supermod parameter state at load-time
     my_modprobe test_dynamic_debug p_disjoint_bits=0x16 p_level_num=5
     verify_control_slice '\[test_dynamic_debug\]'
 
-    # see them picked up by submod
+    # 4. Verify submod inherits pre-initialized supermod classmap parameter state upon load
     my_modprobe test_dynamic_debug_submod
     verify_control_slice 'test_dynamic_debug'
 
     # load-time (modprobe) and runtime (sysfs write) parameter equivalence
     local hash_modprobe=$(slice_and_hash_ddctrl '\[test_dynamic_debug.*\]')
 
-    # Fresh load with default parameters, then configure them dynamically at runtime
     ifrmmod test_dynamic_debug_submod
     ifrmmod test_dynamic_debug
     my_modprobe test_dynamic_debug
@@ -353,16 +405,43 @@ function FT_classmap_inheritance {
         v_echo "${GREEN}: Proven: parameter load-time (modprobe) " \
             "and runtime (sysfs write) are equivalent!${NC}"
     fi
-    # --- Live Content Fingerprinting Phase ---
+    # 6. End-to-end syslog content logging verification
     log_start
-    echo 1 > /sys/module/test_dynamic_debug/parameters/do_prints
-    echo 1 > /sys/module/test_dynamic_debug_submod/parameters/do_prints
+    echo 1 > /sys/module/test_dynamic_debug/parameters/do_classes
+    echo 1 > /sys/module/test_dynamic_debug_submod/parameters/do_classes
     log_stop
 
     ifrmmod test_dynamic_debug_submod
     ifrmmod test_dynamic_debug
 }
 
+function FT_modprobe_w_param {
+    v_echo "${GREEN}# TEST_MODPROBES ${NC}"
+    local verbose
+
+    ifrmmod test_dynamic_debug_submod
+    ifrmmod test_dynamic_debug
+
+    for verbose in 1 2; do # 3 4 0; do
+	echo $verbose > /sys/module/dynamic_debug/parameters/verbose
+
+	# Verify each parameter load sequence with 100% DRY modularity
+	verify_modprobe_param_logging "do_classes" "1"
+	verify_modprobe_param_logging "do_bulk" "1"
+
+	# Sequence composite bitmasks to verify disjoint bit transitions
+	for mask in "0x05" "0x12" "0x1f" "0x00"; do
+            verify_modprobe_param_logging "p_disjoint_bits" "$mask"
+	done
+
+	# Sequence levels to verify both growing and shrinking verbose transitions
+	for lvl in "3" "5" "4" "0"; do
+            verify_modprobe_param_logging "p_level_num" "$lvl"
+	done
+    done
+    ddcmd =_
+}
+
 # Built-in Feature Tests (Can run on any CONFIG_DYNAMIC_DEBUG kernel, modular or monolithic)
 builtin_tests=(
     FT_grammar_ok
@@ -372,7 +451,9 @@ builtin_tests=(
 
 # Modular Feature Tests (Require CONFIG_MODULES=y and test_dynamic_debug*.ko available)
 modular_tests=(
+    FT_test_classes
     FT_classmap_inheritance
+    FT_modprobe_w_param
 )
 
 # ==============================================================================
@@ -456,14 +537,50 @@ function GOLDEN_RECORDS {
 #K= 02e4fd94602e108cb89bfc70d47a5dad FT_basic_queries.5
 #K= f03a7ca7316e8db4c0e16523dc41e75d FT_basic_queries.6
 #K= c518a50ba30ba8099d0dc874a27ecf16 FT_basic_queries.7
-#K= fb294f02a4207b28b2a874524ef07afd FT_classmap_inheritance.1
-#K= 7a0b87016fdc237077dfe96bbbb3661b FT_classmap_inheritance.2
-#K= 2784d60f5056fc5cc03b3ceb854293f5 FT_classmap_inheritance.3
-#K= bf66aaf8ff612272c0cda29778ed2131 FT_classmap_inheritance.4
-#K= 49fdd29d91a4c1d16f8b59bb431e741b FT_classmap_inheritance.5
-#K= a8aa244285d048b5ebe33061fa99c424 FT_classmap_inheritance.6
-#K= 3060b86a0f553dd5a826bb7023284925 FT_classmap_inheritance.7
-#K= f43e0aff8a4b38435b73d90ed8100d1b FT_classmap_inheritance.8
+#K= 2b4b152bdb82e6e4a5be18ca26025895 FT_test_classes.1
+#K= 5516e3d13cba7ea4197a7fb6c033887a FT_test_classes.2
+#K= 37dc0919cb1c0ee8ba00ad2ad77ba7c3 FT_test_classes.3
+#K= 1489b3b72dbdfdb553cc0c6594c4face FT_classmap_inheritance.1
+#K= e11c22649735cedb6c30321378100e11 FT_classmap_inheritance.2
+#K= 5d0f3701517aa3a461c8887c332bdb42 FT_classmap_inheritance.3
+#K= d39188ded831453d90d77390546b314d FT_classmap_inheritance.4
+#K= f43e0aff8a4b38435b73d90ed8100d1b FT_classmap_inheritance.5
+#K= d2e8b8c5a5b4e7b9bbe1a29460a3c07d FT_modprobe_w_param.1
+#K= d2e8b8c5a5b4e7b9bbe1a29460a3c07d FT_modprobe_w_param.2
+#K= 11032ef17569bd151c3806527a2428be FT_modprobe_w_param.3
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.4
+#K= 942e62ca24809cad666c5725aeb14376 FT_modprobe_w_param.5
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.6
+#K= fe1aadca4b2b4165d8d5c98e973f9e4b FT_modprobe_w_param.7
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.8
+#K= 535ab526b24a7214de41d92e94bbd52c FT_modprobe_w_param.9
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.10
+#K= 7c02282dcfb73eb5ffb9629ce63360e5 FT_modprobe_w_param.11
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.12
+#K= b0942decc84dae237019bc2877ff02e7 FT_modprobe_w_param.13
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.14
+#K= efe8e3b8080c3310708b7505d60f7703 FT_modprobe_w_param.15
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.16
+#K= d682c98ced7d31f1555ab474a9ebe253 FT_modprobe_w_param.17
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.18
+#K= 362ab2e7e5f5e3ede8b69645c64fb987 FT_modprobe_w_param.19
+#K= 362ab2e7e5f5e3ede8b69645c64fb987 FT_modprobe_w_param.20
+#K= 4f539816f9cc9fb9dd4a032138e3abde FT_modprobe_w_param.21
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.22
+#K= 20659d16ffb5b18475e83602223216d1 FT_modprobe_w_param.23
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.24
+#K= 0b24971fb1018c38353141f8fcb9cbdc FT_modprobe_w_param.25
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.26
+#K= 66eb387a95512f679eb5cad4168b0992 FT_modprobe_w_param.27
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.28
+#K= 7df05523f4d61917fd7659357eeec1bc FT_modprobe_w_param.29
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.30
+#K= a75600ac4e129f4315c5a50ad3a3103c FT_modprobe_w_param.31
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.32
+#K= f43ccce73ac2b0e1529312af66a4ddfe FT_modprobe_w_param.33
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.34
+#K= 4819f715ba485c493afb455542f7ab8c FT_modprobe_w_param.35
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.36
 EOF
         # Read the K-recs and skip those for tests that can't run
         while read -r line; do

-- 
2.56.0


