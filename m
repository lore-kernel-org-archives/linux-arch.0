Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD9458FD22
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202951; cv=none; b=d7wBsvUMA2YW0bXqG66S32XxNdx7aqqXxYU3+CVjgCUXkJGBCEXTjhoG+mvLc6boxjh42Wmeh8mg/YD7s8XesDdIi7KrftnWnoLIMjt1hJiEZ3HI7lzbM1r7T8KwunQCaCYzSi4CK2R8+yZ6UkBSqqtq9tlyHZT48aHLIOcpyD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202951; c=relaxed/simple;
	bh=v4b0HF3aaCqwilGnai5p2nl4IMNcW/XTp46b3bMJKFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DFySnN4AX1qMt66q7/jej69OiLHk8AdNLI0sxTSdYyo17LXeaesgFy4WmSKPoyf608NRBH+FfGV8qZwfp85GOD3d62nvnYUsWWLwsh63nntQhL6ym65zvDPSNsviwma6GN1LGs/C+F6ApJ9BMcvagFnKKuGh/Pvca67X5ovliQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RJkBVrBv; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJkBVrBv"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae721872so758754eaf.1
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202943; x=1790807743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ty8MsDj8ugeSJQbJdwN7JHIdrMF2PDjZjwC7tBlFMGU=;
        b=RJkBVrBv1MalfGwtOtoP0J6orH7SAis97LjOuxZX+UMd7LQOEfpbTEGEf0GKpA9xU9
         w26oEIpRvI6jY8mMqZF0ZUe5wkZdyFSHdxbprbvYQxD99JKFTggMyi64arrvX/PYoGyB
         W8HoqhQcgXM9m31O5qqidUn9Gm+mM9DraTGQnde27WS3T5d6lTNjniWpehbaHy7odFPm
         jnokdL1epyWpwPMphqohlN1iPWAgUhImuV5yaCYewU/PMVeIt5AzN8hRXNSfsZAJCsJX
         epfmRRr6ZLkvD9iOiAGNBIlWn23kuzcWu3JVoDH0tyIjYYFxSFn+fwFZ8ebYUqO5B/hS
         1XSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202943; x=1790807743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ty8MsDj8ugeSJQbJdwN7JHIdrMF2PDjZjwC7tBlFMGU=;
        b=No2niUX53Cyl06l+nVQbDTs6qtJ/h9iM0xrm5iWSjjKm4PPfGb13CYIB3A8b6dY8nd
         hA/39LYt6p6BOa2h1ulTZAdTXYensnZIeUbxirTgG/58JR/VypIq2DxPokSFkNg4most
         f5G4/FrgX9sljeRgO/FNEp1gZlvBzAzY/1POPoNrkW+QVueigjw4Xek8JhtjOcynYAaq
         uCpkQIAnzivb+6DHmXypbhU6AzS2R47Bnz3R+49IvOVsDcSydHhsJJn7RTz3uCKwpIyv
         /4MSbZFcNVne6LmCxxkWWUODEm7iZbH45wetIGey5DBWLhJ9C11aryxVbRXfKf0ZxIrN
         EeVw==
X-Forwarded-Encrypted: i=1; AKwUvBx1Upnwhb+PoQcVZxxrRa3VTBaPu4pYY51xfAWENz3yDXQXPPOYOwi+7F/KUSZu3A0vccONAymtvzm/@vger.kernel.org
X-Gm-Message-State: AFuF++ltoW09AxQEdZoISm5tFoEhvC/9xOJizetkJpE7+4vlFCxAnsls
	zdhjLvoW6rD6SjSPfmEI768MiktUfeJpmm8JjU3Yrp1Pzq7ZfV+hp9Xi
X-Gm-Gg: AYBFou2LBcn0NEqgzLuruKwIauCeythtdfrDUBzO1SQUa/D2ZAjWnrc6Cm+IRvJKcUW
	3gM3qlXfW6Q4USccw2tfxUxNv0CISu7tLXHT3+d/4vXL7P0Zo7DKd0fXaVlixLbgRk55NVO8kBD
	2FsNA3il0o9JeCxjQ5KWtKTnYQqa27pKb/ezo8ycIqVnNkuw0v9efnhcjS9vidXzrGNjZ99WuSy
	EXD26klFq7YpKyOS14VGypNuFKuqTCinEvw9Y3Z1Fy2GiTKhEAbEeO9po2sqtty5PB1u4ogA5Z0
	wCzDJ54x92gT/nmRet6gkA4sF3ASE1gHuyJIPW+4smDADjVy1bjtMIrT1ymvCLcQ4n0THDN9Vtf
	jD5BFX1mQj3zYGhHUaA759YAhnFE+hxS/dFaaD7LxOLU0eo+Nj/aZ5IlLajdbBedpXKG7G2lNHj
	h/XaS0ynJ0fsTO1fTRXhqgfLvvVcj0oXALKncb5hbWcbR+IxrkNB7mRV0lZZBvn73epXxGzBAiM
	kh86aHqAcuFwaGR2jTNgFvgfpjsDJ+SiBX1jd1L6lld+1Zm6yrWHbgW2USyy/zotLA/UbUkjjZd
	HvQwIvt6PznKoShqD2E=
