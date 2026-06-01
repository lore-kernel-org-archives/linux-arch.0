Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A193A5E7B
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 12:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315548; cv=none; b=cwE3q7SU5smaI1cQmWzl/J1TKfMzRjH6tadUoKfBuXAuxUbnf865byKIHXyhOhHh2Tcdkej7frK1+p4ZtxzOur5YMkA9b74Pj/DbufhmXtM0yeo9HPsGQfxRuIuqCCJNc/m6cpXolMw9bfHjntWqJtp+tt/gFszdf8+wkePtMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315548; c=relaxed/simple;
	bh=V/j5R/K8D4fgtUgreo+1w1Buebew+BCTOgoZDwfl7qQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LWNmmhW5m9Pr1T1Ud6uxY1YB9x60Ea5/yBDIlC4yGlm3oGCLQC4QlIDxNV5txYyhcVrluLfA+h7D2qvvu6j/vLT/3pe9TABpZip7aKbw9IGrW7HneK/JbfRFUXQr9SvBlyIlbPthiA2IA4WI4kMyQpsrQkpmSWjsPSem4jFYz8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mM+D+2ro; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mM+D+2ro"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4905e190c71so92367915e9.3
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 05:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315545; x=1780920345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E8lT2isG6DA0tGp2Ppb+W7ASsvCdkctPNMIenODYem8=;
        b=mM+D+2rorVmgLaDxn6y32IVGyVNmfPIVB1UXuMpuzZ0X1DR4GcLHwj4sNpTq4f97UK
         kvOggEm4EmeXTNc40tbX721cUYfnoG2mLu4tJFELjhfMm/zoRC1mrHfTWfa2pEe18v35
         nkW/cQ7b1scGoRg127nXyIE5nckmq8Tc3QIw6buPcjEUum1hqlH9F24zaGr2yz0wZEO9
         5YEjJWMGnJD3/NbrlQbn57+cZdQ2k+vZWUZ86uckURGnSWEpIpcNKxvcgyPrUyL3UzrC
         Ph6flxku+MNdifDj6uVg1H9u40VReeKxbpKa5lmq9Pb3L3LSlOHIHSh2JnNGZeDd4dg8
         sGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315545; x=1780920345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=E8lT2isG6DA0tGp2Ppb+W7ASsvCdkctPNMIenODYem8=;
        b=Si6RIN/kl++rl9WALZW6vS4vVkGS1/CuUdVMhbUh/757n6tAYq5ShAZYyhE6Lf08dx
         O870nKw9ig4WWVQOnV3+nr2TKWVBVWhFuUU7Jd47rJE/JArkd/QPrvBRDIcj3XZVegyo
         kPqiZpM74vQlN25BVhKqCQQGAkgcfTl7putj5KunFBXG/bek1QA9wysoCqgf9M65VVAZ
         fo5NmW1b8UcukEzPCbrZAOUw68yQiobNAyyf5nyNP4UlBDPHPXoUWATIRikDqk/G0RZp
         84JMc5FeKTfq+FLjd+I7DeCO6kcAkYfGCYnHUaEdSQw4SKYVutAp0Q32yXrLbEjsrLFn
         peoA==
X-Forwarded-Encrypted: i=1; AFNElJ/jzPA6nI9acwjjJjmzJumThy/Lapo/JS0Otsi2KLfDnUGBfTG5BIwsuoHSK+onx+7qquQT8YvwP+FF@vger.kernel.org
X-Gm-Message-State: AOJu0YyUzC8sMPX7PfgVuscRHPIbioknmpkXPz+86jXF19qNEh/WlUa9
	uQ6otcISnWQdxjwNS18yfUfmTWevU9ieK8/0XQ1snjCqkQSVhqzSbr8m
X-Gm-Gg: Acq92OFFPcmClE67WbTdN+GUnTnFC3F5bBZsEz5XMTAfyS573GwfMy/LrsWp25slKUg
	WiR5LAJKujuZJAbpJk32ro231oec+7Za/K8IgQ99r6u3HlV7jlB/108+0yxmCVfss22ODqpS9iK
	X4CpbKjKHmi9jMrfSUCS/8L0/MUCJh3PF6EtYefLgvfTTrkz21PWQ8NgNi282thP1iCL4XC6G+W
	f6fyJ2hoa8C5GcHnWvkBN2CdWF4Cun+Hm5xbQGAPlSVXPkKnuP7iUxkVbZ+K/D0tV8ljn3BRN73
	ycMy3FFK+qG6i3hgdXdiX4m95XqV6Hul4pHVgr0gE4NJ+F3IazTyN5ApUA7J8HbXk0GGPOqh0ZS
	3BZTpZLfhgEEvGGG9dx+FbczcwaqvubxVfQ1IO57YkYzHr/ExdcrPUwc6uwi1W0xR5cSoCOkGzv
	UFzXZlx6HVrOqc309cvVyLybGJZH2CuggBNtKbaT1Vig==
