Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E758E2A3
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202927; cv=none; b=F/gvOh8Giw2XWFk1mxelhmr/k6I+/yJq4C45oxBPoVo94iACPGEj+UhvBsttOkQlFsIEToyacxu1Z+Dt1THYOl9RfMupW6Rxqp29Oi6ug26BbQGFq00ofuWv4YdvyjRVpU8nGZFP/Y7LRH3mPLkz22XmZiXnq1gVgCU9v9+XaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202927; c=relaxed/simple;
	bh=KrWDmxOWrStkRHpL+/KIB9FoXYHfOygI4SHDT7bhFXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1mJ4yvTaA2zy7CxTh18yzqRzXtzzqlP00AVWyuJ+7t0IUIZmaYeTTIhQ6Wjj8nKXy1qzqRzVxEvTKvV7cJMd0vr6lJVznhs1beqVuA72o7yAsUgaY+aRIAMPy4HgZ8zmFZQsn5mv/zxEg+LdHmzAHuIXR1i7P4siNpxXHE0qTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3IYjwJv; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3IYjwJv"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c13f2685f2so907771b6e.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202922; x=1790807722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nr/TzFpBxiPAgeOlzDTc0obPAfu4uC6jVG1met14EN0=;
        b=o3IYjwJvpWHgHuqBz2A8QzsqiEoOIcT/Lx7iHeCFiBhhJTafWqx4VJv7TkvulC+rGz
         GcDS/NrG4Nqh9XC2tWVMwiTIXr+J4Bkn4rx4eH9nzWCmradNY5wcOLX2la0Ey04jus8+
         qcdmzHZuDdPbW8EzqPAo9sPTYZSCRgbh6c6Q6DTh9WSlcONZjDMHhNvwTeqKEE+LxFR7
         UsaBAs4DsVMdWUMrm9A7GmwFmjewJyLkED/kkxIexPX/yDF1dvjMNEZbebdRWHHbDVYz
         b+GqpXi7lNpEY4qyPZUQfXb+WjeoVM6rjdbShTlqFsX6Oj96dNEp/4wyMhlklQMWkeBA
         9TDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202922; x=1790807722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nr/TzFpBxiPAgeOlzDTc0obPAfu4uC6jVG1met14EN0=;
        b=2TW22q9DgsKK9+DgtjnVIhcpYyyz4ffLaapGav5yefDfEaZ9xP5KVQlsvdhvcnsRzA
         f60324uvsBEGzBH7ORsAAyKeSyPQP4RKPQV52To7YGvqRRRHa4SmUtXGBhRR43cpc+s5
         Bz14JZEPKoCX2cVvT9NfQYuwEW6S5HUy+M/MsVIEEqFTQspT7k1cl4L5Lg3H8e+d9zaN
         3SNH2sTW8Z93JGOP25J++zHmvZWD0zfTx1OqzA+cXcrOgd3Az7iQCv3LGtg5fB1+kbLc
         t+21vE1Gr8+58GBb6cZRvxtwZCg78swPWtOB8nMcdZQ/jccE8HRrayjHUvQcf0sOS1Tf
         +dDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJYWepSsYTUqLgoCv1Mg+NyvTdRjqacn5Fywcp1FDJwlC3acRWIi79fbouy9HbMqvUPmmej4phcw8R@vger.kernel.org
X-Gm-Message-State: AFuF++mLHUbowri64Chccp7OQNOq9MluWidytriNIvmX1zkhL+dFWnIb
	XW7AGFYvGFywXspronHccpml3UF/Qx30vVB2vtHshD7qeR+CHHDYRWtJ
