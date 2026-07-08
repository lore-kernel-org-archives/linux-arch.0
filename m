Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ED63AEF34
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477142; cv=none; b=bocPqp05A0G6aEXNMY5GrnkbC8ftWwHml6LAP6rLxTVlpwLgyK6p7fjZTotdJI4b4dtUrDC4Sr7opwhdngjq6k2D4/hzIBbcGxtykmx1+JdNNV+S/NKTMn/JYv7xIliOD8PV+TJu5efsND2dwsSZlbmbOkEE4Brv4A3hZsU1PwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477142; c=relaxed/simple;
	bh=cPHKULhBxGZBWneD2A3/Gq3W05Q4RHn6rM9LR1t66q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t4qyBlUzJ+PM/mj5lrKUeM8i1edjyF8yrEMqqMssxfV6/ZEYpzHNbNdnwlbCrgbnxMkalR0mJ05cwrslE2+egF2AOXdq9d4UCBTpbeo92QXtPimK1sTCsyZO9eonaiNGDCWcWaMlZUS9buv7KwHm+3M+T84AEFNmCeQPmi3APrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcQxGX42; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcQxGX42"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a071495be0so150394b6e.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477138; x=1784081938; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZVjwdKg22SJsaCFjw7ZZ1p8ecvBeM9DFNj3twIxe1E=;
        b=dcQxGX42E3iFn8OGi6q8Ryy6XyPFce4k2HtJTyIV8wsUpnPsmyOFBffuFUFNyklZuP
         7mayuk5LIuuW22lufKcT0oRz10E20cPMXRntDuG7joAh1c6JgFcaMN0sehB/sBvgvrUH
         SgcOUXqmmXDzM7TRwy06qW498IZwvfme4fzQlK4vWtOXzkdrzyH4nmMKV5OzFXL+Zfy+
         7MGq2EPb6Pshm8cHvShsEEqNlm6/h9ex0Eg3NBPmqB7gFezZ+pbsUX7S6OXACRVBx7Ao
         1Bc2GQGPvWt/8My2jDKarzyg20JoFLLexeyxezsMQol9iYrT35UI1zoFiGr1dkUC22hK
         SfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477138; x=1784081938;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZVjwdKg22SJsaCFjw7ZZ1p8ecvBeM9DFNj3twIxe1E=;
        b=reomvKAod7gb8amMcwaot2CO/sXvIRT8qwGVpFUM58/bXT4AnEWu8XDMoldcfFMEjr
         KNUZMsIcYp4/Aue7N4+p9AcJhNbBdaIZ9ZTeS7wYV1unD2ze6VJFcm9REKsjbT/k6Vby
         3qR1T644SUINwOE7ycGQ8FgTkuH+qXqkOXd/K+Lege7CoVbo/HhYh98jGD5s71rvNjZe
         5aMwJbgCGGrE4XWKvE/xZlOMqSIhAicXzSEZcjUOj13jvxWTQiWzt+OuS16dLe5u+Tt9
         AMkisnyj8l95zCXZjxP1NHAY4H4sg4Lp+j+j3RpH00rvhENVy45JhRq5h5IxPEJLNVMD
         VcFQ==
X-Forwarded-Encrypted: i=1; AFNElJ87bMK6NIgzz10wNwrZ9y2RlD1hJO+fwMKBm7UgxVLXW7q2NGuidFUdhlIQvG8HXAtSrBd3AiD9W5nu@vger.kernel.org
X-Gm-Message-State: AOJu0YwZnLOMu8ZjoFJ+wy0em/VwoxgJhpI2CA2CX+JwegJKoJOh+lr8
	NybDQnKFowQprWcsa+apTZqrQwx8lIrqQeMc1d67ypF7Kayk4uVCgC3u
X-Gm-Gg: AfdE7clIDBeDfSASOTdrwYgRI72YYhul3wW+0TQdZQw7BxdV1XPEDamg4v/+uLm9BC4
	35Ccpnc3ReLkUr6nCpSTydbuShkKm3qrmE0s1bzWoZOtkCCHmL8Y6QR5Yru6xaejxH7jx0HpHQB
	r2v7aOXMHMDmG6LzgV1l25vMhlR+EA5qJcZa6Yi6fujKfFuPq3MVp+rm8ZBIBGDGUPtb3Zo5aO0
	X7P+bW+DSUdCVnkDJSmWsN1Tr8W/aCAzrURqwjmmJDrubbBSynY/Ck44Woppfyl+4FqxoknQ8S2
	O7792+ytQ6lXgHRAEl2sbgCqU9F6QoYziWP1CLVqPNZlAtljqkNfG00QbDFhp3EGssv5yYv4o9a
	OazNK1W18XeHFS7VryYbwE9SAVXmTJPxR0d7wifPjsQ30x/pDoUUnavSmR/tSAfIiq4xt5H81u1
	cvQWeFq0gI5AdE5IMC9R7q3L8HwjcDBnvvRb9ouACJhAFiwsIhDuVNwqnbk6VBwQ==
X-Received: by 2002:a05:6808:13cf:b0:489:93ff:9e9c with SMTP id 5614622812f47-4a205b216a2mr357953b6e.43.1783477137981;
        Tue, 07 Jul 2026 19:18:57 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:17 -0600
Subject: [PATCH v6 17/24] dyndbg: replace classmap list with an array-slice
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-17-381f3edb0045@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=6080;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=cPHKULhBxGZBWneD2A3/Gq3W05Q4RHn6rM9LR1t66q0=;
 b=sWFD57lcOzFEzN9qCx5SR+f6HIoPSzSx+ClE1xsvvCTHN22ruP94wjy5EdYLN58bP6msUZgOH
 0usgcyBy0r6A1g55gPM/I8ZMxnHhVpjtyYxA1xtWBiWjYVclHkPbkQB
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
2.55.0

