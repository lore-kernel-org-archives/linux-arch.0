Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132550;
	b=PtOTVTSMKgGSh12UE5M6tYzoxVO0qqdCQkHHx16YoknMiK+xy1TUUPeFcnjd2QNQhoj5
	 TMxQ0bCkjW45SX6eOxhzkQuGEkXUg8DdfO7zSayNDFL+zQSa2IavUAW+pbsH2PWkcANUM
	 E9KCFBis1nIlY+71tTrcGlJa5KFf3xNtljO6Pzzr0lPXRf1W/Un+fXRpj6yJwLO5FdSZt
	 FBJtYGgwq0nMCKlOMnh4mjJe61RewzHEyNxkwjVtP14530Pj76yM+OYgCxprp5RTsQrFX
	 dO5624FYbTUeYF6uEfMb3Ju4nYuvKb7cpb1oHP+d6JxxFVrNOn9LclzWDAjGOjCfwjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132550;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dn0sv0VzM9xwN3Gvmx3w28aY4Lr3hETox+wczTSoBts=;
	b=H1t+xEWU1CevzSdMUUitTiZhqaOdg0Fr5mX4Xw6vHrlG9t0ghvzyGmAgFUggAgCZfJPz
	 FXqay0lEkqSJ70s2lPiGf2Vl/eO+n4zjFCqwcJ89w+MteCO4mp1S/EWAwTHyOaNic3fnU
	 jbUDGtRkP4AJSxRAc6S7hpdPPDtIYSHSvK0uGLz4tVFKHDud1yo6Y72yP7bIJ8VikJCz7
	 M0zBli1/Fuw9QucEQHtiao+jfHTJMroQy1JQATRWVhuE4NCnGzNR69WzVJFvyJoT4kxlI
	 ioe501GslkCBeuRh4iCmLTgHYex1I0r74hB09Xt52jWlUZhoDvTifBpbDyX1f+CTRRg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2xUF3N2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D782607356C;
	Tue, 27 Oct 2026 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2xUF3N2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132549;
	b=rFE2l70SpC5ZQL0gMRl1i5p82DNVwlG0ACodVZcWiqRyMpyp8p/UsV9wz3FVy37Fsfcy
	 fxnOY/GNtM1uHNi5nKt9a6j3pMvMZFtu8P7pDWmAmY/4sXWCtQ8P5WMnhmx73DTaE+tem
	 IL/ty+i2DL9oxpSV3oAjqBWHWs68ds3+MQ37GcptdHUQYpK/BFOTNycY/T+Mqqskkpjuk
	 tVcDPERqble6Ctou+f21gzPHTlsl2WPVndDZqQ+UFoAbIM9P5Cb10CZBv26arNiNIOn7R
	 uk9PqMtXjMOgvpHqA6jb7lkosOGXw2msSEVKMQQOmlTnHkq3g8J+Y2Mre1XY9TRUquw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132549;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=dn0sv0VzM9xwN3Gvmx3w28aY4Lr3hETox+wczTSoBts=;
	b=FUwuab9bA1CpOyFW7SPVuQnumNhKxTwoLDqYHOe4crMyZA3/aZ+QkwQdUkNmOO8Q/sk4
	 lo5V/0golrGgMiPjAbsnF13m10fzEhhtn8zC8pQnMd0y+trS1ekfNhy2QVzwbKjLbY39D
	 taIaLTTnHYZyplKBkQv/JogRLG35HCTR+Eopas1grEj+lsL8trqR2xWCgGUBLXRgco7iM
	 5q4CHvK6SuXIbwY1H0NW8U7qhVNmU/QaUrhj/745z/WRXGgNnuUylR9mpN0kIuNalMqeU
	 EfwqcqUkDLGL/BXgMMjw7TRdeQn045R3aXOACJ0hqE1ucNc2OLZlNMX3PGnM3bpjMLQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 908D41F01347;
	Tue, 27 Oct 2026 20:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132549;
	bh=dn0sv0VzM9xwN3Gvmx3w28aY4Lr3hETox+wczTSoBts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=o2xUF3N20g5kVQzyE8Gktb+8+Hj4cpp81OpPCls/jcnonqnw/Q3mLly2bXbdKMAjB
	 CMeI0t0P3IZc0XvHUSWzc3bj9f/gTgqPc6fgt5rOurIJBLoBjQGoIxGQBefAW9p8EW
	 twqL2h36q2sXfBJKl5AQRHNfVU67A0V+jqirlI66+JExpF4gIjnDM7yLCGxfitpSc+
	 nFgD9uOx57CMgspbeqACFhMndNsc9RXKkpUVWOKTWB6LyeEAxl3ExZkcjfaqX72AXS
	 B5XP7F1gpnnVcAadoPJtjvDf7SJpULPNZx74bvXPNLDnHI9TY1tYTO35QKAbMDm/Ia
	 EKGVhcEOFLCEw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 57EFA45280;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:36 -0600
