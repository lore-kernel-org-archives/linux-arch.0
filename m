Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819FD35E94E
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520538; cv=none; b=ZKPHQihlcOJ1xzwFo0L1NTYbySGZHRmXSp1Q5OvSvgO/g5VxTy2q1mG5pflGnYgcf3jBCCoUmLMtSzco7kmtAlcOvLc5MZ6eFx+g+SKiWya1rEsAzNnW467tcYIl66Rfwouvw9vqOJpwD8VPiYmhEqsRb19McfoGbCVofpn/9eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520538; c=relaxed/simple;
	bh=3xCQ7ARY8EG6D0xJZef7o3dIrR1jAvXpEWEFuP8QcaM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e6kzKKfEjC6rmDR9RkAqxHqdx1ByeSqMGIrFb5ljO/3H+6WMFI1AsUl/1r9sR6wK8ne5nnIBLW4oNYqzoIOtCGdiUvcNSczvpYoXuA2WQS0YwQvMhyktHCLQr9n1ybEtpInRJNB5lghMOTkrrCMY59fdD6H11IdQzzE3PSTUZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZsIZ1OT; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZsIZ1OT"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4221739f8f.2
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520534; x=1780125334; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sy8gGAp3L7DwF7H8BtzsFB1MicHEAS/0kHGy6ARmZSE=;
        b=FZsIZ1OTRv8bwCUIHwARD9ql2PC2kKy48R+35JZENIBWC6VulklWo7Dp96nwv0sShp
         7Lr+J9/SCJIq5rZl1EUP0HgVOD94s7rgU+7ADdoFRB88IPUVfAkqJmo3MkSjJDqMY5Xy
         dZYQr/w7MVB6Y/k9Jx4U0+Sx2kaoEGXUXaanGVPBCAB0/TxAAV5qLh4UqzBJfDTQNTFi
         ueoPGs6+99Z4wDahx8/HDEI7/0LdPve5WaEiRrNXZV41fcsgyCT6xwfaQ7Yo3Q3AmeHG
         qBPwKEYCkSg6VXQuoIwjGA3FkTLpMS16/MK1RpWDbmHdlj8YYG91OswI2EV+f7e6ojvE
         Ndcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520534; x=1780125334;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sy8gGAp3L7DwF7H8BtzsFB1MicHEAS/0kHGy6ARmZSE=;
        b=ktJzsQ38qe9cJFsuIEny43LJUFcXN+/3omMauijfBQgJAsCiaSq5lQ6p46HwE+aPR6
         JQVyh7AR2u5oZKyI9j01siM3Ny0xUXwLS6GDDuDYR7AHojeNwE2RKyPUwKThx+zVtVtB
         2X8dq/sGPxmGwAbmHZjwnKPsJVomiLWXDyyipnJRqR6wcBrt4bCcT0jIFeVPrjzU30cH
         MwNOAN5sdWXgbMzjK2ef71WF+GYXdsGsnPnziNR05J+K6h5C5X4u4sLMCPVzo4716YRj
         3QbJswO0hNzhB6Yu23wu/S65ggujcH2jWo0ehF7lNTWpowP18AX7Igj1cJEQV3G5On4T
         gRdg==
X-Forwarded-Encrypted: i=1; AFNElJ/TXJM+NXsC1/sXqbMrzUI6moGfOwtBHcOzsSGM7BH18rLHM+3ZRPe2tv8iQahM2/Da8bjQhkS1pSrZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxINW5D8pZdTohgXsm7aInz4Hvy9kaE4RDira9II2XcnpDIAyfV
	8X1D6Tf7xd0LCRjkB7N6D5fTsxW3/KuXZCImi0zu24XhLhAs2YpuXU1l
X-Gm-Gg: Acq92OFDC0iWTfs8YQgWil4CvWJlKpKJJ+icNU+U9ueoZCyoHPevFd3T+d1p6YwDDOt
	44qUErZFxFD7BE7Lv369dNPrmrHXNw3zaJ9EZ2shr5O9U6DT5Fr1xLr4slXGyUnCNf9nIB663p1
	487fQll/mNYdEic8Fg7dwR3uD8HLnQjuNy8CrylsiatA40ZnOA7PUmtMVch/d25hnlKmGk4LY9I
	LSoPmhsjTkUedFlTCWpWw0XuYz+KbuYQq7K0x5A+HrTgGYLdHF+gWjmrob6TFWO/s08CZo7IX6J
	VwLnl3p5lJPSV9Wvsf8kFBrqaMSUfN9l7BOWHbHjWwcETB1ML+RUeSWCPwDqTfQkGWg5RmFnwVp
	ETBC3nTwiVh7CVy0jK4DqCUJOWR8hUfm/4/V/DqAcBLDDeaV83lmUtP9LikK9Iw3aJivGjvTf9h
	lB2Wx3rQ0nM4hHpYmE93um8TJUd1p/
