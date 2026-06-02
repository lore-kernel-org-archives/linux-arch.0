Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61D43D1CCA
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440550; cv=none; b=KhxhkqhOtKoIn+hC2k4sVVMzWx1BqN5ups8HBivgu4EwvgQxiqdExRv4kHhDJEROQpNgWZwqU4KluBSxdWiTHS2UrN6hE+GQbpFF8G7XbsS7qIw5WIXaVvQtAGqOfBDKZgXGt4PgBgGpDE8OgHznWuIyA4dDA80Euel65H7MnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440550; c=relaxed/simple;
	bh=a1YwseQaE7rwdsmfJ7bSKBT6pGE1MSI+QaPHqlpLaow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LgetGSeeNwbI1ypKp2//p7r3hrLmRxcjOiYWoQTIQDV7R/DcJALjUIykLhPs1Z06wtqb582kxQpAmHuJz8ffkuYVK2EsUJouKD6Ub489Yk7kHNiOsimYDRHaHcgfpeprK2iSSS2Iz/RiBMr1pWiB0PqL/zlLBw7vAxAUzyxoAk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BugsESx4; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BugsESx4"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-45ef5146b56so38240f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440545; x=1781045345; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s09INlj8seWn/YOle83dzShBKe394Jq1/oZpUANOzOk=;
        b=BugsESx4O/HaBi1zax3z3rH/2y+iaS1p1SKvCmtou+yoEmZ0mGoX3JN8+VdHkkLSjD
         9oP9aa89cXWQYokQ79hX0UYNpVBWw51q02u/NoBWvAxJYAW6/COkOMgWKc+EMsFf08jh
         1M3+knR49GHJmswpuNGziT0lMAt0jyk4Aevxb+VGP+Q9DyVfWHrJbBuX622Vu6px9fDd
         uTRSjSD1+c0j+hkFxO9S+xM5Q6nqwL2KIOWR/UQl8z/XmNeKc0cSkVWJu7TIDraWl567
         Aii1+Wp8JdvCJZ+2w8dKc4l53c+xN8VJNdzTCMrr9GLmWmhlemdE34GYAAu+4N80ZX/R
         Al3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440545; x=1781045345;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s09INlj8seWn/YOle83dzShBKe394Jq1/oZpUANOzOk=;
        b=q6Dfzdali75+Y2Zb6Yk0+U8QVQ5pERTdYMHJk4aV6D5eEGZ/Z3qz6VRkXiN1etwub1
         sLGXktk4xkj8pNzdcDkIq+/QyzOIBOCajopHINJaIKYWwAZIWliqcjo63Um19zVKyu+H
         j9gPD0X7a2Pj4kq93OyOAOptetMJ2dG4wxwVzMEYoJJTF3j9IPnLlXdBAbNTxcd+PgYe
         2L4NoCRb54xqRWfAdTr+l016inz6iKJhx6v+ohGTlW57pxx3O00lSq2gnbI/pu9hlUrg
         dX1keTu/jR0PfkyNn15O/lA7QkkHMjKWYE9h+U1jq8wdchUk0xFIlqOXXK0cR9mWNtz/
         HnMw==
X-Forwarded-Encrypted: i=1; AFNElJ+221z2HmT+tTfaRHZ53YNxDZgSwwz7bkya6IBi6AuSPJ+VZfUWVTT+mmfN9QRre5uvDUnNVDFWoV/u@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl2Y76Pb4yW5+AVYNp2ypO+E1njK40E9ms5AkbcdVyRlUZG0sm
	batTPTKYIw0DT5G08JX+pyhYtpiV+RqZd1wiGi4LlJ67uWNDKxT2QSFl
