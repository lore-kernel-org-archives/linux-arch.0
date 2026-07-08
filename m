Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2463B9DA9
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477149; cv=none; b=KtGQYWPfVkmqqjjeUHSD9oyxmcBTxqFrDwuggjnpNHolQJD353qYOe5v12b79zZzEfuRWIo3/jTpc2opWak1lFLhVf8lvXB+hisJmWvRSX9qoXTWZQd4Ox4ZfB7BZJ/pmkbouKoIHDqGIbjidMnbOOiXt0dDudGc9vvo0MEShGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477149; c=relaxed/simple;
	bh=70wYBhJlaNDcIaWIFK0Vv67M+cN16QpM7KwBfslT/30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U73BB6ohvaHP+8G9OdEf+j8GJNkK/3HJaCG0aDqS9tE1JENQ/M4xCtH3f9OxWeG79FNFSBM5Is5IRVIMcRSIm+JiSw746Twm0PBqZ/gFsWKGD5F9AutSdaFaSCYXhPHFZdGxb9TT4SpkQjFZq9mN/7OERn3lzeCFj17Wj3vgZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KEUc4Ec3; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KEUc4Ec3"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-495b27007d0so135398b6e.1
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477143; x=1784081943; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bvWTle6nqRC6+yb9iYZzrdp23aD59RipCOhagrCE0Fw=;
        b=KEUc4Ec3Wqol7bPxdZFQ59G5P+DX38zi62bIn3qzpST/zwyCXS+jl37OxAscVUoBSD
         RMXwQBC/+18XtS2bVUAVoNOwuWaEN4vVwzVHOlUITwyn7gK61k9vCCRtLCd/1HYBvWir
         PY+870uruCW0aNRzmfgn4sAfa+F/SyzxO3M7U8fh9Gb3zlZiWe2k3mry0Zcs+r6nwJwj
         a5nLOhhy0SZdrYGSKwxd6xLBgBJri7Eylz2L+UTVnGlHmwSTkJeg5cprcN9hBq0zkuBM
         mmx0UfKMrtHGlvUeW1rESIBoh6CqXKm7i53zhYKQvuBVmW6T8YRfwiqjxth7MLCALOys
         s+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477143; x=1784081943;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bvWTle6nqRC6+yb9iYZzrdp23aD59RipCOhagrCE0Fw=;
        b=LexkPqWqJH6cfNMYPC6xhdnX2a9/D8LJXEwgsXfdwchI77u/Cbc7XvFnjdMs+drS4O
         FS+rAFm1iXeWTiILOwliGFL71c2AEox4fUb5jHvJ9XKPNKx0vl//EAJ3OIwskpv1hO4V
         xHOzTIRGpDr/CzerCwBxqYDweJ66JsQulQVoRICIUx7aWbn+6Y+RBM8AHp1bj5XYYBWE
         RW3+pEDoEEKeykOm8ypMnjNo4XHsFnmz1fVgzoBcpJYQ4T8TRkcm3cdjOCKbhgDyxrHV
         UY5IE5Vo0DCDwBDVHribUT+NeC0s9a/LCj5DnWojHV56KjajbP9DIOhzKGsFIAR8sasf
         CrFg==
X-Forwarded-Encrypted: i=1; AFNElJ8X5uw5EBLe3zo+GXGP0I53RY2SepbSWciDc+1zxfJDYJtNbYsnyJIOlEeXZBsWIBo/4cn8WU406bmC@vger.kernel.org
X-Gm-Message-State: AOJu0YwE7Yf8BQT5hQWch3e3+CeCzks3TtAwAxRwBo9Fpg/+KsLQve5q
	2wQ4FCV07RxKMG89TC2MfIA59gHYygbgZZjKOSq3v4NfboeAhENoGlLs
