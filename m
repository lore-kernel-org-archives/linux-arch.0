Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1D422E3E9
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520532; cv=none; b=SmapkF7B6P/9RdMf2kroJ2JwB8hppH1ZLfu/HArhbNmX9Rxxf61/4xzC/fiaZW+2VAg9BlDKnJUzIbPm2JolI2GbA6m9oNjpr1bqbFFLKQAuh0iEsleRxDAragmyzmQTAnnhWsL8+tRrcUumMQfuYzVkNPl+9tcuIyKq4qE50qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520532; c=relaxed/simple;
	bh=acmpE5f+cy4H0euAd/sWLVbXBhuyRVdVfvkTY1QfTl8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y5e0cVVCiklvbX4qY+wWc1Mh3o0iYoG9KtQToxtLEJ6HFcnRUROwzw/t999tdNjfQONmunoslL+U5QMCttnBJ/j71DJuzOXoXzXMGhhzTkAjI+s4MOiMohz7Vod+3iZcystXb+NuDXg063JzgOEdIcH0KbnQMFS8ZrddwAiwUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mxxfzpKF; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mxxfzpKF"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-44b330c5cc6so6126539f8f.1
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520529; x=1780125329; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Inkv515K3CDOqGmxKUbJA66Ndin1wkzy98GUXdhIoyc=;
        b=mxxfzpKFQLv/7ag+vvXGxDsuILctm7/pEpYZRMdTe5mKxLbRf0qYZ/gSm6r+PxjJy5
         a+z2C0MXJcysZu3SMpV8t4X7A3zhccRscwiVXl4Fih2A7VuqVw5lFSmpJOMHxqhpLgPe
         PV9G4lECnPeeUX7LGSHPwcOX395GARUl1qibhbgmu+agawoQ+yObUByTs7URUSkd8uXB
         H5p0EqYIYa8A+YV9Y9YxjfPGNyzDdGTAZAzH8qLq5bE6qaow/aP0fC4pIU9lZa8bV3WZ
         Id68iJQAlgkbBcOvDqM2C2RUvMK+aXaIRpG7GY+lsRAQ3pWtFSsdgN53wTSn36UVJT5y
         yemg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520529; x=1780125329;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Inkv515K3CDOqGmxKUbJA66Ndin1wkzy98GUXdhIoyc=;
        b=sh2NlGH5vlRE+W/65eoRPRDmTH07lBnDkygHw1km57BCZWmZTkV1GgunjjFRJFYAwt
         guXsSsoae7wTCGEsapuYXFa4+0yTSDZ2+fcjBQHiqaDyiXCgJLp+kqn7Mv4evpCtb/5B
         lv50SZSelVms9JT8mhaTbA/n0IBYt49hA3v7kku+IST3O3Q5Ylf26XjogJ31vGxl+pMn
         rUcWk/TMk5O/gg5rBexeH271djCNq/oRpG2MU3UTOQwZ6M1uIQHThxkOMHYXbT6kjD6E
         xG3kBvYIXSNjfDZpfxodThkIe6TjxjroG/vEeq0ZRE8dTMEL/vX1XVfVjyOF4y7vIDgp
         Qq4Q==
X-Forwarded-Encrypted: i=1; AFNElJ8dNwweaDqj/AVvf3oa7SiQ7shUgZlwmL7Hmx72YqbKi/shOd7OTmEre9AgOmWx7NNQ1Ga91yeojs6f@vger.kernel.org
X-Gm-Message-State: AOJu0YyRA39Gvh2TTSRbKPktPZGEDYkaUvM0jM3WHH6Ayue/AxvO/pFl
	NwMAyLGF5RzpcmpZIM2JhxGWUfIhdePWCfGd49aakOnvzY5A6c/wcOsy
X-Gm-Gg: Acq92OEpf4NdiZzRsrkJeMFmxOq8/cM5Fa9hmENG64IJTQ0p0TSmXgZ4BnQlF3yY7TZ
	oxK8EWPIEYErOjqQSpff+crKdbFJsN5XUOytNcYUhfPV1kcKhQX/CC7lc3rr2suSsorvBf+Zlbe
	nmSN7dXCfcHmyLUekoDXgayXXIBhLcJloSTDA8cumo1RvLInpuMDxwGVYT8dmcwZqHxLjoyLg8X
	s+bd4afxLZgXgqbo+sbND17aO0mVsOuCwum5ww+mZmWwNSoc+XOgzw4vZnsJx74dHsjJoNnDnBk
	1ZgRp+Lo56Y6f0CgsKJbOm62Soy8a3hGfE1faw+6BIBQrAp0HUVX/K7u5Aa9CUDcwwB+kdkBNF0
	P/H7nUZjr7RwR7b1S9hVSHkMsKMiTX0SEnZRuGDbtT3AhmYAn1PDHA/dVf2K1zEGyirBWbCfJMu
	HYBTJk96gqT4h/y4vaBu6KP39+cQhBD64NNZgDubY=
X-Received: by 2002:a05:6000:610:b0:45e:742c:f195 with SMTP id ffacd0b85a97d-45eb3690ba8mr10344352f8f.12.1779520526578;
        Sat, 23 May 2026 00:15:26 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:49 -0600
Subject: [PATCH v2 16/24] dyndbg: replace classmap list with an array-slice
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-16-b937312aa083@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=6627;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=acmpE5f+cy4H0euAd/sWLVbXBhuyRVdVfvkTY1QfTl8=;
 b=+LlT89h5Zas1rnf6o1vCdzF04GdcJrVVBC0DVNyp/lojUnxHBDsi3KbK2sf4iEP6Z6JU0GAQD
 gRp8te91A/gDPQKNAolv23w1WGUsRCb95To3FYv6z7PAbLpnCZHB4aQ
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
index e724f6b93663..0a137a586510 100644
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
index d4cce0f4f197..7f03b331d185 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -46,10 +46,11 @@ extern struct ddebug_class_map __start___dyndbg_classes[];
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
@@ -150,12 +151,13 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
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
@@ -166,7 +168,6 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table cons
 	return NULL;
 }
 
-#define __outvar /* filled by callee */
 /*
  * Search the tables for _ddebug's which match the given `query' and
  * apply the `flags' and `mask' to them.  Returns number of matching
@@ -228,7 +229,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
-	int __outvar valid_class;
+	int valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -1061,9 +1062,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1147,30 +1149,34 @@ static const struct proc_ops proc_fops = {
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
@@ -1202,10 +1208,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1318,8 +1323,8 @@ static void ddebug_remove_all_tables(void)
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