Subject: [PATCH v13 36/39] dyndbg: add DEBUG-biased fallback stubs for
 _dynamic_func_call_cls
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-36-9267923be612@gmail.com>
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
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>, 
 kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=9359;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=ovX5D9cr74W6Bu4PFVSpJf/2WLwmstlAnUKabLbKZAQ=;
 b=iK6KWLuA7XF0UEsg5qHsLBjVLfllzNECBkSKaKIo7co7lklIfav+KmE2upwdm8vzxGTydrWjB
 SLEuYmX3vYIBay3tvITGpCU5SU12hvTbCyfmp0iDqVa+vapcx3UVBPp
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

When the dynamic debug core is enabled (CONFIG_DYNAMIC_DEBUG_CORE=y) but
the global CONFIG_DYNAMIC_DEBUG is disabled, subsystems can opt-in to
dynamic debug by defining DYNAMIC_DEBUG_MODULE.

However, for built-in code (like DRM core) where DYNAMIC_DEBUG_MODULE
is not defined, the macros fall back to the disabled #else block in
include/linux/dynamic_debug.h.

In this block, the family of _dynamic_func_call_cls macros were
completely undefined. This caused build failures (implicit declarations)
in subsystems (like DRM) that attempt to use these macros to wrap their
own debug functions even when dynamic debug is disabled.

Add stub definitions that mirror the enabled behavior and respect the
DEBUG macro, similar to pr_debug. If DEBUG is defined, they inject NULL
as the first argument (to satisfy the expected descriptor pointer) and
pass the arguments through, allowing the wrapped function's own slow-path
fallback logic to execute. If DEBUG is not defined, they use an if (0)
statement-expression to compile out the call while returning 0, achieving
zero overhead while maintaining compile-time argument checking.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605201408.x1sHT6fx-lkp@intel.com/
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h                      | 17 ++++
 lib/dynamic_debug.c                                | 92 ++++++++++++++++++----
 lib/test_dynamic_debug.c                           | 17 +++-
 .../selftests/dynamic_debug/dyndbg_selftest.sh     |  2 +-
 4 files changed, 108 insertions(+), 20 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index fb182c903088..6a6cd45e5571 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -536,6 +536,23 @@ void ddebug_increment_call_count(void);
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
 #define DECLARE_DYNDBG_CLASSMAP(...)
 
