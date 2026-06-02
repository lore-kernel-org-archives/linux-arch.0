Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7231A3D4134
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440551; cv=none; b=hQxtY99ymiWrGEL/ip4dk5SLOdBIv0D48MvI2h3sTD0NZ3G26fdp4MG1AfyR37u0V4OOhMj1dO+6dE5FBqGfyW0x2GCfPYUEUbL5kpKNpvFB3njZx1tY4bJLM7Krtjva4eEym4BedHsu9FMsNqrzGb52KGTt1Tv9LFFiUEDgHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440551; c=relaxed/simple;
	bh=Z1Y6Y/lN5cW3h0OfB1fz/4unyD5Ttaclg3mMzAi4dCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N3Sa3lG3LzsEB7ejmDwQMdaPdZtIDn4JUd5ROx/uUCb7OO8BMdzyZs2Lmvt25vvqhFZFMIvgCcFc33axN9I60lYFSYF1yjgoPerlScOtAWnnbyxCxvFEiaIjsPVbJlQZUkg8e7+2KZ0S2Wwls4crwCOB5PJVWQsGn9ZzUA1prB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OjK4GTyM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OjK4GTyM"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4600ddc4017so2536035f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440548; x=1781045348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sloEL2et+rScEj5ryw/ymmbW0pcpXUQyItBuc5/IW+w=;
        b=OjK4GTyM+hZLvQZxo/N9bhstJOF2KctmyCPjAA3iBYTaLCPuDC5rRdChcMNek8cilC
         NxPaq7pNRNuQQ/whhxEAWSgt8nFKbQzazlW8DIfMUAudpQnscUJW6S1vvCwZ19PMpJR3
         Owsli1pu2x3nY+D11HYtg9a91s0gnSoP4FWl3aaC+9IImoqtXrJhfXcFL7ENGwuqdfCN
         QDlEdnmYAKOhQWM7TYgvUQydh1DUbD5OVRPm3GpDOi2yA7KWO4hxnUBRHARXtOq2t9Wr
         OFdVrK1ZTKBWAYccG7rdL9I3odoX4j0bKVhpr2wHKxRhBQTDW65d1L2lMnvh9U3lm0Xd
         +pZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440548; x=1781045348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sloEL2et+rScEj5ryw/ymmbW0pcpXUQyItBuc5/IW+w=;
        b=FH2sK6URsATXOgsIKtJq8c2snJx08ukNGh9L3YhJchNeQc6Xc5aOTeN9M53dCVyvqH
         TiHQpD5kuCYaXoQ/geaPyOwmPGpCy5t6pRZ3OLZnuAVJ1aFM8YQ6SFiBnD69qsi/5q8j
         63kF8zgCdfgbvC4xwUtysLJQyy9xIU/lW+7ft4E8oOAfQatVmNMkaN620wC5+z13Zf8F
         CnWonTh8xuYs9UX0klQZzNIlLAzIPUkxfWkfaGpASTp7lXNZhRTjrH5OBQ5uHnDBF3X9
         Q626YYMCGiD1oodonMfUOeTnto3Xd2ZJHQBbDsfwJAYLOlHDstUg6jn7Yt0q54uvOzWU
         QCSw==
X-Forwarded-Encrypted: i=1; AFNElJ+n7b+tJe5hL/NCSwEBPfbNZ7JbYiHDWtqmIkXibLuoW8GbprLfnGVNUDxXa21PfuXM/5X3xjzLSA6/@vger.kernel.org
X-Gm-Message-State: AOJu0YzF01YUpjlAAymLqI8OIefu0i8E7tQbRL21moOxdMFJzHMS3xbd
	0bb03X/9U/Vwc91A13Tacc5/R/Z8fdarOM5wLxEVVNu7asjWeMptLgzy