X-Gm-Gg: Acq92OHpU2DnSw5lOBFfp3qlpQRlo/xti2y152hvI4RmRUhwbo/v5mfrIT6y/fDG4lL
	9VriGiIgUCusoGrqgMk8JkCTfaFVvNCPGZZbLDufeXjXYwlBDAGShVaiyt8j6XFL4CNXxKZQ8SI
	wFH/umtrPKZKksVOQYx+rK/kM362/S2mnLQVXrTJSmsTKpMW371onnXKBdCxxlavvAewRuTHBbW
	LXsf05Lb48us/GYmgFPBGbj48ANlAiE9XVM9gV1/dCThbm+LP7Koa74T3j9wo6WOrtOgVS6mLrc
	dzh1OIRIXWka8HoLe16rcaa4ufIaavBs2vXQUKxV0jUwa8/3rp9iokk1if1W6EAyYVOWF9vlDcF
	In8rGeUaUitFMD6mxTqoy1ef1NMO6cmgMk7KAXqNwRYlpgbZC0u6pAZWR0QxcZQq3Zgl3tF0h0Z
	CEDO+AgwK8tcA8GMS4vvEXZ/9JW9GWuXSh3QL7i6zW5w==
X-Received: by 2002:a05:6000:1acf:b0:460:118f:7a73 with SMTP id ffacd0b85a97d-4602130ddbdmr922848f8f.18.1780440545312;
        Tue, 02 Jun 2026 15:49:05 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:49:04 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:16 +0000
Subject: [PATCH v4 19/25] dyndbg,module: make proper substructs in
 _ddebug_info
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-19-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=19018;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=a1YwseQaE7rwdsmfJ7bSKBT6pGE1MSI+QaPHqlpLaow=;
 b=swHSwYnwjzhSTULr00VfyEqzOJJtaSCZzAHlHFzUeO8OdjwtOLOq6YXx9feLD6lcLx4aIH/19
 NQQ2ehduIhgAi5Yup8qEVlgL/CAEnQq1AuR/0M7Bybfg23myMTs+rZe
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

recompose struct _ddebug_info, inserting proper sub-structs.

The struct _ddebug_info has 2 pairs of _vec, num_##_vec fields, for
descs and classes respectively.  for_subvec() makes walking these
vectors less cumbersome, now lets move those field pairs into their
own "vec" structs: _ddebug_descs & _ddebug_class_maps, and re-compose
struct _ddebug_info to contain them cleanly.  This also lets us get
rid of for_subvec()'s num_##_vec paste-up.

Also recompose struct ddebug_table to contain a _ddebug_info.  This
reinforces its use as a cursor into relevant data for a builtin
module, and access to the full _ddebug state for modules.

NOTES:

Fixup names: Normalize all struct names to "struct _ddebug_*"
eliminating the minor/stupid variations created in classmaps-v1.

Change section names together, for more obvious name pairing.

Invariant: These vectors ref a contiguous subrange of __section memory
in builtin/DATA or in loadable modules via mod->dyndbg_info; with
guaranteed life-time for us.

struct module contains a _ddebug_info field and module/main.c sets it
up, so that gets adjusted rather obviously.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---

v3: squash in section name changes.

v2:

Move RvB after SoB
In structs _ddebug_descs & _ddebug_class_maps, change int length to unsigned int
No use of <0 vals is contemplated.

dyndbg: improve section names

change __dyndbg to __dyndbg_descs
change __dyndbg_classes to __dyndbg_class_maps

this sets up for adding __dyndbg_class_users
---
 drivers/gpu/drm/drm_print.c      |   2 +-
 include/asm-generic/dyndbg.lds.h |  14 ++---
 include/linux/dynamic_debug.h    |  40 ++++++++-----
 kernel/module/main.c             |  12 ++--
 lib/dynamic_debug.c              | 118 +++++++++++++++++++--------------------
 lib/test_dynamic_debug.c         |   2 +-
 6 files changed, 100 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 3a470e808e39..9b4d8e3baacc 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -69,7 +69,7 @@ DECLARE_DYNDBG_CLASSMAP(drm_debug_classes, DD_CLASS_TYPE_DISJOINT_BITS, 0,
 			"DRM_UT_DP",
 			"DRM_UT_DRMRES");
 