+#if defined(DEBUG)
+#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
+	do { func(NULL, ##__VA_ARGS__); } while (0)
+#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
+	do { func(__VA_ARGS__); } while (0)
+#else
+#define _dynamic_func_call_cls(cls, fmt, func, ...)		\
+	do { if (0) func(NULL, ##__VA_ARGS__); } while (0)
+#define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)	\
+	do { if (0) func(__VA_ARGS__); } while (0)
+#endif
+
+#define _dynamic_func_call(fmt, func, ...)			\
+	_dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
+#define _dynamic_func_call_no_desc(fmt, func, ...)		\
+	_dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
+
 #define dynamic_pr_debug(fmt, ...)					\
 	no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
 #define dynamic_dev_dbg(dev, fmt, ...)					\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 027f7c31fe22..8c0a67ad9c92 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -329,7 +329,8 @@ static bool ddebug_match_desc(const struct ddebug_query *query,
 	/* site is class'd */
 	site_map = ddebug_find_map_by_class_id(di, dp->class_id);
 	if (!site_map) {
-		WARN_ONCE(1, "unknown class_id %d, check %s's CLASSMAP definitions", dp->class_id, di->mod_name);
+		pr_warn_ratelimited("unknown class_id %d, check %s's CLASSMAP definitions\n",
+				    dp->class_id, di->mod_name);
 		return false;
 	}
 	/* module(-param) decides protection */
@@ -1583,18 +1584,80 @@ static void ddebug_apply_class_users(const struct _ddebug_info *di)
 		__di->_vec.start = __start;				\
 })
 
-static int ddebug_class_range_overlap(struct ddebug_class_map *cm, u64 *reserved_ids)
+static bool ddebug_validate_class_range(const char *modname,
+					const char *name,
+					int base, int length,
+					u64 *reserved_ids)
 {
-	u64 range = (((1ULL << cm->length) - 1) << cm->base);
+	u64 range;
 
+	if (base < 0 || length <= 0 ||
+	    base + length > _DPRINTK_CLASS_DFLT) {
+		pr_err("module %s: base:%d len:%d (from %s) exceeds class_id limit %d\n",
+		       modname, base, length, name, _DPRINTK_CLASS_DFLT);
+		return false;
+	}
+	range = (((1ULL << length) - 1) << base);
 	if (range & *reserved_ids) {
-		pr_err("[%d..%d] on %s conflicts with %llx\n", cm->base,
-		       cm->base + cm->length - 1, cm->class_names[0],
-		       *reserved_ids);
-		return -EINVAL;
+		pr_err("module %s: [%d..%d] (from %s) conflicts with 0x%llx\n",
+		       modname, base, base + length - 1, name, *reserved_ids);
+		return false;
 	}
 	*reserved_ids |= range;
-	return 0;
+	return true;
+}
+
+static bool ddebug_validate_classmaps(struct _ddebug_info *di)
+{
+	struct ddebug_class_map *cm;
+	struct ddebug_class_user *cli;
+	u64 reserved_ids = 0;
+	bool valid = true;
+	int i;
+
+	for_subvec(i, cm, di, maps)
+		if (!ddebug_validate_class_range(di->mod_name,
+						 cm->class_names[0],
+						 cm->base, cm->length,
+						 &reserved_ids))
+			valid = false;
+
+	for_subvec(i, cli, di, users) {
+		if (!cli->map) {
+			pr_err("module %s: classmap not found for user\n",
+			       di->mod_name);
+			valid = false;
+			continue;
+		}
+		if (!ddebug_validate_class_range(di->mod_name,
+						 cli->map->class_names[0],
+						 cli->map->base + cli->offset,
+						 cli->map->length,
+						 &reserved_ids))
+			valid = false;
+	}
+	return valid;
+}
+
+static void ddebug_validate_descs(struct _ddebug_info *di)
+{
+	struct _ddebug *dp;
+	u64 bad_ids = 0;
+	int i;
+
+	for (i = 0; i < di->descs.len; i++) {
+		dp = &di->descs.start[i];
+
+		if (dp->class_id == _DPRINTK_CLASS_DFLT)
+			continue;
+		if (bad_ids & (1ULL << dp->class_id))
+			continue;
+		if (!ddebug_find_map_by_class_id(di, dp->class_id)) {
+			pr_warn("module %s uses unknown class_id %d\n",
+				di->mod_name, dp->class_id);
+			bad_ids |= (1ULL << dp->class_id);
+		}
+	}
 }
 
 /*
@@ -1606,7 +1669,6 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	struct ddebug_table *dt;
 	struct ddebug_class_map *cm;
 	struct ddebug_class_user *cli;
-	u64 reserved_ids = 0;
 	int i;
 
 	if (!di->descs.len)
@@ -1638,10 +1700,10 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	dd_set_module_subrange(i, cm, &dt->info, maps);
 	dd_set_module_subrange(i, cli, &dt->info, users);
 
-	/* insure 2+ classmaps share the per-module 0..62 class_id space */
-	for_subvec(i, cm, &dt->info, maps)
-		if (ddebug_class_range_overlap(cm, &reserved_ids))
-			goto cleanup;
+	if (!ddebug_validate_classmaps(&dt->info))
+		goto cleanup;
+
+	ddebug_validate_descs(&dt->info);
 
 	/*
 	 * Bind controlling_param before publishing dt to ddebug_tables so
@@ -1668,7 +1730,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 		 dt->info.descs.len, dt->info.mod_name);
 	return 0;
 cleanup:
-	WARN_ONCE(1, "dyndbg multi-classmap conflict in %s\n", di->mod_name);
+	pr_err("dyndbg multi-classmap conflict in %s\n", di->mod_name);
 	kfree(dt);
 	return -EINVAL;
 }
@@ -1756,7 +1818,7 @@ static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
 		mod->dyndbg_info.mod_name = mod->name;
 		ret = ddebug_add_module(&mod->dyndbg_info);
 		if (ret)
-			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
+			pr_err("dyndbg: failed to add module %s: %d\n", mod->name, ret);
 		break;
 	case MODULE_STATE_GOING:
 		ddebug_remove_module(mod->name);
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 71cba798621c..2f19ecb1f295 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -173,14 +173,23 @@ DYNAMIC_DEBUG_CLASSMAP_DEFINE(fail_base_len, 0, 60,
 #endif
 
 #else /* TEST_DYNAMIC_DEBUG_SUBMOD */
-
 /*
- * in submod/drm-drivers, use the classmaps defined in top/parent
- * module above.
+ * In submod (drm-drivers/helpers) use the classmaps defined in
+ * top/parent module above.  We _USE_() with offset, to test the
+ * non-zero case.
  */
-
 DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
+
+#if defined(DD_RUNTIME_CLASS_CHECK)
+/*
+ * Force failure of compile-time sanity checks of (classmap.length +
+ * offset < 63) if -DDD_RUNTIME_CLASS_CHECK is given in compile
+ * command
+ */
+DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 55);
+#else
 DYNAMIC_DEBUG_CLASSMAP_USE_(map_level_num, 8);
+#endif
 
 #if defined(DD_MACRO_ARGCHECK)
 DYNAMIC_DEBUG_CLASSMAP_USE_(fail_offset_big, 100);
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index b976fef40ef1..a4f78f6dbec2 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -576,7 +576,7 @@ function GOLDEN_RECORDS {
 #K= c518a50ba30ba8099d0dc874a27ecf16 FT_multi_query.4
 #K= 91838b4012c50a1dc1d9e210ba8d68f8 FT_test_classes.1
 #K= a15ec4843acd721fbdfddc0b512c8032 FT_test_classes.2
-#K= 2cee6842c9cdee5cb3bf50b2e3914813 FT_test_classes.3
+#K= 370a0539784b821ec745bd74379ce00b FT_test_classes.3
 #K= 1489b3b72dbdfdb553cc0c6594c4face FT_classmap_inheritance.1
 #K= e11c22649735cedb6c30321378100e11 FT_classmap_inheritance.2
 #K= 5d0f3701517aa3a461c8887c332bdb42 FT_classmap_inheritance.3

-- 
2.56.0


