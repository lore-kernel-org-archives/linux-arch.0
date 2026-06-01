Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDCE37754B
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 12:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315543; cv=none; b=Y/VBgqdt+bTItNpZjhGEKFnjfram3den5MtuGEEXwNU9duF64ABJAYvf6DA5PGJkQNM5xMBrM9C1kMYlrVsZs4DEgDVYmOFqZguvaZMZtuYrHK+49ohKur6KvXws+C2Yr6VrkIJe33m2lfxGu4kyXCi9zOwQPyKVqfisOONiQk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315543; c=relaxed/simple;
	bh=8WCc/AQmafTM88wpYes/98KA5fKAXXEB1IR6mZSzU94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lb5FYbMOcB6kNIBVJllzFkb4qu0lShJb93XY0N9AgnymPSVTX1b1Fw18S1eibQszY1UQ6RNx8b7hdFMgzePyG1bpTAuYsqUE1BQBX96QI5ctNat9k8VpZTypy9h1QSUC/jhQ+YqMi+Yr6NgLwCwD4B+zLg8lojUoXv1xDpKJnlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JIgt/lhM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JIgt/lhM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490a765e68eso10958545e9.1
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 05:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315540; x=1780920340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=psUPNABkqP2HblkW4UQMkjLqK/FIcVyd+7kBKIY+9Ns=;
        b=JIgt/lhMSx/APN1s0ZGi0eGpA4yHxB0b4S/0mWkcArdF15+7M40wI4cEQgTbZbhZ8R
         NbAE06uaADDSNNUGuq8D4VhOc5CjtgN7L9CvAfwFdFQgRHrdS+Kwc6BKfIZUYUfcmstO
         Mt6gkbQb3wn4EzhK4mlAOPtSVZxlnkK5D9sRVZcUmbPSonLC403USh18uo5Ja6nveK56
         nwihrDezw+FsJ2J3lyHncx7O/F7VmbhqP5u91O+cI4KOrtW1KvXQD3Su6lUBDJcvdRKJ
         +TqTnveFypqfEVOVhSGQPYZBrClWkX+1rQUA6fwQdjuVLzQNURGYZTTMinn8Tlhma2pE
         3QVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315540; x=1780920340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=psUPNABkqP2HblkW4UQMkjLqK/FIcVyd+7kBKIY+9Ns=;
        b=YvVNGKFPffS1ExDOtBHWkGLDv1++oHPovRfesC/lRvLDeNk+kElTY2bUVaZ3WthWOb
         Rz4jHTKRDyw8mFQ8RtaBo/fxh6AOj8DDrZ7xPwAllIB7LzvPzwDA2uAuzFFd8PXbCEWp
         6Tu8ZI7ZkCzp2gvHldUfhnxCYZmhXIKIMfCynkpmZZMG6PjHpre+pA/GCZL+ObR0b7HZ
         YtjDsyswHTE3SX/zwLiimN5VilY56piRx/q+i+HUBTLLLe2r17+/gw0WOJu/b56hN/uR
         0IqsJEWhpI8qD9s+xXiMUZwVYnNrUC6bMk4woW1YDA5uTjCYX/dqYpY7s7bSHnGN2RGc
         LhPg==
X-Forwarded-Encrypted: i=1; AFNElJ/3gHfx8otTSylt4qe0lxPg8XCBOJ8j8K/wR+8HhNui9Oa490+OWp1ZVqA1p4kR6AYNigZu+lFdHPab@vger.kernel.org
X-Gm-Message-State: AOJu0YxEq0qeyGKdBIRnXclq6y4ONO0IXGGYfklMY/AkfwRmqm5nJKfW
	0EsoMJw27ynA/SDjKAtj0SOPPxr2pf5kT1bKSpl2r99ErwZMMbcMHW+8
X-Gm-Gg: Acq92OEl7E4JWwLDwkLQvhuNlDPkJ18yfaVOyTb+b4ClZYweTfnDe6OeA/LZohJw3d3
	cZlD7rw4xK8LUdtIms9wdvWPw4bJVpvh4WD1ECf3q6mDh7+sf+BHuYj8Vp17HH8NvGjMw2lbZ/5
	MZbDM1m0Yirb6K8S5FNXOSCn/GW0giP2UweFl6O0PgvB3T8Ba4hxbOBGdtnXJUEcRPEkPb4sj/F
	svkg48BCkBHmjvGViDWBx9VuIzK5knk5rgIVLEpHjL2wURVfI9O+IivC2ql7kgLh6bMr0/mN1Cg
	dQIo+XcW1yo6XD4fHL1QPyv8NiVUIF9tXM9VIivnnNMScvID9zJBAc1UUi8bwodVWi4tK+M39hB
	qWqg0BACV1yw+8Amn7xXloE3ihXHAdSEiinfFzzXUm88KTSgGfYBwyvxATxIc96ARB5MamhTgye
	bgOLsNsRuAq5ddsFbYfSGpJv+ExD2ErTgxUyMTQ6tR5xdvTQTa9UNO
X-Received: by 2002:a05:600c:6214:b0:490:44eb:c1d7 with SMTP id 5b1f17b1804b1-490a297e571mr244455875e9.30.1780315539522;
        Mon, 01 Jun 2026 05:05:39 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:39 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:05:02 +0000
Subject: [PATCH v3 16/24] dyndbg: replace classmap list with an array-slice
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-16-4a15b241bd3c@gmail.com>
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
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=6627;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=8WCc/AQmafTM88wpYes/98KA5fKAXXEB1IR6mZSzU94=;
 b=BjD5WAdaTH7kvHi8eul+ofgcHgnzf3gOV8ajOPS8GZk/X+MyPdcJxzy0lW6SPdRV68tdhY2+U
 tlTnnUrLcHYAyJJnECmztA9CYP+DuQxdktTirj4eCXhXYOTAL57yCVY
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
index bb7e16d38f19..34d002e0a08c 100644
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
@@ -149,12 +150,13 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
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
@@ -1062,9 +1063,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1148,30 +1150,34 @@ static const struct proc_ops proc_fops = {
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
@@ -1203,10 +1209,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1319,8 +1324,8 @@ static void ddebug_remove_all_tables(void)
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