X-Received: by 2002:a05:600c:4714:b0:490:a296:fdad with SMTP id 5b1f17b1804b1-490a296fe25mr177731505e9.24.1780315544455;
        Mon, 01 Jun 2026 05:05:44 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:44 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:05:04 +0000
Subject: [PATCH v3 18/24] dyndbg: Upgrade class param storage to u64 for
 64-bit classmaps
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-18-4a15b241bd3c@gmail.com>
References: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
In-Reply-To: <20260601-dd-maint-2-v3-0-4a15b241bd3c@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=8824;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=V/j5R/K8D4fgtUgreo+1w1Buebew+BCTOgoZDwfl7qQ=;
 b=rrCbvc+2Tbfml1sWLCOFCjhc/nZmY9fPmT7uj76vyn27GRPL2ImSmBmkViL99StldOIuQTWrL
 z9sLI/Y0bNND+hVEShLcIvw2ONz1PcY/Uwa1/gB0Qhr2n8qTL8ImNUk
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Currently, `struct ddebug_class_param` uses `unsigned long` pointers
to store the state of `bits` and `lvl`. On 32-bit architectures, this
limits the bit-vector to 32 bits, which truncates 64-bit classmaps
(such as the one needed by `__drm_debug`).

To guarantee support for 64-bit debug categories across all
architectures, upgrade the internal storage types in `struct
_ddebug_class_param` to `u64`. This inherently makes both union
members the same size while safely avoiding truncation.

This includes:
- Changing union members `bits` and `lvl` to `u64 *`.
- Using `kstrtou64()` for sysfs input parsing.
- Replacing array-based `test_bit()` operations with safe `u64` scalar
  bitwise logic (`!!(val & (1ULL << bi))`).
- adjusting lib/test_dynamic_debug.c too

- Updating `drm_print`'s `__drm_debug` refs to `u64`
  further changes to drm later, when BROKEN is fixed.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v3:

fix undefd behavior when classmaps is all 64 bits.
change struct ddebug_class_param to _ddebug_class_param
change module_param_named( type-arg from ulong to ullong)

in drivers/gpu/drm/drm_print.{c,h}
api change later

v2:

patch was "make bits & lvl same size"
but that size was unsigned long, only 32 bits on i386 etc
use u64 for all bits, and %llu %llx

u64-fix

u64-drm-dbg

_ddebug-cl-parm-drm
---
 drivers/gpu/drm/drm_print.c   |  6 +++---
 include/drm/drm_print.h       |  2 +-
 include/linux/dynamic_debug.h |  4 ++--
 lib/dynamic_debug.c           | 34 ++++++++++++++++++----------------
 lib/test_dynamic_debug.c      |  2 +-
 5 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index ded9461df5f2..9b4d8e3baacc 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -40,7 +40,7 @@
  * __drm_debug: Enable debug output.
  * Bitmask of DRM_UT_x. See include/drm/drm_print.h for details.
  */
-unsigned long __drm_debug;
+u64 __drm_debug;
 EXPORT_SYMBOL(__drm_debug);
 
 MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug category.\n"
@@ -54,7 +54,7 @@ MODULE_PARM_DESC(debug, "Enable debug output, where each bit enables a debug cat
 "\t\tBit 8 (0x100) will enable DP messages (displayport code)");
 
 #if !defined(CONFIG_DRM_USE_DYNAMIC_DEBUG)
-module_param_named(debug, __drm_debug, ulong, 0600);
+module_param_named(debug, __drm_debug, ullong, 0600);
 #else
 /* classnames must match vals of enum drm_debug_category */
 DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
@@ -69,7 +69,7 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_DP",
 			"DRM_UT_DRMRES");
 