X-Received: by 2002:a05:6820:627:b0:6b3:b321:a56e with SMTP id 006d021491bc7-6d43f2c4526mr708798eaf.19.1790202942855;
        Wed, 23 Sep 2026 15:35:42 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:42 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:52 -0600
Subject: [PATCH v11 28/38] dyndbg-API: promote DYNAMIC_DEBUG_CLASSMAP_PARAM
 to API
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-28-9b6c217fdf2f@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=15157;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=v4b0HF3aaCqwilGnai5p2nl4IMNcW/XTp46b3bMJKFo=;
 b=kwK6X1Yaj4FJcTts/ujrJaBkXdET6hobyXNm9IOLPHdDldhroGuVz88QuoBguGNHk7YuLNDB3
 tbWvWU4mEMHCoCE8uz5CRZbMN2NP/IqDHIkrszYns0SIl7XSEeIqtZk
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

move the DYNAMIC_DEBUG_CLASSMAP_PARAM macro from test-dynamic-debug.c into
the header, and refine it, by distinguishing the 2 use cases:

1.DYNAMIC_DEBUG_CLASSMAP_PARAM_REF
    for DRM, to pass in extern __drm_debug by name.
    dyndbg keeps bits in it, so drm can still use it as before

2.DYNAMIC_DEBUG_CLASSMAP_PARAM
    new user (test_dynamic_debug) doesn't need to share state,
    declares a u32 to store the bitvec.

__DYNAMIC_DEBUG_CLASSMAP_PARAM
   bottom layer - allocate,init a ddebug-class-param, module-param-cb.

Also add stub macros, clean up and improve comments in test-code, and
add MODULE_DESCRIPTIONs.

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v11:
. drop redundant _DPRINTK_CLASSBITS_INIT redefinition in #else block,
  fixing -Wmacro-redefined warning.
  Sashiko review complaint (patch 28):
  "Does this redefine _DPRINTK_CLASSBITS_INIT when CONFIG_DYNAMIC_DEBUG
  is disabled? The macro is already defined unconditionally earlier in
  this file (just before the flags field of struct _ddebug), which
  causes a -Wmacro-redefined compiler warning."

v10:
. define _DPRINTK_CLASSBITS_INIT and initialize static state bitvector.
. add module_param_named fallback for DYNAMIC_DEBUG_CLASSMAP_PARAM* in !CONFIG_DYNAMIC_DEBUG.

v9:
. fix 4-argument signature for DYNAMIC_DEBUG_CLASSMAP_PARAM_REF fallback macro stub.
. update format specifier from %d to %u for inrep in ddebug_class_param_clamp_input().
. drop duplicate v2pr_info() line in param_set_dyndbg_module_classes().
. drop unused CLASSMAP_BITMASK(width, base) define in test_dynamic_debug.c.
---
 include/linux/dynamic_debug.h                      | 45 +++++++++++++
 lib/dynamic_debug.c                                | 75 +++++++++++-----------
 lib/test_dynamic_debug.c                           | 55 ++++++----------
 lib/test_dynamic_debug_submod.c                    |  9 ++-
 .../selftests/dynamic_debug/dyndbg_selftest.sh     |  2 +-
 5 files changed, 111 insertions(+), 75 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 26c858588eb1..686060c13692 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -60,6 +60,8 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
