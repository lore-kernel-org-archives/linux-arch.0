Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0203D1CD4
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440539; cv=none; b=KjgWepBS2dpI+UCNlq742a8Ozkose35BMQ/XxN/s77KBAoPhLha0bQ93GR7RgdjvsObi144ISpSK1U0uHy9HdTBqT/WnQmjivTGeWN/1PiHeNbtLtvZbptAU8cUwDTS/HLEGDSbg/GPQlu7ZzIA6P/yfD/Bop2AJnBH2njsLje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440539; c=relaxed/simple;
	bh=vk7X0gvsN/pluaAvdCwu1r3tDscy4XY8tNtE6cf5F9I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmfLxlbg1MjqiAXObpPpQH9H0mIiA65OkX/vuZpARkb4M8PgMwHefX8pov68P9SV92O9/aS8H1FL8pEbt2OW0S4DRUa8OUBVe92SpzNcT0Xzna/RLGRfSj11ypZyc2e4WVwz2kqcZHy7keCb348wu2tQHCSXUitfDLzBiH/SQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSLu4DFt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSLu4DFt"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-45eee266c6cso4407071f8f.1
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440536; x=1781045336; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZtU4wUM8LRFqe/NmO1eUuVYvzU4T+qbhigAfCAPlSs=;
        b=WSLu4DFtNmlcZs7beTHCjwYRN/H1PXqhGs6Rwh/oE8I72h2t4EeazqC2jHmrOqX4YX
         mMljSE/dt9IKafEiYfD5jtgbp9BajGnQyegAaCnQ3QrFsQ0yK7Mpppg5ARWwXckCr8gR
         Tpeo6KZw5/HFfh3f4UsSJluutnYr9EEnRtWf1c94Z+Z8HNQmn/At4aeKrFlNUeqdnVI+
         DtYCy51j65NsoFL33DbjZVouuDRrsGVW701KVCCB8S0CQp9k/29vqXxmTLlAnTjJD60w
         6I97H8nTKMHSrwVqmbO+fQEI/0ZBhbZCBsXenD+04uIneoOPESOnghrgmy+0hv/zNh6N
         Y5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440536; x=1781045336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6ZtU4wUM8LRFqe/NmO1eUuVYvzU4T+qbhigAfCAPlSs=;
        b=ddFiFXfEIMbWcHAwz+W8BCUz2IQjvBbpGkhae0aA40otxK6utbBraf3PlKUgqxRfJB
         rroxLje6y4UqIG8S/Mkvu3AQInj6l8ncDyQzl/9r1M3Tt/c0lEN6uuf5oN8X2531oIxN
         IaQYGfR6wgZIG4Quu+zWIyWut/x4bTT9rQ2jSK12AnlZH0fXKyHyuShnmkbPRfnpJ23c
         Ur9EaxGF+YzzThgEzqlqUhNFCA1ul6PqKrLMtV6a213SUqTCE6PGUA6gvE/z1qi10EWd
         GeAMVqasZMWdj9rx4GoR1nCA4qV2+fh3rasY8CFBrGPZ2jQJTFGpz+T0/l7w1u1hC0uu
         1G9w==
X-Forwarded-Encrypted: i=1; AFNElJ/88uOmhGUqXH3Ez/ivRBVYJtSweZInzSb2XzXvpYgRrjS6WtELtzTTEteVTJ98ua5ImjdxDrQwofKW@vger.kernel.org
X-Gm-Message-State: AOJu0YyayxY3AaObftO2pkr4uNEGEuaeFQ9CmNu5c0QEwByWHbbVHXz5
	lQ/CkRgRfx56hFLS6EqxQe4e26e56te/IXKdcuG9nxQ+Ur2KnF9E6pEA
X-Gm-Gg: Acq92OEsUVp9XcDRUYIN5yzcntIu9f8nXH0zgIjopJvquIgEI2Ov2k6n/x8O44k0/u4
	67XVwqfPwSAIujZJIDHAi0s8LCo1Q7LG5WVUhqV8Zg63dlLiD3KyvSfxHbhaMijC3b/jQvJgXs/
	K37U086Njs8gL9kSfN96BcDbXemajknZ4IWaSJTtZWgtpA3Avf8Hf0RpU3si/wpF26R3+PKdG0R
	esTCTGnWb1NDozaESStDlHO3SIaANj7Vv1Yye0V4OEzPMv6bsBfp6KWUEhNdKu0lVX47jYUP39a
	H7o3o36TzC8HH3R7nSW2YsqUL8pCZA5IY9clXqwMR22vdVCYlXJza3h2YdWfgarrP0tk8tMn1hn
	E6sJfXwYDzeTXkQaAftxeI50Ofdy6oS3G64VZyEu9nPrMIVvnekm5imRy9zVHuGbCcfQn8j0L05
	aeoaWiwZRoyUbh4J9hspBiZ2HD5kIDZVqOQmKr7IwMtg==
X-Received: by 2002:a5d:64c9:0:b0:45e:ea2a:dd79 with SMTP id ffacd0b85a97d-460218aaec9mr634198f8f.4.1780440535963;
        Tue, 02 Jun 2026 15:48:55 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:48:55 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:13 +0000