X-Received: by 2002:adf:e00c:0:20b0:45e:8526:7dd7 with SMTP id ffacd0b85a97d-45eb38b38e0mr8015591f8f.27.1779520533629;
        Sat, 23 May 2026 00:15:33 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:33 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:52 -0600
Subject: [PATCH v2 19/24] dyndbg,module: make proper substructs in
 _ddebug_info
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-19-b937312aa083@gmail.com>
References: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
In-Reply-To: <20260523-dd-maint-2-v2-0-b937312aa083@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=16030;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=3xCQ7ARY8EG6D0xJZef7o3dIrR1jAvXpEWEFuP8QcaM=;
 b=Xa+8hf7Yp5GD7uXlEQstLVfZSrrgH5OU8wOsdCYqNJBs9GqR2vi1nuicSMZn2iwmzMv3jRzEQ
 j3VHUtffObkDWti0aSgBjKmdDDwqUwA1h2zMezpmTmlxwnZQZkBYI4d
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

Invariant: These vectors ref a contiguous subrange of __section memory
in builtin/DATA or in loadable modules via mod->dyndbg_info; with
guaranteed life-time for us.

struct module contains a _ddebug_info field and module/main.c sets it
up, so that gets adjusted rather obviously.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2:

Move RvB after SoB
In structs _ddebug_descs & _ddebug_class_maps, change int length to unsigned int
No use of <0 vals is contemplated.
---
 include/linux/dynamic_debug.h |  36 ++++++++++-----
 kernel/module/main.c          |  12 ++---
 lib/dynamic_debug.c           | 104 +++++++++++++++++++++---------------------
 lib/test_dynamic_debug.c      |   2 +-
 4 files changed, 83 insertions(+), 71 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a84dcc127e5a..001bc84eadca 100644
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
@@ -114,7 +126,7 @@ struct ddebug_class_param {
  */
 #define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
-	static struct ddebug_class_map __aligned(8) __used		\
+	static struct _ddebug_class_map __aligned(8) __used		\
 		__section("__dyndbg_classes") _var = {			\
 		.mod = THIS_MODULE,					\
 		.mod_name = KBUILD_MODNAME,				\
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
index 46dd8d25a605..c2b6e70f2e77 100644
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
+	mod->dyndbg_info.descs.start = section_objs(info, "__dyndbg_descriptors",
+						    sizeof(*mod->dyndbg_info.descs.start),
+						    &mod->dyndbg_info.descs.len);
+	mod->dyndbg_info.maps.start = section_objs(info, "__dyndbg_class_maps",
+						   sizeof(*mod->dyndbg_info.maps.start),
+						   &mod->dyndbg_info.maps.len);
 #endif
 
 	return 0;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 580aa258f902..169b94ff6f8e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -42,15 +42,13 @@
 
 extern struct _ddebug __start___dyndbg[];
 extern struct _ddebug __stop___dyndbg[];
-extern struct ddebug_class_map __start___dyndbg_classes[];
-extern struct ddebug_class_map __stop___dyndbg_classes[];
+extern struct _ddebug_class_map __start___dyndbg_classes[];
+extern struct _ddebug_class_map __stop___dyndbg_classes[];
 
 struct ddebug_table {
 	struct list_head link;
 	const char *mod_name;
-	struct _ddebug *ddebugs;
-	struct ddebug_class_map *classes;
-	unsigned int num_ddebugs, num_classes;
+	struct _ddebug_info info;
 };
 
 struct ddebug_query {
@@ -137,11 +135,11 @@ do {								\
  * @_i:  caller provided counter.
  * @_sp: cursor into _vec, to examine each item.
  * @_box: ptr to a struct containing @_vec member
- * @_vec: name of a member in @_box
+ * @_vec: name of a vector member in @_box
  */
 #define for_subvec(_i, _sp, _box, _vec)			\
-	for ((_i) = 0, (_sp) = (_box)->_vec;		\
-	     (_i) < (_box)->num_##_vec;			\
+	for ((_i) = 0, (_sp) = (_box)->_vec.start;	\
+	     (_i) < (_box)->_vec.len;			\
 	     (_i)++, (_sp)++)		/* { block } */
 
 static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
@@ -164,14 +162,14 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 		  query->first_lineno, query->last_lineno, query->class_string);
 }
 
-static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
+static struct _ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
 							const char *class_string,
 							int *class_id)
 {
-	struct ddebug_class_map *map;
+	struct _ddebug_class_map *map;
 	int i, idx;
 
-	for_subvec(i, map, dt, classes) {
+	for_subvec(i, map, &dt->info, maps) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -242,7 +240,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int newflags;
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
-	struct ddebug_class_map *map = NULL;
+	struct _ddebug_class_map *map = NULL;
 	int valid_class;
 
 	/* search for matching ddebugs */
@@ -263,8 +261,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
-		for (i = 0; i < dt->num_ddebugs; i++) {
-			struct _ddebug *dp = &dt->ddebugs[i];
+		for (i = 0; i < dt->info.descs.len; i++) {
+			struct _ddebug *dp = &dt->info.descs.start[i];
 
 			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
@@ -623,13 +621,13 @@ static int ddebug_exec_queries(char *query, const char *modname)
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
 
@@ -681,8 +679,8 @@ static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
 					   const char *mod_name)
 {
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
+	const struct _ddebug_class_param *dcp = kp->arg;
+	const struct _ddebug_class_map *map = dcp->map;
 	u64 inrep, new_bits, old_bits;
 	int rc, totct = 0;
 
@@ -756,8 +754,8 @@ EXPORT_SYMBOL(param_set_dyndbg_classes);
  */
 int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 {
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
+	const struct _ddebug_class_param *dcp = kp->arg;
+	const struct _ddebug_class_map *map = dcp->map;
 
 	switch (map->map_type) {
 	case DD_CLASS_TYPE_DISJOINT_BITS:
@@ -1004,8 +1002,8 @@ static struct _ddebug *ddebug_iter_first(struct ddebug_iter *iter)
 	}
 	iter->table = list_entry(ddebug_tables.next,
 				 struct ddebug_table, link);
-	iter->idx = iter->table->num_ddebugs;
-	return &iter->table->ddebugs[--iter->idx];
+	iter->idx = iter->table->info.descs.len;
+	return &iter->table->info.descs.start[--iter->idx];
 }
 
 /*
@@ -1026,10 +1024,10 @@ static struct _ddebug *ddebug_iter_next(struct ddebug_iter *iter)
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
@@ -1073,16 +1071,19 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
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
@@ -1115,7 +1116,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_putc(m, '"');
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
@@ -1167,7 +1168,7 @@ static const struct proc_ops proc_fops = {
 
 static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
-	struct ddebug_class_map *cm;
+	struct _ddebug_class_map *cm;
 	int i, nc = 0;
 
 	/*
@@ -1175,12 +1176,12 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
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
@@ -1189,7 +1190,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 		}
 	}
 	if (nc) {
-		dt->num_classes = nc;
+		dt->info.maps.len = nc;
 		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
 	}
 }
@@ -1202,10 +1203,10 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 {
 	struct ddebug_table *dt;
 
-	if (!di->num_descs)
+	if (!di->descs.len)
 		return 0;
 
-	v3pr_info("add-module: %s %d sites\n", modname, di->num_descs);
+	v3pr_info("add-module: %s %d sites\n", modname, di->descs.len);
 
 	dt = kzalloc_obj(*dt);
 	if (dt == NULL) {
@@ -1219,19 +1220,18 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
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
 
@@ -1378,10 +1378,10 @@ static int __init dynamic_debug_init(void)
 	char *cmdline;
 
 	struct _ddebug_info di = {
-		.descs = __start___dyndbg,
-		.classes = __start___dyndbg_classes,
-		.num_descs = __stop___dyndbg - __start___dyndbg,
-		.num_classes = __stop___dyndbg_classes - __start___dyndbg_classes,
+		.descs.start = __start___dyndbg,
+		.maps.start  = __start___dyndbg_classes,
+		.descs.len = __stop___dyndbg - __start___dyndbg,
+		.maps.len  = __stop___dyndbg_classes - __start___dyndbg_classes,
 	};
 
 #ifdef CONFIG_MODULES
@@ -1410,8 +1410,8 @@ static int __init dynamic_debug_init(void)
 
 		if (strcmp(modname, iter->modname)) {
 			mod_ct++;
-			di.num_descs = mod_sites;
-			di.descs = iter_mod_start;
+			di.descs.len = mod_sites;
+			di.descs.start = iter_mod_start;
 			ret = ddebug_add_module(&di, modname);
 			if (ret)
 				goto out_err;
@@ -1421,8 +1421,8 @@ static int __init dynamic_debug_init(void)
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
@@ -1432,8 +1432,8 @@ static int __init dynamic_debug_init(void)
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