+#define _DPRINTK_CLASSBITS_INIT ((_DPRINTK_FLAGS_DEFAULT & _DPRINTK_FLAGS_PRINT) ? ~0U : 0U)
+
 	unsigned int flags:8;
 #ifdef CONFIG_JUMP_LABEL
 	union {
@@ -286,6 +288,44 @@ struct ddebug_class_param {
 		.offset = _offset					\
 	}
 
+/**
+ * DYNAMIC_DEBUG_CLASSMAP_PARAM - control a ddebug-classmap from a sys-param
+ * @_name:  sysfs node name
+ * @_var:   name of the classmap var defining the controlled classes/bits
+ * @_flags: flags to be toggled, typically just 'p'
+ *
+ * Creates a sysfs-param to control the classes defined by the
+ * exported classmap, with bits 0..N-1 mapped to the classes named.
+ * This version keeps class-state in a private long int.
+ */
+#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _var, _flags)		\
+	static u32 _name##_bvec = _DPRINTK_CLASSBITS_INIT;		\
+	__DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _name##_bvec, _var, _flags)
+
+/**
+ * DYNAMIC_DEBUG_CLASSMAP_PARAM_REF - wrap a classmap with a controlling sys-param
+ * @_name:  sysfs node name
+ * @_bits:  name of the module's u32 bit-vector, ex: __drm_debug
+ * @_var:   name of the (exported) classmap var defining the classes/bits
+ * @_flags: flags to be toggled, typically just 'p'
+ *
+ * Creates a sysfs-param to control the classes defined by the
+ * exported clasmap, with bits 0..N-1 mapped to the classes named.
+ * This version keeps class-state in user @_bits.  This lets drm check
+ * __drm_debug elsewhere too.
+ */
+#define DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)	\
+	__DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _bits, _var, _flags)
+
+#define __DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _bits, _var, _flags)	\
+	static struct ddebug_class_param _name##_##_flags = {		\
+		.bits = &(_bits),					\
+		.flags = #_flags,					\
+		.map = &(_var),						\
+	};								\
+	module_param_cb(_name, &param_ops_dyndbg_classes,		\
+			&_name##_##_flags, 0600)
+
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
@@ -469,6 +509,11 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)
 #define DYNAMIC_DEBUG_CLASSMAP_USE(_var)
 #define DYNAMIC_DEBUG_CLASSMAP_USE_(_var, _offset)
+#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _var, _flags)		\
+	static u32 _name##_bvec = _DPRINTK_CLASSBITS_INIT;		\
+	module_param_named(_name, _name##_bvec, uint, 0600)
+#define DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)	\
+	module_param_named(_name, _bits, uint, 0600)
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
 #define DECLARE_DYNDBG_CLASSMAP(...)
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 64ad70738d95..8eef2e7387a9 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -698,9 +698,42 @@ static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
 
 #define CLASSMAP_BITMASK(width) ((width) >= 32 ? ~0U : (1U << (width)) - 1)
 
-/*
- * param-setter helper to validate numeric input, clamp its value by
- * the classmap type and size, and apply the bits.
+static void __maybe_unused ddebug_class_param_clamp_input(u32 *inrep, const struct kernel_param *kp)
+{
+	const struct ddebug_class_param *dcp = kp->arg;
+	const struct ddebug_class_map *map = dcp->map;
+
+	switch (map->map_type) {
+	case DD_CLASS_TYPE_DISJOINT_BITS:
+		/* expect bits. mask and warn if too many */
+		if (*inrep & ~CLASSMAP_BITMASK(map->length)) {
+			pr_warn("%s: input: 0x%x exceeds mask: 0x%x, masking\n",
+				KP_NAME(kp), *inrep, CLASSMAP_BITMASK(map->length));
+			*inrep &= CLASSMAP_BITMASK(map->length);
+		}
+		break;
+	case DD_CLASS_TYPE_LEVEL_NUM:
+		/* input is bitpos, of highest verbosity to be enabled */
+		if (*inrep > map->length) {
+			pr_warn("%s: level:%u exceeds max:%d, clamping\n",
+				KP_NAME(kp), *inrep, map->length);
+			*inrep = map->length;
+		}
+		break;
+	}
+}
+
+/**
+ * param_set_dyndbg_classes - class FOO >control
+ * @instr: string echo>d to sysfs, input depends on map_type
+ * @kp:    kp->arg has state: bits/lvl, map, map_type
+ * @mod_name: module name or null for all modules with the classes
+ *
+ * Enable/disable prdbgs by their class, as given in the arguments to
+ * DECLARE_DYNDBG_CLASSMAP.  For LEVEL map-types, enforce relative
+ * levels by bitpos.
+ *
+ * Returns: 0 or <0 if error.
  */
 static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
@@ -719,27 +752,16 @@ static int param_set_dyndbg_module_classes(const char *instr,
 		       len, instr, KP_NAME(kp));
 		return -EINVAL;
 	}