X-Gm-Gg: AYBFou22sChAgU8LZJwkJp9mTD+Lm8ENuDOr6HuOP5yGgUjHsk4tobgbYwhlMvEMu9U
	rTXfEc9xtJtqMEeRDk2aNwI5kj88M/YJI64mz1AU18lZ8BmofQ1LppGDMDpOAP2+LnSmahUBocB
	CezPcH1Igg+ygpbzC5wh4zD3d39ulm6pnQgvrfu+8/7ym2lODZPYObiFv2PEB+S86rkaWjIZFps
	YVTtJyN5y1Z2z2SAo9ncAT4NzQmWS42vhoA8YZO70AJPFQlaEoSqS83jmSREiZuTRAfDAvqegLS
	aC3uCoL2/kraWXpt8gaOWhZ08Y6/fDHcT05VkENPxXM4jYb82G5e88C1iCILf9vyjFsXcvg+Vs5
	5sgCdpTo5c6rd+ZgjCH6rpwNSI7uM66c0rv3U16qQm5plTYOUzB5hfJygKAU4x5QBBH1Y0LZUtK
	PLTBve5vy5uVfrnR/MdMd9RKzpXUVVUIMrep0Ged5K5moaeBlVuKPfi0xVfuh9kIY6nKeNRwD2G
	hrWCzTYlZ86+GXQgRlKc620wCCNaJamBiuk2t8OfOG2CtGgsDtXCujtdqVJJxbw75Esrz6G2ctM
	aIhX2c1lpCHqbQLQg6Q=
X-Received: by 2002:a05:6808:1782:b0:4d6:90f4:48b3 with SMTP id 5614622812f47-4d72ea5cc65mr630880b6e.53.1790202921956;
        Wed, 23 Sep 2026 15:35:21 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:21 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:43 -0600
Subject: [PATCH v11 19/38] dyndbg: reduce class param storage to u32
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-19-9b6c217fdf2f@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=9168;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=KrWDmxOWrStkRHpL+/KIB9FoXYHfOygI4SHDT7bhFXQ=;
 b=n61PSliLWiqYFTJFCREbivlOCHRW/O0VfaREZlJYcE/5TXOyFV10eGLOv06l5yqiOxM555tp2
 0i8/oz+Ph01DQBsV+bUVMe7KNXZbCuiapW9HX1hjU/7sTnX+R6vEVTC
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Currently, `struct ddebug_class_param` uses pointers to `unsigned
long` values which store the state of `bits` and `lvl`, so it changes
sizes depending upon the architecture.  Make it always u32 for
consistency.

The bits field references __drm_debug, which was unsigned int, before
commit f158936b60a7 ("drm: POC drm on dyndbg - use in core, 2 helpers, 3 drivers.")
changed it to unsigned long.  This patch changes it back.

That enlargement was a thinko; although modules can have up to 63
classes, and *could* have put all those classes in a single classmap,
the reason for it is to support multiple classmaps (with
non-overlapping class-id ranges).

32 bits is a practical limit for a class-param's usability since all
classes are set together with a single write of a hex value; 16 would
be a realistic limit, drm.debug has ~12 classes.

  #> echo 0x0fff > /sys/module/drm/parameters/debug

Several followon patches add a number of compile-time validations,
including a num-classes <=32 check.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v8: add a <32 limit to prevent undefined shifts on 32 bit number
v5: u32 for all arches
v4: undo change struct ddebug_class_param to _ddebug_class_param

v3:
fix undefd behavior when classmaps is all 64 bits.
change module_param_named( type-arg from ulong to ullong)
change struct ddebug_class_param to _ddebug_class_param

in drivers/gpu/drm/drm_print.{c,h}
api change later

v2:

patch was "make bits & lvl same size"
but that size was unsigned long, only 32 bits on i386 etc
use u64 for all bits, and %llu %llx

u64-fix

u64-drm-dbg
---
 drivers/gpu/drm/drm_print.c   |  4 ++--
 include/drm/drm_print.h       |  2 +-
 include/linux/dynamic_debug.h |  4 ++--
 lib/dynamic_debug.c           | 37 ++++++++++++++++++++-----------------
 lib/test_dynamic_debug.c      |  2 +-
 5 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 86cef1a37678..794417c62097 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -40,7 +40,7 @@
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
  */
-unsigned long __drm_debug;
+u32 __drm_debug;
 EXPORT_SYMBOL(__drm_debug);
 
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
@@ -56,7 +56,7 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 "\t\tBit 9 (0x200) will enable DRMRES messages (managed resources code)");
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-module_param_named(debug, __drm_debug, ulong, 0600);
+module_param_named(debug, __drm_debug, uint, 0600);
 #else
 /* classnames must match vals of enum drm_debug_category */
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index 2adc5ac688e1..50b3ba0ae76d 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -39,7 +39,7 @@ struct drm_device;
 struct seq_file;
 
 /* Do *not* use outside of drm_print.[ch]! */