Subject: [PATCH v4 16/25] dyndbg: replace classmap list with an array-slice
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-16-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=6628;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=vk7X0gvsN/pluaAvdCwu1r3tDscy4XY8tNtE6cf5F9I=;
 b=bCI/agdbnZfA3Wzw5qVqSADM6r8GwdbtcnFMRi0CNQPZ/gF8oSeOh7PBSsTT4gYkukj4ZciSn
 PzY23Imk9K6BUlTS/Vbn0KVKWXv5pDePzLiGIjF68olaw0ESDwOuime
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Classmaps are stored in an elf section/array, but currently are
individually list-linked onto dyndbg's per-module ddebug_table for
operation. This is unnecessary.

Just like dyndbg's descriptors, classes are packed in compile order;
so even with many builtin modules employing multiple classmaps, each
modules' maps are packed contiguously, and can be treated as a
array-start-address & array-length.

So this drops the whole list building operation done in
ddebug_attach_module_classes(), and removes the list-head members of
the classmap structs.  The "select-by-modname" condition is reused to
find the start,end of the subrange of classmaps belonging to the module.

NOTES:

There are multiple modules named "main" but thats an artifact of how
KBUILD_MODNAME gets its value, and none of those repeats are
contiguous.  The legacy code segmenting the builtin descriptors
depends upon this, we are "reusing" that dependency.

The "filter-by-modname" on classmaps should really be done in
ddebug_add_module(1); ie closer to dynamic_debug_init(2), which
already splits up pr-debug descriptors into subranges by modname, then
calls (1) on each.  (2) knows nothing of classmaps currently, and
doesn't need to.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: RvB after SoB
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 65 +++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 867e3978675f..0443781ed95b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -73,7 +73,6 @@ enum ddebug_class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 9bd521651c48..b8a494835ef5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -45,10 +45,11 @@ extern struct ddebug_class_map __start___dyndbg_classes[];
 extern struct ddebug_class_map __stop___dyndbg_classes[];
 
 struct ddebug_table {
-	struct list_head link, maps;
+	struct list_head link;
 	const char *mod_name;
-	unsigned int num_ddebugs;
 	struct _ddebug *ddebugs;
+	struct ddebug_class_map *classes;
+	unsigned int num_ddebugs, num_classes;
 };
 
 struct ddebug_query {
@@ -149,12 +150,13 @@ static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							  const char *class_string, int *class_id)
+							const char *class_string,
+							int *class_id)
 {
 	struct ddebug_class_map *map;
-	int idx;
+	int i, idx;
 
-	list_for_each_entry(map, &dt->maps, link) {
+	for (map = dt->classes, i = 0; i < dt->num_classes; i++, map++) {
 		idx = match_string(map->class_names, map->length, class_string);
 		if (idx >= 0) {
 			*class_id = idx + map->base;
@@ -165,7 +167,6 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
-#define __outvar /* filled by callee */
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -227,7 +228,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
-	int __outvar valid_class;
+	int valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -1064,9 +1065,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1150,30 +1152,34 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
-static void ddebug_attach_module_classes(struct ddebug_table *dt,
-					 struct ddebug_class_map *classes,
-					 int num_classes)
+static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
 {
 	struct ddebug_class_map *cm;
-	int i, j, ct = 0;
+	int i, nc = 0;
 
-	for (cm = classes, i = 0; i < num_classes; i++, cm++) {
+	/*
+	 * Find this module's classmaps in a subrange/wholerange of
+	 * the builtin/modular classmap vector/section.  Save the start
+	 * and length of the subrange at its edges.
+	 */
+	for (cm = di->classes, i = 0; i < di->num_classes; i++, cm++) {
 
 		if (!strcmp(cm->mod_name, dt->mod_name)) {
-
-			v2pr_info("class[%d]: module:%s base:%d len:%d ty:%d\n", i,
-				  cm->mod_name, cm->base, cm->length, cm->map_type);
-
-			for (j = 0; j < cm->length; j++)
-				v3pr_info(" %d: %d %s\n", j + cm->base, j,
-					  cm->class_names[j]);
-
-			list_add(&cm->link, &dt->maps);
-			ct++;
+			if (!nc) {
+				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
+					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
+				dt->classes = cm;
+			}
+			nc++;
+		} else if (nc) {
+			/* end of matching classmaps */
+			break;
 		}
 	}
-	if (ct)
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, ct);
+	if (nc) {
+		dt->num_classes = nc;
+		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
+	}
 }
 
 /*
@@ -1205,10 +1211,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1321,8 +1326,8 @@ static void ddebug_remove_all_tables(void)
 	mutex_lock(&ddebug_lock);
 	while (!list_empty(&ddebug_tables)) {
 		struct ddebug_table *dt = list_entry(ddebug_tables.next,
-						      struct ddebug_table,
-						      link);
+						     struct ddebug_table,
+						     link);
 		ddebug_table_free(dt);
 	}
 	mutex_unlock(&ddebug_lock);

-- 
2.54.0