X-Gm-Gg: AfdE7cnn8jepB/kjxRRXQzhjtU0NN+WVX0jlqhX+mJiByxNcguqMJJuU0VGoSsul3dr
	0GOzSprF0EXqXFN8Jkp+FSky/oLjrJPrsJG7/XdC2P1C6vfuubwP8Ro9c/F4eZmcyEPyHJgzmTK
	+EtLJjZNjOrIYzhsdVCTculgl0yDHXO1E1Uo8oCSl/1Jrs0rVyPlTeIhFnjJF+Avu1oe33wBF1I
	mPljjSr5wzFGyAY3zvkC31egoFm6Yziexp4ktdVjtoaSMaI0ToVZO2DZ3koTHQK5EFzSmHGiaJT
	x+MjWV/Zc3bN+UKYq4NpixcAHA5DogiGXwDapnjr6W8Ph4MGv8ZPxDXyQo/cpui3pq5qRzFVzib
	ZJiqswEzjR55SRVDQODJSXL49GP3JjKNnnmEYRQwpPXFswx5SKgpUHVt3FU0Fv6sjBDjGfNeBtg
	KgjsSA39ZMsGVr4zFqVBeslt7+EdlLUOH3+BUquierhfrHfKKjGwo=
X-Received: by 2002:a05:6808:f0b:b0:495:ff85:d33d with SMTP id 5614622812f47-4a202758230mr432600b6e.12.1783477143404;
        Tue, 07 Jul 2026 19:19:03 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:19:02 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:20 -0600
Subject: [PATCH v6 20/24] dyndbg,module: make proper substructs in
 _ddebug_info
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-20-381f3edb0045@gmail.com>
References: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
In-Reply-To: <20260707-dd-maint-2-v6-0-381f3edb0045@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=16353;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=70wYBhJlaNDcIaWIFK0Vv67M+cN16QpM7KwBfslT/30=;
 b=xsA4ETU2kU/qcEpWCIPw7IXWE/3tNug/H/nWvU7lQYNbzN+5YeqYjE2jFX6tPekVFMiAsBO1z
 j8Qdeib0Eu2AdMHycSVUpHc5foaLuipCQKw7XnePF1Cmz+8aAv/6+eL
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
reinforces _ddebug_info's use as a cursor into relevant data for a
builtin module, and access to the full _ddebug state for modules.