-extern unsigned long __drm_debug;
+extern u32 __drm_debug;
 
 /**
  * DOC: print
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 02a1abdc5b3f..27cae68552e5 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -102,8 +102,8 @@ struct _ddebug_info {
 
 struct ddebug_class_param {
 	union {
-		unsigned long *bits;
-		unsigned int *lvl;
+		u32 *bits;
+		u32 *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 84a311fac657..72bfbec0ac02 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -586,6 +586,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 		pr_err("query parse failed\n");
 		return -EINVAL;
 	}
+
 	/* actually go and implement the change */
 	nfound = ddebug_change(&query, &modifiers);
 	v3pr_info_dq(&query, nfound ? "applied" : "no-match");
@@ -636,8 +637,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     const unsigned long *new_bits,
-				     const unsigned long old_bits,
+				     const u32 *new_bits, const u32 old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -647,24 +647,27 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int bi, ct;
 
 	if (*new_bits != old_bits)
-		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("apply bitmap: 0x%x to: 0x%x for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
-	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
+	for (bi = 0; bi < map->length && bi < 32; bi++) {
+		bool new_b = !!(*new_bits & BIT(bi));
+		bool old_b = !!(old_bits & BIT(bi));
+
+		if (new_b == old_b)
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
-			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
+			 new_b ? '+' : '-', dcp->flags);
 
 		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
-		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
+		v2pr_info("bit_%d: %d matches on class: %s -> 0x%x\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
 	if (*new_bits != old_bits)
-		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("applied bitmap: 0x%x to: 0x%x for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	return matches;
@@ -673,7 +676,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 /* stub to later conditionally add "$module." prefix where not already done */
 #define KP_NAME(kp)	kp->name
 
-#define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
+#define CLASSMAP_BITMASK(width) ((width) >= 32 ? ~0U : (1U << (width)) - 1)
 
 /*
  * param-setter helper to validate numeric input, clamp its value by
@@ -685,10 +688,10 @@ static int param_set_dyndbg_module_classes(const char *instr,
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
-	unsigned long inrep, new_bits, old_bits, old_val;
+	u32 inrep, new_bits, old_bits, old_val;
 	int rc, totct = 0;
 
-	rc = kstrtoul(instr, 0, &inrep);
+	rc = kstrtou32(instr, 0, &inrep);
 	if (rc) {
 		int len = strcspn(instr, "\n");
 
@@ -701,26 +704,26 @@ static int param_set_dyndbg_module_classes(const char *instr,
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
 		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
+			pr_warn("%s: input: 0x%x exceeds mask: 0x%x, masking\n",
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
 		old_val = READ_ONCE(*dcp->bits);
-		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		v2pr_info("bits:0x%x > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &inrep, old_val, mod_name);
 		WRITE_ONCE(*dcp->bits, inrep);
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		/* input is bitpos, of highest verbosity to be enabled */
 		if (inrep > map->length) {
-			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
+			pr_warn("%s: level:%u exceeds max:%d, clamping\n",
 				KP_NAME(kp), inrep, map->length);
 			inrep = map->length;
 		}
 		old_val = READ_ONCE(*dcp->lvl);
 		old_bits = CLASSMAP_BITMASK(old_val);
 		new_bits = CLASSMAP_BITMASK(inrep);
-		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
+		v2pr_info("lvl:%u bits:0x%x > %s\n", inrep, new_bits, KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		WRITE_ONCE(*dcp->lvl, inrep);
 		break;
@@ -766,9 +769,9 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
+		return scnprintf(buffer, PAGE_SIZE, "0x%x\n", *dcp->bits);
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%u\n", *dcp->lvl);
 	default:
 		return -1;
 	}
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 74d183ebf3e0..9e8e028461ad 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -40,7 +40,7 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * - tie together sysname, mapname, bitsname, flagsname
  */
 #define DD_SYS_WRAP(_model, _flags)					\
-	static unsigned long bits_##_model;				\
+	static u32 bits_##_model;					\
 	static struct ddebug_class_param _flags##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\

-- 
2.55.0