-static struct ddebug_class_param drm_debug_bitmap = {
+static struct _ddebug_class_param drm_debug_bitmap = {
 	.bits = &__drm_debug,
 	.flags = "p",
 	.map = &drm_debug_classes,
diff --git a/include/drm/drm_print.h b/include/drm/drm_print.h
index ab017b05e175..21a0ced0b2f2 100644
--- a/include/drm/drm_print.h
+++ b/include/drm/drm_print.h
@@ -39,7 +39,7 @@ struct drm_device;
 struct seq_file;
 
 /* Do *not* use outside of drm_print.[ch]! */
-extern unsigned long __drm_debug;
+extern u64 __drm_debug;
 
 /**
  * DOC: print
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 0443781ed95b..91546a99014b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -91,8 +91,8 @@ struct _ddebug_info {
 
 struct ddebug_class_param {
 	union {
-		unsigned long *bits;
-		unsigned int *lvl;
+		u64 *bits;
+		u64 *lvl;
 	};
 	char flags[8];
 	const struct ddebug_class_map *map;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 41bbb72ef730..7298520a89dc 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -625,8 +625,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 
 /* apply a new class-param setting */
 static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
-				     const unsigned long *new_bits,
-				     const unsigned long old_bits,
+				     const u64 *new_bits, const u64 old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
@@ -636,24 +635,27 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 	int bi, ct;
 
 	if (*new_bits != old_bits)
-		v2pr_info("apply bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("apply bitmap: 0x%llx to: 0x%llx for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	for (bi = 0; bi < map->length; bi++) {
-		if (test_bit(bi, new_bits) == test_bit(bi, &old_bits))
+		bool new_b = !!(*new_bits & (1ULL << bi));
+		bool old_b = !!(old_bits & (1ULL << bi));
+
+		if (new_b == old_b)
 			continue;
 
 		snprintf(query, QUERY_SIZE, "class %s %c%s", map->class_names[bi],
-			 test_bit(bi, new_bits) ? '+' : '-', dcp->flags);
+			 new_b ? '+' : '-', dcp->flags);
 
 		ct = ddebug_exec_queries(query, query_modname);
 		matches += ct;
 
-		v2pr_info("bit_%d: %d matches on class: %s -> 0x%lx\n", bi,
+		v2pr_info("bit_%d: %d matches on class: %s -> 0x%llx\n", bi,
 			  ct, map->class_names[bi], *new_bits);
 	}
 	if (*new_bits != old_bits)
-		v2pr_info("applied bitmap: 0x%lx to: 0x%lx for %s\n", *new_bits,
+		v2pr_info("applied bitmap: 0x%llx to: 0x%llx for %s\n", *new_bits,
 			  old_bits, query_modname ?: "'*'");
 
 	return matches;
@@ -662,7 +664,7 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 /* stub to later conditionally add "$module." prefix where not already done */
 #define KP_NAME(kp)	kp->name
 
-#define CLASSMAP_BITMASK(width) ((1UL << (width)) - 1)
+#define CLASSMAP_BITMASK(width) ((width) == 64 ? ~0ULL : (1ULL << (width)) - 1)
 
 /**
  * param_set_dyndbg_classes - class FOO >control
@@ -682,10 +684,10 @@ static int param_set_dyndbg_module_classes(const char *instr,
 {
 	const struct ddebug_class_param *dcp = kp->arg;
 	const struct ddebug_class_map *map = dcp->map;
-	unsigned long inrep, new_bits, old_bits;
+	u64 inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
-	rc = kstrtoul(instr, 0, &inrep);
+	rc = kstrtou64(instr, 0, &inrep);
 	if (rc) {
 		int len = strcspn(instr, "\n");
 		pr_err("expecting numeric input, not: %.*s > %s\n",
@@ -697,24 +699,24 @@ static int param_set_dyndbg_module_classes(const char *instr,
 	case DD_CLASS_TYPE_DISJOINT_BITS:
 		/* expect bits. mask and warn if too many */
 		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%lx exceeds mask: 0x%lx, masking\n",
+			pr_warn("%s: input: 0x%llx exceeds mask: 0x%llx, masking\n",
 				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
 			inrep &= CLASSMAP_BITMASK(map->length);
 		}
-		v2pr_info("bits:0x%lx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
+		v2pr_info("bits:0x%llx > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &inrep, *dcp->bits, mod_name);
 		*dcp->bits = inrep;
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
 		/* input is bitpos, of highest verbosity to be enabled */
 		if (inrep > map->length) {
-			pr_warn("%s: level:%ld exceeds max:%d, clamping\n",
+			pr_warn("%s: level:%llu exceeds max:%d, clamping\n",
 				KP_NAME(kp), inrep, map->length);
 			inrep = map->length;
 		}
 		old_bits = CLASSMAP_BITMASK(*dcp->lvl);
 		new_bits = CLASSMAP_BITMASK(inrep);
-		v2pr_info("lvl:%ld bits:0x%lx > %s\n", inrep, new_bits, KP_NAME(kp));
+		v2pr_info("lvl:%llu bits:0x%llx > %s\n", inrep, new_bits, KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &new_bits, old_bits, mod_name);
 		*dcp->lvl = inrep;
 		break;
@@ -760,9 +762,9 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		return scnprintf(buffer, PAGE_SIZE, "0x%lx\n", *dcp->bits);
+		return scnprintf(buffer, PAGE_SIZE, "0x%llx\n", *dcp->bits);
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		return scnprintf(buffer, PAGE_SIZE, "%d\n", *dcp->lvl);
+		return scnprintf(buffer, PAGE_SIZE, "%llu\n", *dcp->lvl);
 	default:
 		return -1;
 	}
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 74d183ebf3e0..c049580d2152 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -40,7 +40,7 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * - tie together sysname, mapname, bitsname, flagsname
  */
 #define DD_SYS_WRAP(_model, _flags)					\
-	static unsigned long bits_##_model;				\
+	static u64 bits_##_model;					\
 	static struct ddebug_class_param _flags##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\

-- 
2.54.0

