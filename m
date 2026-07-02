Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6699F3ACA5D
	for <linux-arch@vger.kernel.org>; Thu,  2 Jul 2026 16:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010504; cv=none; b=uheGxfMSiaLt1zIhBbFZykDXLLxCa8qdoJ8nlOWWjbqHovbAOTUIWdg0LuwDjVYVrOqWGKtcLlGCU/XoWU7LcIvLo3BkuGKsfYLq48MeOR0pecaqhynfkC53OJ4CzFKO5+mxFu+iainQ3BC88tBgPVUNMK7XDaUrJJ9ZPvLYjII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010504; c=relaxed/simple;
	bh=X+ROcvNqf3Mx+mYH7AgELSABkG96ecczsJuzzAaz1Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g0bsxbk7GUk0cYBhYmWl3+kAJKftv7C7g15Pn4kA7fJ4tUGLQz6E7MBX5chFZwCh4TUhWKzzDIiXSR0zHqYXPxmsFk0VJgluO86beDGqVlHQlrpUxwD3N/fIOzVRel4bmj2XMRm+oNDDObrkIE1g7g3e7V4KkcL+Z0pu3RInUGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQi96A6A; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQi96A6A"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6a0ddedcd00so781580eaf.1
        for <linux-arch@vger.kernel.org>; Thu, 02 Jul 2026 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783010492; x=1783615292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+HwjglobYF+YzG4HjrgVsS9hM2x+HsjQZoiQ5JWi7Ls=;
        b=bQi96A6AWjNImA0vHAZbz+gElK3A08VD/eLS0x3mpRb6fOIdjBTGDAkVZGeNRGJCX8
         B6fCcIvAuaUbe9OfdbDd5DbVnPmN4UJWj9kjeUnSRrzDwXuFiv2hMHvnr2nSc9o94eCS
         2IL5W76yWBEJAy7Y+S5+CLKBdRXcVTP0ga9ICbeSHSgutrWcJKM0Qgojz2Dig3hchUmb
         31wiVKjiUF6GAZb/4Nb50VeOpVQ9U1/CZnXa7esnfCDSnExQUmosuTY+uD6K/qzh6dfA
         ZLk29cWmt0CKbAkm/67rvefpmK05RPPlpSw/84gLS3Cys/85Yf0zh8zH+fLIyqARjoSg
         T3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783010492; x=1783615292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+HwjglobYF+YzG4HjrgVsS9hM2x+HsjQZoiQ5JWi7Ls=;
        b=OlCSqBvNJ5QI0Y/0kwUzb6hz1M+Bb51XKDXYWqu6ccYMs/PxNVBy9GH+S6Q549HUv3
         uxM7zFY0AkO/ZUoHKpn0kt+q8Q0+qXqwbI8KZCO4E6Y9eAlQq/e67c+9G5CkuNAMWPsk
         Dn2wSjJMYkF3UAoBlVRmctIwHm7cgJqCRwYcSXEgfRG7ezgb1AsnB/bbSZGRpkue0yIf
         Lpiqq8fJKyAf3xF9NE2Z1TSIHVG5UBejoyqkaWEsCYkOyL3wwaJTJZc3AhsH4lTLO7Oj
         H1gve0lSDuQhGEezNvQlurUAG2yy1ByHebbxPCiykc28zP6uDzWaLqOA8j0cEQST4JFV
         ZFNw==
X-Forwarded-Encrypted: i=1; AFNElJ8ssrSDKXKpfThKFsoCxeJSCB7xHXuDPcMB0lgCQnwL7iOnQnoUjs5UuG8DEWnvyugJ0jXD8rIdwGLR@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDOH/uLsOFHtPP3FuHhMwinjli1nEcjXhniDtnk5Bq5tZtD86
	grEhI5nl1ezoUOC9iBu9N1LV1RNmB/sb9GwmONl+di39snJqzaatsDRb
X-Gm-Gg: AfdE7clcQLbfvz9wIgYJxu1cba3rfIcGfhwduhZwFsR0OojwoQrCPTSMweJriXCgoG2
	vHJyL3agXz5GaaiGrKsDB2VRjNszHxe8705zF23Tn3trJ4eFeC4XGWPaHp4t9JbqdJOkw46RZls
	hmMbOvY21ZEokDB5brxjvlMFNJahoS7oqGSpXxXJZweyCR5/RDvWZlt8mesH5JKbx+2dB//YVPO
	nGqr0xMpM1XiOzOLmdZEpGtwh8IOMsaktp4JN7oPzTy8i27WlASCXLbYg7FBES3NsRO/I5uRY0W
	pq957LY+j+06WYVuN77c/fsE05JHyp7R6wF7UgTV6lCUqOaHm7F8iGZYo54ZihRVT5/q2+15WPK
	37+FItXBKBqnfUAXBKHH16BksgVtiySwauS5gr/m+2pzNwfsTlGHQR/7jhUg1wAUNGWfxcY2ZtD
	2kbhrmosU2fw0MVfJdpgbCmu0DkNqqucV37xviT3GWHo9TyBQQRHA=
X-Received: by 2002:a05:6820:810:b0:6a3:c5:30db with SMTP id 006d021491bc7-6a309ae5151mr4155833eaf.41.1783010492533;
        Thu, 02 Jul 2026 09:41:32 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-44cbec93702sm3189652fac.12.2026.07.02.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 09:41:32 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 02 Jul 2026 10:41:04 -0600
Subject: [PATCH v5 12/18] dyndbg: replace classmap list with an array-slice
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-dd-maint-2-v5-12-24f22b052bf2@gmail.com>
References: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
In-Reply-To: <20260702-dd-maint-2-v5-0-24f22b052bf2@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783010473; l=6080;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=X+ROcvNqf3Mx+mYH7AgELSABkG96ecczsJuzzAaz1Fc=;
 b=SFdGMa+Cnofu31f5jpXwbu5DGTryiHsoHL31F9AdU/9mbO39ros4txWETK6bUAtTsEW16yZvE
 iXpAMKTxyaQBJHy3JhY5fRQEqpoaxadp3nQuraOxEaixsNDSKE9pkRe
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Classmaps are stored in an elf section/array, but currently are
individually list-linked onto dyndbg's per-module ddebug_table for
operation. This is unnecessary.

Just like dyndbg's descriptors, classmaps are packed in compile order;
so even with many builtin modules employing multiple classmaps, each
modules' maps are packed contiguously, and can be treated as a
array-start-address & array-length.

So this drops the whole list building operation done in
ddebug_attach_module_classes(), and removes the list-head members of
the classmap structs.  The "select-by-modname" condition is reused to
find the start,end of the subrange of classmaps belonging to the module.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: RvB after SoB
---
 include/linux/dynamic_debug.h |  1 -
 lib/dynamic_debug.c           | 65 +++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 31 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index da9e5c35bc43..d164a24dece1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -87,7 +87,6 @@ enum ddebug_class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8c3b29904346..6b699ed23d26 100644
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
@@ -231,7 +232,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
-	int __outvar valid_class;
+	int valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -1069,9 +1070,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1155,30 +1157,34 @@ static const struct proc_ops proc_fops = {
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
@@ -1210,10 +1216,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1326,8 +1331,8 @@ static void ddebug_remove_all_tables(void)
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