+	ddebug_class_param_clamp_input(&inrep, kp);
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
-		/* expect bits. mask and warn if too many */
-		if (inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%x exceeds mask: 0x%x, masking\n",
-				KP_NAME(kp), inrep, CLASSMAP_BITMASK(map->length));
-			inrep &= CLASSMAP_BITMASK(map->length);
-		}
 		old_val = READ_ONCE(*dcp->bits);
 		v2pr_info("bits:0x%x > %s.%s\n", inrep, mod_name ?: "*", KP_NAME(kp));
 		totct += ddebug_apply_class_bitmap(dcp, &inrep, old_val, mod_name);
 		WRITE_ONCE(*dcp->bits, inrep);
 		break;
 	case DD_CLASS_TYPE_LEVEL_NUM:
-		/* input is bitpos, of highest verbosity to be enabled */
-		if (inrep > map->length) {
-			pr_warn("%s: level:%u exceeds max:%d, clamping\n",
-				KP_NAME(kp), inrep, map->length);
-			inrep = map->length;
-		}
 		old_val = READ_ONCE(*dcp->lvl);
 		old_bits = CLASSMAP_BITMASK(old_val);
 		new_bits = CLASSMAP_BITMASK(inrep);
@@ -1237,30 +1259,7 @@ static inline u32 ddebug_class_param_to_bits(const struct ddebug_class_param *dc
 	}
 }
 
-static void __maybe_unused ddebug_class_param_clamp_input(u32 *inrep, const struct kernel_param *kp)
-{
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
 
-	switch (map->map_type) {
-	case DD_CLASS_TYPE_DISJOINT_BITS:
-		/* expect bits. mask and warn if too many */
-		if (*inrep & ~CLASSMAP_BITMASK(map->length)) {
-			pr_warn("%s: input: 0x%x exceeds mask: 0x%x, masking\n",
-				KP_NAME(kp), *inrep, CLASSMAP_BITMASK(map->length));
-			*inrep &= CLASSMAP_BITMASK(map->length);
-		}
-		break;
-	case DD_CLASS_TYPE_LEVEL_NUM:
-		/* input is bitpos, of highest verbosity to be enabled */
-		if (*inrep > map->length) {
-			pr_warn("%s: level:%d exceeds max:%d, clamping\n",
-				KP_NAME(kp), *inrep, map->length);
-			*inrep = map->length;
-		}
-		break;
-	}
-}
 
 /*
  * Called for class-users and native classmaps during module load.
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 19e27b5747ac..ea81c5158b13 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Kernel module for testing dynamic_debug
+ * Kernel module to test/demonstrate dynamic_debug features,
+ * particularly classmaps and their support for subsystems like DRM.
  *
  * Authors:
  *      Jim Cromie	<jim.cromie@gmail.com>
@@ -80,33 +81,6 @@ static const struct kernel_param_ops param_ops_do_repeats = {
 module_param_cb(do_classes, &param_ops_do_repeats, do_classes, 0600);
 module_param_cb(do_bulk, &param_ops_do_repeats, do_bulk, 0600);
 
-/*
- * Using the CLASSMAP api:
- * - classmaps must have corresponding enum
- * - enum symbols must match/correlate with class-name strings in the map.
- * - base must equal enum's 1st value
- * - multiple maps must set their base to share the 0-30 class_id space !!
- *   (build-bug-on tips welcome)
- * Additionally, here:
- * - tie together sysname, mapname, bitsname, flagsname
- */
-#define DYNAMIC_DEBUG_CLASSMAP_PARAM_(_model, _flags, _init)		\
-	static u32 bits_##_model = _init;				\
-	static struct ddebug_class_param _flags##_##_model = {		\
-		.bits = &bits_##_model,					\
-		.flags = #_flags,					\
-		.map = &map_##_model,					\
-	};								\
-	module_param_cb(_flags##_##_model, &param_ops_dyndbg_classes,	\
-			&_flags##_##_model, 0600)
-#ifdef DEBUG
-#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_model, _flags)		\
-	DYNAMIC_DEBUG_CLASSMAP_PARAM_(_model, _flags, ~0)
-#else
-#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_model, _flags)		\
-	DYNAMIC_DEBUG_CLASSMAP_PARAM_(_model, _flags, 0)
-#endif
-
 /*
  * Demonstrate/test DISJOINT & LEVEL typed classmaps with a sys-param.
  *
@@ -140,12 +114,15 @@ enum cat_level_num { V1 = 16, V2, V3, V4, V5, V6, V7, V8 };
 /* test _USE_ w offset */
 enum cat_level_offset { Vu1 = V1 + 8, Vu2, Vu3, Vu4, Vu5, Vu6, Vu7, Vu8 };
 
-/* recapitulate DRM's multi-classmap setup */
+/*
+ * use/demonstrate multi-module-group classmaps, as for DRM
+ */
 #if !defined(TEST_DYNAMIC_DEBUG_SUBMOD)
 /*
- * In single user, or parent / coordinator (drm.ko) modules, define
- * classmaps on the client enums above, and then declares the PARAMS
- * ref'g the classmaps.  Each is exported.
+ * For module-groups of 1+, define classmaps with names (stringified
+ * enum-symbols) copied from above. 1-to-1 mapping is recommended.
+ * The classmap is exported, so that other modules in the group can
+ * link to it and control their prdbgs.
  */
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
 			      D2_CORE,
@@ -163,6 +140,15 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 			      V1, "V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8");
 