X-Gm-Gg: Acq92OEuXgHy6QU6NUJ4VYTFMBFThEeDTt1JieN/Mlny0EuzuCM7vGFWuyWKCheB/54
	lRS1jTsI86v1I7E8evYue8rVBc12nlecXMxY35oHRi/y7QxPD5J4HKMPVsuPTo7Kx8WPVXJpw06
	JsbSg/Rjqy76EvPGA2gFdC02o/JPM5FfMox9P5zQXgtLK3YVkZQxn0LYYO+AkuBIHOZaqjwfn1J
	AlOtMKu6qKKwY+I6HChFuKAexBCF6qtN4/bUZAiHniuz+YxoLdXClEKSUnUlh0QwvQepKrRyTU0
	Uz1o0wbCGrhhCcs09U/aD4UYPl/l6Waw2bRDtGU9lSmlb2PvtKxVtwObY3LpjSYT5XbB2m/GeJF
	1H00hUO3Boboh2Cr9iwTGls7oToPj3dHoLBACcC9o+leTMVSCR1C75DaGBdEXmKB2KZNl9gr/15
	94UOAFTPzYEm73bbVnCT6tkeRi6YvfksNTpNiBwNuVEU6oh1m41F0N
X-Received: by 2002:adf:f787:0:b0:45e:ebe5:2010 with SMTP id ffacd0b85a97d-4602185df32mr395619f8f.33.1780440547817;
        Tue, 02 Jun 2026 15:49:07 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:49:07 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:17 +0000
Subject: [PATCH v4 20/25] dyndbg: move mod_name down from struct
 ddebug_table to _ddebug_info
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-20-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=7732;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=Z1Y6Y/lN5cW3h0OfB1fz/4unyD5Ttaclg3mMzAi4dCY=;
 b=fGSsz6AgkWDvMtSBE2DnPcZZQJGON4xwO0QWnQR8uo1UeMFZRN0SRe8NWWbvmBKlDVxKqvgZl
 lxad52gICAoCPKJ4zoNkZAit7PFTHNinfk6lnU5Uj28gRtZrbYA568v
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

struct _ddebug_info already has most of dyndbg's info for a module;
push debug_table.mod_name down into it, finishing the encapsulation.

This allows refactoring several callchains, passing &_ddebug_info
instead of &ddebug_table, and hoisting the "&dt->info" deref up
instead of repeating it thru the callchans

ddebug_table contains a _ddebug_info member, so its users keep access
to mod_name, just now with "->info." added in.

In static ddebug_add_module(&di), reinforce the cursor-model by
dropping the modname arg, and setting di->mod_name at each caller.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v2: move RvB after SoB

old-v12
. moved up 1 position in series, ahead of hoist...
---
 include/linux/dynamic_debug.h |  1 +
 lib/dynamic_debug.c           | 50 ++++++++++++++++++++++---------------------
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 8fc315d0e5a5..e4a62cb73267 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -97,6 +97,7 @@ struct _ddebug_class_maps {
 };
 
 struct _ddebug_info {
+	const char *mod_name;
 	struct _ddebug_descs descs;
 	struct _ddebug_class_maps maps;
 };
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 29086aad436b..c15b692ffc60 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -46,7 +46,6 @@ extern struct _ddebug_class_map __stop___dyndbg_class_maps[];
 
 struct ddebug_table {
 	struct list_head link;
-	const char *mod_name;
 	struct _ddebug_info info;
 };
 