-static struct ddebug_class_param drm_debug_bitmap = {
+static struct _ddebug_class_param drm_debug_bitmap = {
 	.bits = &__drm_debug,
 	.flags = "p",
 	.map = &drm_debug_classes,
diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
index 9d8951bef688..ec661f9f3793 100644
--- a/include/asm-generic/dyndbg.lds.h
+++ b/include/asm-generic/dyndbg.lds.h
@@ -3,16 +3,16 @@
 #define __ASM_GENERIC_DYNDBG_LDS_H
 
 #include <asm-generic/bounded_sections.lds.h>
-#define DYNDBG_SECTIONS()					\
-	BOUNDED_SECTION_BY(__dyndbg, ___dyndbg)			\
-	BOUNDED_SECTION_BY(__dyndbg_classes, ___dyndbg_classes)
+#define DYNDBG_SECTIONS()						\
+	BOUNDED_SECTION_BY(__dyndbg_descs, ___dyndbg_descs)		\
+	BOUNDED_SECTION_BY(__dyndbg_class_maps, ___dyndbg_class_maps)
 
 #define MOD_DYNDBG_SECTIONS()						\
-	__dyndbg 0 : ALIGN(8) {						\
-		KEEP(*(__dyndbg))					\
+	__dyndbg_descs 0 : ALIGN(8) {					\
+		KEEP(*(__dyndbg_descs))					\
 	}								\
-	__dyndbg_classes 0 : ALIGN(8) {					\
-		KEEP(*(__dyndbg_classes))				\
+	__dyndbg_class_maps 0 : ALIGN(8) {				\
+		KEEP(*(__dyndbg_class_maps))				\
 	}
 
 #endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 91546a99014b..8fc315d0e5a5 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -72,8 +72,8 @@ enum ddebug_class_map_type {
 	 */
 };
 
-struct ddebug_class_map {
-	struct module *mod;
+struct _ddebug_class_map {
+	struct module *mod;	/* NULL for builtins */
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
 	const int length;
@@ -81,21 +81,33 @@ struct ddebug_class_map {
 	enum ddebug_class_map_type map_type;
 };
 
-/* encapsulate linker provided built-in (or module) dyndbg data */
+/*
+ * @_ddebug_info: gathers module/builtin dyndbg_* __sections together.
+ * For builtins, it is used as a cursor, with the inner structs
+ * marking sub-vectors of the builtin __sections in DATA.
+ */
+struct _ddebug_descs {
+	struct _ddebug *start;
+	unsigned int len;
+};
+
+struct _ddebug_class_maps {
+	struct _ddebug_class_map *start;
+	unsigned int len;
+};
+
 struct _ddebug_info {
-	struct _ddebug *descs;
-	struct ddebug_class_map *classes;
-	unsigned int num_descs;
-	unsigned int num_classes;
+	struct _ddebug_descs descs;
+	struct _ddebug_class_maps maps;
 };
 
-struct ddebug_class_param {
+struct _ddebug_class_param {
 	union {
 		u64 *bits;
 		u64 *lvl;
 	};
 	char flags[8];
-	const struct ddebug_class_map *map;
+	const struct _ddebug_class_map *map;
 };
 
 /*
@@ -114,8 +126,8 @@ struct ddebug_class_param {
  */
 #define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
-	static struct ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_classes") _var = {			\
+	static struct _ddebug_class_map __aligned(8) __used		\
+		__section("__dyndbg_class_maps") _var = {			\
 		.mod = THIS_MODULE,					\
 		.mod_name = KBUILD_MODNAME,				\
 		.base = _base,						\
@@ -155,7 +167,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
-	__section("__dyndbg") name = {				\
+	__section("__dyndbg_descs") name = {			\
 		.modname = KBUILD_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
@@ -242,7 +254,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * macro.
  */
 #define _dynamic_func_call_cls(cls, fmt, func, ...)			\
-	__dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
+	__dynamic_func_call_cls(__UNIQUE_ID(_ddebug), cls, fmt, func, ##__VA_ARGS__)
 #define _dynamic_func_call(fmt, func, ...)				\
 	_dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
 
@@ -252,7 +264,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * with precisely the macro's varargs.
  */
 #define _dynamic_func_call_cls_no_desc(cls, fmt, func, ...)		\
-	__dynamic_func_call_cls_no_desc(__UNIQUE_ID(ddebug), cls, fmt,	\
+	__dynamic_func_call_cls_no_desc(__UNIQUE_ID(_ddebug), cls, fmt,	\
 					func, ##__VA_ARGS__)
 #define _dynamic_func_call_no_desc(fmt, func, ...)			\
 	_dynamic_func_call_cls_no_desc(_DPRINTK_CLASS_DFLT, fmt,	\
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 46dd8d25a605..bd7899a91755 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2774,12 +2774,12 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 		pr_warn("%s: Ignoring obsolete parameters\n", mod->name);
 
 #ifdef CONFIG_DYNAMIC_DEBUG_CORE
-	mod->dyndbg_info.descs = section_objs(info, "__dyndbg",
-					      sizeof(*mod->dyndbg_info.descs),
-					      &mod->dyndbg_info.num_descs);
-	mod->dyndbg_info.classes = section_objs(info, "__dyndbg_classes",
-						sizeof(*mod->dyndbg_info.classes),
-						&mod->dyndbg_info.num_classes);
+	mod->dyndbg_info.descs.start = section_objs(info, "__dyndbg_descs",
+						    sizeof(*mod->dyndbg_info.descs.start),
+						    &mod->dyndbg_info.descs.len);
+	mod->dyndbg_info.maps.start = section_objs(info, "__dyndbg_class_maps",
+						   sizeof(*mod->dyndbg_info.maps.start),
+						   &mod->dyndbg_info.maps.len);
 #endif
 
 	return 0;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f164e11c1853..29086aad436b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -39,17 +39,15 @@
 
 #include <rdma/ib_verbs.h>
 
-extern struct _ddebug __start___dyndbg[];
-extern struct _ddebug __stop___dyndbg[];
-extern struct ddebug_class_map __start___dyndbg_classes[];
-extern struct ddebug_class_map __stop___dyndbg_classes[];
+extern struct _ddebug __start___dyndbg_descs[];
+extern struct _ddebug __stop___dyndbg_descs[];
+extern struct _ddebug_class_map __start___dyndbg_class_maps[];
+extern struct _ddebug_class_map __stop___dyndbg_class_maps[];
 
 struct ddebug_table {
 	struct list_head link;
 	const char *mod_name;
-	struct _ddebug *ddebugs;
-	struct ddebug_class_map *classes;
-	unsigned int num_ddebugs, num_classes;
+	struct _ddebug_info info;
 };
 
 struct ddebug_query {
@@ -159,18 +157,18 @@ static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
  * @_vec: name of a member in @_box
  */
 #define for_subvec(_i, _sp, _box, _vec)			\
-	for ((_i) = 0, (_sp) = (_box)->_vec;		\
-	     (_i) < (_box)->num_##_vec;			\
+	for ((_i) = 0, (_sp) = (_box)->_vec.start;	\
+	     (_i) < (_box)->_vec.len;			\
 	     (_i)++, (_sp)++)		/* { block } */
 
-static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							const char *class_string,
-							int *class_id)
+static struct _ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
+							 const char *class_string,
+							 int *class_id)
 {
-	struct ddebug_class_map *map;
+	struct _ddebug_class_map *map;
 	int i, idx;
 
-	for_subvec(i, map, dt, classes) {
+	for_subvec(i, map, &dt->info, maps) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -241,7 +239,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int newflags;
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
-	struct ddebug_class_map *map = NULL;
+	struct _ddebug_class_map *map = NULL;
 	int valid_class;
 
 	/* search for matching ddebugs */
@@ -262,8 +260,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
-		for (i = 0; i < dt->num_ddebugs; i++) {
-			struct _ddebug *dp = &dt->ddebugs[i];
+		for (i = 0; i < dt->info.descs.len; i++) {
+			struct _ddebug *dp = &dt->info.descs.start[i];
 
 			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
@@ -626,13 +624,13 @@ static int ddebug_exec_queries(char *query, const char *modname)
 }
 
 /* apply a new class-param setting */
-static int ddebug_apply_class_bitmap(const struct ddebug_class_param *dcp,
+static int ddebug_apply_class_bitmap(const struct _ddebug_class_param *dcp,
 				     const u64 *new_bits, const u64 old_bits,
 				     const char *query_modname)
 {
 #define QUERY_SIZE 128
 	char query[QUERY_SIZE];
-	const struct ddebug_class_map *map = dcp->map;
+	const struct _ddebug_class_map *map = dcp->map;
 	int matches = 0;
 	int bi, ct;
 
@@ -684,8 +682,8 @@ static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
 					   const char *mod_name)
 {
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
+	const struct _ddebug_class_param *dcp = kp->arg;
+	const struct _ddebug_class_map *map = dcp->map;
 	u64 inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
@@ -759,8 +757,8 @@ EXPORT_SYMBOL(param_set_dyndbg_classes);
  */
 int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 {
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
+	const struct _ddebug_class_param *dcp = kp->arg;
+	const struct _ddebug_class_map *map = dcp->map;
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
@@ -1007,8 +1005,8 @@ static struct _ddebug *ddebug_iter_first(struct ddebug_iter *iter)
 	}
 	iter->table = list_entry(ddebug_tables.next,
 				 struct ddebug_table, link);
-	iter->idx = iter->table->num_ddebugs;
-	return &iter->table->ddebugs[--iter->idx];
+	iter->idx = iter->table->info.descs.len;
+	return &iter->table->info.descs.start[--iter->idx];
 }
 
 /*
@@ -1029,10 +1027,10 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
 		}
 		iter->table = list_entry(iter->table->link.next,
 					 struct ddebug_table, link);
-		iter->idx = iter->table->num_ddebugs;
+		iter->idx = iter->table->info.descs.len;
 		--iter->idx;
 	}
-	return &iter->table->ddebugs[iter->idx];
+	return &iter->table->info.descs.start[iter->idx];
 }
 
 /*
@@ -1076,16 +1074,19 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	return dp;
 }
 
-#define class_in_range(class_id, map)					\
-	(class_id >= map->base && class_id < map->base + map->length)
+static bool ddebug_class_in_range(const int class_id, const struct _ddebug_class_map *map)
+{
+	return (class_id >= map->base &&
+		class_id < map->base + map->length);
+}
 
-static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map = iter->table->classes;
-	int i, nc = iter->table->num_classes;
+	struct _ddebug_class_map *map;
+	int i;
 
-	for (i = 0; i < nc; i++, map++)
-		if (class_in_range(dp->class_id, map))
+	for_subvec(i, map, &dt->info, maps)
+		if (ddebug_class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
 	return NULL;
@@ -1118,7 +1119,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_putc(m, '"');
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
@@ -1170,7 +1171,7 @@ static const struct proc_ops proc_fops = {
 
 static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
-	struct ddebug_class_map *cm;
+	struct _ddebug_class_map *cm;
 	int i, nc = 0;
 
 	/*
@@ -1178,12 +1179,12 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * the builtin/modular classmap vector/section.  Save the start
 	 * and length of the subrange at its edges.
 	 */
-	for_subvec(i, cm, di, classes) {
+	for_subvec(i, cm, di, maps) {
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
 					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
-				dt->classes = cm;
+				dt->info.maps.start = cm;
 			}
 			nc++;
 		} else if (nc) {
@@ -1192,7 +1193,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 		}
 	}
 	if (nc) {
-		dt->num_classes = nc;
+		dt->info.maps.len = nc;
 		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
 	}
 }
@@ -1205,10 +1206,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	if (!di->num_descs)
+	if (!di->descs.len)
 		return 0;
 
-	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
+	v3pr_info("add-module: %s %d sites\n", modname, di->descs.len);
 
 	dt = kzalloc_obj(*dt);
 	if (dt == NULL) {
@@ -1222,19 +1223,18 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	 * this struct ddebug_table.
 	 */
 	dt->mod_name = modname;
-	dt->ddebugs = di->descs;
-	dt->num_ddebugs = di->num_descs;
+	dt->info = *di;
 
 	INIT_LIST_HEAD(&dt->link);
 
-	if (di->classes && di->num_classes)
+	if (di->maps.len)
 		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", di->num_descs, modname);
+	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
 	return 0;
 }
 
@@ -1381,10 +1381,10 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 
 	struct _ddebug_info di = {
-		.descs = __start___dyndbg,
-		.classes = __start___dyndbg_classes,
-		.num_descs = __stop___dyndbg - __start___dyndbg,
-		.num_classes = __stop___dyndbg_classes - __start___dyndbg_classes,
+		.descs.start = __start___dyndbg_descs,
+		.maps.start  = __start___dyndbg_class_maps,
+		.descs.len = __stop___dyndbg_descs - __start___dyndbg_descs,
+		.maps.len  = __stop___dyndbg_class_maps - __start___dyndbg_class_maps,
 	};
 
 #ifdef CONFIG_MODULES
@@ -1395,7 +1395,7 @@ static int __init dynamic_debug_init(void)
 	}
 #endif /* CONFIG_MODULES */
 
-	if (&__start___dyndbg == &__stop___dyndbg) {
+	if (&__start___dyndbg_descs == &__stop___dyndbg_descs) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
 			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
 			return 1;
@@ -1405,16 +1405,16 @@ static int __init dynamic_debug_init(void)
 		return 0;
 	}
 
-	iter = iter_mod_start = __start___dyndbg;
+	iter = iter_mod_start = __start___dyndbg_descs;
 	modname = iter->modname;
 	i = mod_sites = mod_ct = 0;
 
-	for (; iter < __stop___dyndbg; iter++, i++, mod_sites++) {
+	for (; iter < __stop___dyndbg_descs; iter++, i++, mod_sites++) {
 
 		if (strcmp(modname, iter->modname)) {
 			mod_ct++;
-			di.num_descs = mod_sites;
-			di.descs = iter_mod_start;
+			di.descs.len = mod_sites;
+			di.descs.start = iter_mod_start;
 			ret = ddebug_add_module(&di, modname);
 			if (ret)
 				goto out_err;
@@ -1424,19 +1424,19 @@ static int __init dynamic_debug_init(void)
 			iter_mod_start = iter;
 		}
 	}
-	di.num_descs = mod_sites;
-	di.descs = iter_mod_start;
+	di.descs.len = mod_sites;
+	di.descs.start = iter_mod_start;
 	ret = ddebug_add_module(&di, modname);
 	if (ret)
 		goto out_err;
 
 	ddebug_init_success = 1;
-	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg section\n",
+	vpr_info("%d prdebugs in %d modules, %d KiB in ddebug tables, %d kiB in __dyndbg_descs section\n",
 		 i, mod_ct, (int)((mod_ct * sizeof(struct ddebug_table)) >> 10),
 		 (int)((i * sizeof(struct _ddebug)) >> 10));
 
-	if (di.num_classes)
-		v2pr_info("  %d builtin ddebug class-maps\n", di.num_classes);
+	if (di.maps.len)
+		v2pr_info("  %d builtin ddebug class-maps\n", di.maps.len);
 
 	/* now that ddebug tables are loaded, process all boot args
 	 * again to find and activate queries given in dyndbg params.
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index c049580d2152..e6b2422ca671 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -41,7 +41,7 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  */
 #define DD_SYS_WRAP(_model, _flags)					\
 	static u64 bits_##_model;					\
-	static struct ddebug_class_param _flags##_model = {		\
+	static struct _ddebug_class_param _flags##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\
 		.map = &map_##_model,					\

-- 
2.54.0