+/*
+ * for use-cases that want it, provide a sysfs-param to set the
+ * classes in the classmap.  It is at this interface where the
+ * "v3>v2" property is applied to DD_CLASS_TYPE_LEVEL_NUM inputs.
+ */
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM(p_disjoint_bits,	map_disjoint_bits, p);
+DYNAMIC_DEBUG_CLASSMAP_PARAM(p_level_num,	map_level_num, p);
+
 #ifdef FORCE_CLASSID_CONFLICT
 /*
  * Enable with -Dflag on compile to test overlapping class-id range
@@ -171,6 +157,7 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
 DYNAMIC_DEBUG_CLASSMAP_DEFINE(classid_range_conflict, 0, D2_CORE + 1, "D3_CORE");
 #endif
 
+
 #if defined(DD_MACRO_ARGCHECK)
 /*
  * Exersize compile-time arg-checks in DYNAMIC_DEBUG_CLASSMAP_DEFINE.
@@ -204,8 +191,6 @@ DYNAMIC_DEBUG_CLASSMAP_USE_(fail_offset_big, 100);
 /*
  * now add the sysfs-params to both sub/super-mods
  */
-DYNAMIC_DEBUG_CLASSMAP_PARAM(disjoint_bits, p);
-DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
 
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
@@ -339,5 +324,5 @@ module_init(test_dynamic_debug_init);
 module_exit(test_dynamic_debug_exit);
 
 MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
-MODULE_DESCRIPTION("Kernel module for testing dynamic_debug");
+MODULE_DESCRIPTION("test/demonstrate dynamic-debug features");
 MODULE_LICENSE("GPL");
diff --git a/lib/test_dynamic_debug_submod.c b/lib/test_dynamic_debug_submod.c
index 672aabf40160..3adf3925fb86 100644
--- a/lib/test_dynamic_debug_submod.c
+++ b/lib/test_dynamic_debug_submod.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Kernel module for testing dynamic_debug
+ * Kernel module to test/demonstrate dynamic_debug features,
+ * particularly classmaps and their support for subsystems, like DRM,
+ * which defines its drm_debug classmap in drm module, and uses it in
+ * helpers & drivers.
  *
  * Authors:
  *      Jim Cromie	<jim.cromie@gmail.com>
@@ -12,3 +15,7 @@
  */
 #define TEST_DYNAMIC_DEBUG_SUBMOD
 #include "test_dynamic_debug.c"
+
+MODULE_DESCRIPTION("test/demonstrate dynamic-debug subsystem support");
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_LICENSE("GPL");
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 431856849285..6f1d11828b79 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -539,7 +539,7 @@ function GOLDEN_RECORDS {
 #K= c518a50ba30ba8099d0dc874a27ecf16 FT_basic_queries.7
 #K= 2b4b152bdb82e6e4a5be18ca26025895 FT_test_classes.1
 #K= 5516e3d13cba7ea4197a7fb6c033887a FT_test_classes.2
-#K= 37dc0919cb1c0ee8ba00ad2ad77ba7c3 FT_test_classes.3
+#K= 2cee6842c9cdee5cb3bf50b2e3914813 FT_test_classes.3
 #K= 81b16613f8d444485e2bc5aa4d38d024 FT_classmap_inheritance.1
 #K= c14c8aa758e24046b3237d20e2189bf7 FT_classmap_inheritance.2
 #K= 5d0f3701517aa3a461c8887c332bdb42 FT_classmap_inheritance.3

-- 
2.55.0

