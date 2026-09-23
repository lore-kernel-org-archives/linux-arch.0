Received: from mail-oa2-f36.google.com (mail-oa2-f36.google.com [74.125.231.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C0558FD0E
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202948; cv=none; b=AEggV2mFkJ+YPBvCGQ3HxbCsPBiR3Bel/bElxVfErYjuVmKD5mqoybWIzhaECCeOLmmItplAbxhyWQSdWGZ4p5sJbNBOd1ogds3F3TdnxEpEflfFxanK03NIq9f3MZXpNkr6KRYLq4+bgOEW56mAL4c4iW5oxgHUCj9fmEGvuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202948; c=relaxed/simple;
	bh=6vN+bh7QpMvS2WOCyfNSsA8erGoaCKBOvQy+uSBGScY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+F7F5S/8fk9VCeGRlb/PVBlAbb1rxDiesPZAIOll0WpzJrbWOmgYBSOxR4TT9KrIIp6lwB6gAGayfp/aoTuYaslLSa1KOjPNGFzHqiSvW660wfqbJKqZvoRcoHcftVvYli3yHJAPK//xa72s4ytltrBZRtXu2uSR01BHzZNtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4aPhb+/; arc=none smtp.client-ip=74.125.231.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4aPhb+/"
Received: by mail-oa2-f36.google.com with SMTP id 586e51a60fabf-466ccbd478bso730152fac.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202940; x=1790807740; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xkZs5lG18crbjgoBOMGomisipWTrmZK8zFV59Prv94=;
        b=i4aPhb+/kL8vX+3A1t3POUqT5Klefjc2A0mgFGqA4mph0EF880DpzT0c9LLK8TjpFk
         fBlmI43rI2MLUIlfhUStN3L2QcqNbV8RO9cuAa+jlFj9XLcvn6G1r9JYxhU1kOEQXD6Z
         Tb7GEmOW5EjuEbTfrrfgrdYqENOVA6o4l0SXY5zAgidTKsWsCqZV4beHBJdlpVCBy/fy
         YkNxT0cVehaUNvKTVGI8Z13iGEMV2o4Td4w+cSNxLEzoo8U7jgH7tx22q1WOyh8UyE1H
         zdVrN4/+y9ivSqzGR941sngVHbVSK+upR0Q9wcEQ5ljWnnN7QQNoBCMF4UBeXf++zESO
         I+QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202940; x=1790807740;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6xkZs5lG18crbjgoBOMGomisipWTrmZK8zFV59Prv94=;
        b=X3H81wIxGSzEi1xmPdBP1m3JT74CfA3blBJ8dC5yp3OBSN6MfemBI+lrSmHDVyiq0o
         lanO64ob339mbNCtsUM3y6qyRrbXQ/i/5XIh/0II34H/mu6i6Qb1W8NYI3+Slw/6fuTG
         F2/Ur21SV8TdtcKZjosS5svYLz22aHD+D790zKpbvX0comwsqu9y//NnvcxCEyyiafiA
         WBGD0a1jGNA0tkXdimKtFlNLCxFF9tqOm7ahtRuwEwbXdeqR9RwP/JxwOqo/Rm7q93b+
         F/Bt8ltyqhwVkSbQEZ78b1IyUrMHA3wW8/E1OGgZbKiwtng4pUWrCREcsnhKZeYevyPE
         KfoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgJv8UJt9hEQw9tCUEa5dXl9FtBayf1s9EfFEY+XcZtqbO5RGKYBPQSFxacoOLkIWnew/sR5PhvJNP@vger.kernel.org
X-Gm-Message-State: AFuF++nM4w8YG8H46StYVwgwNIQBl6xa1//WqyU6mm/gDbdxJAlVGHtG
	58VZVLK0bugWJI3QgPcgMgRBpQWUy8bDaUbBXV9VoPe4leApCNeHIZ1F
X-Gm-Gg: AYBFou1rETskhV8NBGcjn+M6SGtYmZh1u4TWdI0qi/3FgtL2D7MFzNtM7z0PxC8exjk
	/yQPrJIvf225M4hJU3trnhzVMvWRExQWwwRXh7LBkPOrQH6rtvMA1EXkS4dvN7gC3iDAAHhCWIJ
	+9mqTVHp6htp58L7oQxouLJiIE6jgF+wSiuHoIsrWFk/+6lU22dPZ6wEEt0RcRNFI8uJcXUGwhy
	hNSFcDe69Sh2M+ZJJ3irmKoX51psOQ2PinDCivTy9kXUPd/f89V+7DbwwYudDXmRWKQMASAFFhn
	3zS62VFqeT4hrIF3KYkvQRp6ksboCYyJr1z6psO1q4+GdG+qoSo9CrVPKbCvxFtSX6chrFxQSMP
	tZk/AH1rNVm3iREwbuYQYB5afdNOB1odu5SRDYZ6G7w/UaFo+Y98ZnMVvuxc+bKSZdLeOl07dBv
	hf1ZqnpgzvDFWuO+Bw0//IhR1LJXlBltnHgadmaYgCmgS6hYrnxsI7CitQymu61wYVjPlZpPDxa
	7mlYme0Eh5OOYyJGYhxd3+UhAHnyZMPcS8tZTRW3O/VYadf0xVK0wYktWh/8djpOj3iXmnmy49n
	vyZkiapdJqLLqEGPKoY=
X-Received: by 2002:a05:6870:670d:b0:48f:e0f6:c460 with SMTP id 586e51a60fabf-491eba6d4c1mr578123fac.46.1790202940508;
        Wed, 23 Sep 2026 15:35:40 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:40 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:51 -0600
Subject: [PATCH v11 27/38] dyndbg-test: add do_bulk testpoint, rename
 do_prints to do_classes
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-27-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
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
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=19866;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=6vN+bh7QpMvS2WOCyfNSsA8erGoaCKBOvQy+uSBGScY=;
 b=8PV7Z8Sy4li8tfO6XdVeK4hjchL0oix0aSQCHe+LRZhOUrnWAPdRtPeMKofw4GRMvy1EMxx9z
 5c5ZygXGdI6BoOlwBQyBJoC08YbPGw3PP+lA/X9kv+tmeJPBrSRtB7v
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

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
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 170 +++++++++++++++++----
 2 files changed, 275 insertions(+), 57 deletions(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 01ce07001d4c..19e27b5747ac 100644
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
+DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 7);
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
index 5a805cb30e6c..431856849285 100755
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
@@ -326,19 +379,17 @@ function FT_classmap_inheritance {
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
 
-    # Real-time mathematical proof that load-time (modprobe) parameter parsing
-    # and runtime (sysfs write) parameter configurations are perfectly equivalent!
+    # 5. Prove load-time (modprobe) and runtime (sysfs write) parameter equivalence
     local hash_modprobe=$(slice_and_hash_ddctrl '\[test_dynamic_debug\]')
 
-    # Fresh load with default parameters, then configure them dynamically at runtime
     ifrmmod test_dynamic_debug_submod
     ifrmmod test_dynamic_debug
     my_modprobe test_dynamic_debug
@@ -354,16 +405,43 @@ function FT_classmap_inheritance {
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
@@ -373,7 +451,9 @@ builtin_tests=(
 
 # Modular Feature Tests (Require CONFIG_MODULES=y and test_dynamic_debug*.ko available)
 modular_tests=(
+    FT_test_classes
     FT_classmap_inheritance
+    FT_modprobe_w_param
 )
 
 # ==============================================================================
@@ -457,14 +537,50 @@ function GOLDEN_RECORDS {
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
+#K= 81b16613f8d444485e2bc5aa4d38d024 FT_classmap_inheritance.1
+#K= c14c8aa758e24046b3237d20e2189bf7 FT_classmap_inheritance.2
+#K= 5d0f3701517aa3a461c8887c332bdb42 FT_classmap_inheritance.3
+#K= f444ae312fcce32444c54da757d87c41 FT_classmap_inheritance.4
+#K= 7e92245008439ee79fe2460aeaa16a9b FT_classmap_inheritance.5
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
+#K= a71670fec42b1b0646f0317180bafcc7 FT_modprobe_w_param.11
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.12
+#K= aacdbab171b374f221f0196e6e415d09 FT_modprobe_w_param.13
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.14
+#K= c7eb8e25c780f58c78ed73dc1c187a02 FT_modprobe_w_param.15
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
+#K= 2583cb4637bcc2ce1e93eea4222ec76c FT_modprobe_w_param.29
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.30
+#K= d592c5bf23312e705b39064c21ca68e4 FT_modprobe_w_param.31
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.32
+#K= b44d105d151123c93cfe953bacdb573f FT_modprobe_w_param.33
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.34
+#K= 4819f715ba485c493afb455542f7ab8c FT_modprobe_w_param.35
+#K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.36
 EOF
         # Read the K-recs and skip those for tests that can't run
         while read -r line; do

-- 
2.55.0