@@ -245,10 +244,11 @@ static int ddebug_change(const struct ddebug_query *query,
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry(dt, &ddebug_tables, link) {
+		struct _ddebug_info *di = &dt->info;
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard(query->module, dt->mod_name))
+		    !match_wildcard(query->module, di->mod_name))
 			continue;
 
 		if (query->class_string) {
@@ -260,8 +260,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
-		for (i = 0; i < dt->info.descs.len; i++) {
-			struct _ddebug *dp = &dt->info.descs.start[i];
+		for (i = 0; i < di->descs.len; i++) {
+			struct _ddebug *dp = &di->descs.start[i];
 
 			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
@@ -281,7 +281,7 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
-				  dt->mod_name, dp->function,
+				  di->mod_name, dp->function,
 				  ddebug_describe_flags(dp->flags, &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
@@ -1080,12 +1080,12 @@ static bool ddebug_class_in_range(const int class_id, const struct _ddebug_class
 		class_id < map->base + map->length);
 }
 
-static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
+static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct _ddebug_class_map *map;
 	int i;
 
-	for_subvec(i, map, &dt->info, maps)
+	for_subvec(i, map, di, maps)
 		if (ddebug_class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1113,13 +1113,13 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
 	seq_printf(m, "%s:%u [%s]%s =%s \"",
 		   trim_prefix(dp->filename), dp->lineno,
-		   iter->table->mod_name, dp->function,
+		   iter->table->info.mod_name, dp->function,
 		   ddebug_describe_flags(dp->flags, &flags));
 	seq_escape_str(m, dp->format, ESCAPE_SPACE, "\t\r\n\"");
 	seq_putc(m, '"');
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter->table, dp);
+		class = ddebug_class_name(&iter->table->info, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
@@ -1180,7 +1180,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * and length of the subrange at its edges.
 	 */
 	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->mod_name)) {
+		if (!strcmp(cm->mod_name, dt->info.mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
 					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
@@ -1194,7 +1194,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	}
 	if (nc) {
 		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
+		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
 	}
 }
 
@@ -1202,27 +1202,26 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
  * Allocate a new ddebug_table for the given module
  * and add it to the global list.
  */
-static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
+static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
 
 	if (!di->descs.len)
 		return 0;
 
-	v3pr_info("add-module: %s %d sites\n", modname, di->descs.len);
+	v3pr_info("add-module: %s %d sites\n", di->mod_name, di->descs.len);
 
 	dt = kzalloc_obj(*dt);
 	if (dt == NULL) {
-		pr_err("error adding module: %s\n", modname);
+		pr_err("error adding module: %s\n", di->mod_name);
 		return -ENOMEM;
 	}
 	/*
-	 * For built-in modules, name lives in .rodata and is
-	 * immortal. For loaded modules, name points at the name[]
-	 * member of struct module, which lives at least as long as
-	 * this struct ddebug_table.
+	 * For built-in modules, name (as supplied in di by its
+	 * callers) lives in .rodata and is immortal. For loaded
+	 * modules, name points at the name[] member of struct module,
+	 * which lives at least as long as this struct ddebug_table.
 	 */
-	dt->mod_name = modname;
 	dt->info = *di;
 
 	INIT_LIST_HEAD(&dt->link);
@@ -1234,7 +1233,7 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
+	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name);
 	return 0;
 }
 
@@ -1297,7 +1296,7 @@ static int ddebug_remove_module(const char *mod_name)
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-		if (dt->mod_name == mod_name) {
+		if (dt->info.mod_name == mod_name) {
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
@@ -1317,7 +1316,8 @@ static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_COMING:
-		ret = ddebug_add_module(&mod->dyndbg_info, mod->name);
+		mod->dyndbg_info.mod_name = mod->name;
+		ret = ddebug_add_module(&mod->dyndbg_info);
 		if (ret)
 			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
 		break;
@@ -1415,7 +1415,8 @@ static int __init dynamic_debug_init(void)
 			mod_ct++;
 			di.descs.len = mod_sites;
 			di.descs.start = iter_mod_start;
-			ret = ddebug_add_module(&di, modname);
+			di.mod_name = modname;
+			ret = ddebug_add_module(&di);
 			if (ret)
 				goto out_err;
 
@@ -1426,7 +1427,8 @@ static int __init dynamic_debug_init(void)
 	}
 	di.descs.len = mod_sites;
 	di.descs.start = iter_mod_start;
-	ret = ddebug_add_module(&di, modname);
+	di.mod_name = modname;
+	ret = ddebug_add_module(&di);
 	if (ret)
 		goto out_err;
 

-- 
2.54.0