NOTES:

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
 drivers/gpu/drm/drm_print.c      |  2 +-
 include/asm-generic/dyndbg.lds.h | 14 +++---
 include/linux/dynamic_debug.h    | 34 +++++++++-----
 kernel/module/main.c             | 12 ++---
 lib/dynamic_debug.c              | 98 ++++++++++++++++++++--------------------
 5 files changed, 86 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 711ae6606c6e..da2171186c6b 100644
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
index 250b8391cb14..ca27bdd92693 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -87,7 +87,7 @@ enum ddebug_class_map_type {
 };
 
 struct ddebug_class_map {
-	struct module *mod;
+	struct module *mod;	/* NULL for builtins */
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
 	const int length;
@@ -95,12 +95,24 @@ struct ddebug_class_map {
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
+	struct ddebug_class_map *start;
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
 
 struct ddebug_class_param {
@@ -121,7 +133,7 @@ struct ddebug_class_param {
 
 /**
  * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
- * @_var:   a struct _ddebug_class_map, passed to module_param_cb
+ * @_var:   a struct ddebug_class_map, passed to module_param_cb
  * @_maptype: enum ddebug_class_map_type, chooses bits/verbose
  * @_base:  offset of 1st class-name. splits .class_id space
  * @classes: class-names used to control class'd prdbgs
@@ -129,7 +141,7 @@ struct ddebug_class_param {
 #define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
 	static struct ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_classes") _var = {			\
+		__section("__dyndbg_class_maps") _var = {			\
 		.mod = THIS_MODULE,					\
 		.mod_name = DDEBUG_MODNAME,				\
 		.base = _base,						\
@@ -169,7 +181,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
-	__section("__dyndbg") name = {				\
+	__section("__dyndbg_descs") name = {			\
 		.modname = DDEBUG_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
@@ -256,7 +268,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
  * macro.
  */
 #define _dynamic_func_call_cls(cls, fmt, func, ...)			\
-	__dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
+	__dynamic_func_call_cls(__UNIQUE_ID(_ddebug), cls, fmt, func, ##__VA_ARGS__)
 #define _dynamic_func_call(fmt, func, ...)				\
 	_dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
 
@@ -266,7 +278,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
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
index af05f4ae3b55..5a884cbd6294 100644
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
+extern struct ddebug_class_map __start___dyndbg_class_maps[];
+extern struct ddebug_class_map __stop___dyndbg_class_maps[];
 
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
 
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							const char *class_string,
-							int *class_id)
+							 const char *class_string,
+							 int *class_id)
 {
 	struct ddebug_class_map *map;
 	int i, idx;
 
-	for_subvec(i, map, dt, classes) {
+	for_subvec(i, map, &dt->info, maps) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -267,8 +265,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
-		for (i = 0; i < dt->num_ddebugs; i++) {
-			struct _ddebug *dp = &dt->ddebugs[i];
+		for (i = 0; i < dt->info.descs.len; i++) {
+			struct _ddebug *dp = &dt->info.descs.start[i];
 
 			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
@@ -1013,8 +1011,8 @@ static struct _ddebug *ddebug_iter_first(struct ddebug_iter *iter)
 	}
 	iter->table = list_entry(ddebug_tables.next,
 				 struct ddebug_table, link);
-	iter->idx = iter->table->num_ddebugs;
-	return &iter->table->ddebugs[--iter->idx];
+	iter->idx = iter->table->info.descs.len;
+	return &iter->table->info.descs.start[--iter->idx];
 }
 
 /*
@@ -1035,10 +1033,10 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
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
@@ -1082,16 +1080,19 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 	return dp;
 }
 
-#define class_in_range(class_id, map)					\
-	(class_id >= map->base && class_id < map->base + map->length)
+static bool ddebug_class_in_range(const int class_id, const struct ddebug_class_map *map)
+{
+	return (class_id >= map->base &&
+		class_id < map->base + map->length);
+}
 
-static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map = iter->table->classes;
-	int i, nc = iter->table->num_classes;
+	struct ddebug_class_map *map;
+	int i;
 
-	for (i = 0; i < nc; i++, map++)
-		if (class_in_range(dp->class_id, map))
+	for_subvec(i, map, &dt->info, maps)
+		if (ddebug_class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
 	return NULL;
@@ -1124,7 +1125,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_putc(m, '"');
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
@@ -1184,12 +1185,12 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
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
@@ -1198,7 +1199,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 		}
 	}
 	if (nc) {
-		dt->num_classes = nc;
+		dt->info.maps.len = nc;
 		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
 	}
 }
@@ -1211,10 +1212,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	if (!di->num_descs)
+	if (!di->descs.len)
 		return 0;
 
-	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
+	v3pr_info("add-module: %s %d sites\n", modname, di->descs.len);
 
 	dt = kzalloc_obj(*dt);
 	if (dt == NULL) {
@@ -1228,19 +1229,18 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
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
 
@@ -1387,10 +1387,10 @@ static int __init dynamic_debug_init(void)
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
@@ -1401,7 +1401,7 @@ static int __init dynamic_debug_init(void)
 	}
 #endif /* CONFIG_MODULES */
 
-	if (&__start___dyndbg == &__stop___dyndbg) {
+	if (&__start___dyndbg_descs == &__stop___dyndbg_descs) {
 		if (IS_ENABLED(CONFIG_DYNAMIC_DEBUG)) {
 			pr_warn("_ddebug table is empty in a CONFIG_DYNAMIC_DEBUG build\n");
 			return 1;
@@ -1411,16 +1411,16 @@ static int __init dynamic_debug_init(void)
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
@@ -1430,19 +1430,19 @@ static int __init dynamic_debug_init(void)
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

-- 
2.55.0

