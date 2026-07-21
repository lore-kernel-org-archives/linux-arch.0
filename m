Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7DD4DBD95
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667471; cv=none; b=G1D9u2YqCqurAXBlRc68wCIMF8u29/9i0m4thaXMNAcpKroQz/AZHnWgNgLd8c896trssWyInNkSycZCCCYImdI/FzEOCfkgkNRx3IHMf5gsk6siUpHGivkBcZlarArkAYlG3TIDIOtap7HBRY42rmWled3pXPEd5Oygac9DKVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667471; c=relaxed/simple;
	bh=YjCoccsnXgL3a9tFygTlkfPQWtr38x9xpLUtvOZrD88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oU3mwZ2rmo7vvcUdlF7z5PVTl0ylRAognoHT2Wz9+alW6FOeEokIyUninbCwp4SGY4pk/TwTwXjInM+p442aMCjcfMGGr3XEeqJ8NJHQ8kO5QjvnWe2ICoyyFd8D9WSuP87IlEn8Aw2yi4Izh1y2BG6M61RwzSlIzUohxiAgixM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/MnL8X0; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/MnL8X0"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7eb68bdf53aso4732147a34.3
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667462; x=1785272262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fyUa5GaC84COu+srdF1IdaxZuuozSsmo3GFS88JrVMw=;
        b=A/MnL8X0xBSgm1EBn5uC9b1FQpMhRyiodh4ucqdsaBXcvZRXwVSXwrvYZlTSgHmbFZ
         pJimX0hq4LH+zdotGPbOHhhYfQdWKdBNjFv59HkSgVUbCweVQk1MCtoBer2oMjO1uT5n
         mI6s6mc2wRgtsgH0RXw0xFuAIXtBQHwELhvjWRwc2G1XzcmLait81ioyPwuwHekb71ki
         Fh/vGuUiuG0uppyDuAAA4PDG1j/BwhT537RrLZQWH+fCIbiUyfDw6kfdQhVII4/IKQgZ
         sUxqCDtGkT/AlBB8phYrgD87+crekTB1iHfP7JCuqMnJ7LSsF2uYAsQclCJaHaYdRdQG
         tzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667462; x=1785272262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fyUa5GaC84COu+srdF1IdaxZuuozSsmo3GFS88JrVMw=;
        b=WWFlhdxleofnvCUJk052w0BG5Jc7ghj507nYoy3tar6IGUVjirAL7Brbnynl8P8fJK
         IaaVUSWL2BnqRMnmrxbbAZs2iJPgEJlosG0S3n0LW7y8W+Vwd5rwOiDuEh2WHZKFxudy
         x2sZH++bUPoDOfhiQanSM74oBw5J37GA9aykjZoXbMKALDocjLGECXfWevbsJOBVvU4Z
         jfm4Apcr9Kql7wK/Dc5D9FPZHJmo5YBgUTVi+dLb8UTu+QieQ9gLqF3Q5bhCy8VMllxc
         7UyV8Pc9GyycsXcfnxzYMZdSCaqqyqJfrfqPypEnrR4zlvqkQOoIIre9MY5kJ8hguYHJ
         1T+Q==
X-Forwarded-Encrypted: i=1; AHgh+RplifXTBnxiQKnvxCYEirMMILg6nFy8R8LFaDxkGMUWxZYaALubHHgOAwjmyzUS2j9EoywBPsXGCu/l@vger.kernel.org
X-Gm-Message-State: AOJu0YzWVeOf3K9pHOmhPz7BJ6/qcKQvSPOVROVEOFEPeDGtanKsoXHc
	CFs1DReDEYx9ggU5X8v1Ia7+ALZEZY5OxK8VOr2bH4Xp9XHjMvbRgGAX
X-Gm-Gg: AfdE7cmr9lBO37X0OUpyPokzycHKG2kACLKD27JGPToV0bYzN8GwcwRvd4Hbt+gTiIV
	v5bqoy0q9/0q5locx7yTP+FXsUjKqOVWB7SSAcDeKPDkrqdoWqTYlks5VIFpPZt68zoZYXhVTkn
	jpU80zp7WyRkym89jy2CEw+aMw2dL84Iz/rJGAd6f9nzbTtaeik9HHt3/vHV8+wfn9P1k1m2Qcf
	VwRwIqEsNIfkOdvTNEEpq8jZ2KpBssNAG5Rs7644vsnPDRoeMBp1eaDuhZbvtqgM/SS29P816Uv
	iVO9ZBL5jnUXPI6KM7sQaBEn5YzOj5dgp+1uFCfvRZq+fiQRH4brN2e3/tpve4+hB34QNEdk0eL
	JPFb+M83Ew7eHCfQu9+RqIjpYIZVQnmI4fW/YbLxMaKPLBzyhUkhxei905G3atdjcpR80MYMtOP
	NCYgpvdO2kXJfxwNo+je8hI67nqErzOkDvPlWecU+ZreOVaAUl4sVlh+j9xrLqL0JEgW+fjan34
	2Aa3s7SwYLDnPo5Q5LLIKeDYA==
X-Received: by 2002:a05:6830:610e:b0:7e9:d250:a731 with SMTP id 46e09a7af769-7eda08e1bdbmr10365827a34.20.1784667462374;
        Tue, 21 Jul 2026 13:57:42 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:42 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:15 -0600
Subject: [PATCH v7 26/29] dyndbg: move mod_name down from struct
 ddebug_table to _ddebug_info
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-26-010fbe73b311@gmail.com>
References: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
In-Reply-To: <20260721-dd-maint-2-v7-0-010fbe73b311@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Jason Baron <jbaron@akamai.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=7925;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=YjCoccsnXgL3a9tFygTlkfPQWtr38x9xpLUtvOZrD88=;
 b=s/zzOe/l/jKVsVxICtKWuvPaxdiawqctIXnoySA23+nNl+CeSYF5T3ZeYWPYiP60i3jx4njKc
 R9e1n+M7FViCQZ5s2sFsiFKqHnCWXIhK5n0+N5clxcB19lOXo5QQhYt
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

struct _ddebug_info already has most of dyndbg's info for a module;
push debug_table.mod_name down into it, finishing the encapsulation.

This allows refactoring several callchains, passing &_ddebug_info
instead of &ddebug_table, and hoisting the "&dt->info" deref up
instead of repeating it thru the callchans

ddebug_table contains a _ddebug_info member, so code with a ptr to a
ddebug_table still have access to mod_name, just now with "->info."
added in.

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
 lib/dynamic_debug.c           | 52 ++++++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 00cfc8d9f239..35e03b0eba6a 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -111,6 +111,7 @@ struct _ddebug_class_maps {
 };
 
 struct _ddebug_info {
+	const char *mod_name;
 	struct _ddebug_descs descs;
 	struct _ddebug_class_maps maps;
 };
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e7742fcca50b..905277fa495b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -46,7 +46,6 @@ extern struct ddebug_class_map __stop___dyndbg_class_maps[];
 
 struct ddebug_table {
 	struct list_head link;
-	const char *mod_name;
 	struct _ddebug_info info;
 };
 
@@ -249,11 +248,12 @@ static int ddebug_change(const struct ddebug_query *query,
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry(dt, &ddebug_tables, link) {
+		struct _ddebug_info *di = &dt->info;
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard_hyphen(query->module, dt->mod_name) &&
-		    !match_wildcard_hyphen(query->module, kbasename(dt->mod_name)))
+		    !match_wildcard_hyphen(query->module, di->mod_name) &&
+		    !match_wildcard_hyphen(query->module, kbasename(di->mod_name)))
 			continue;
 
 		if (query->class_string) {
@@ -265,8 +265,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
-		for (i = 0; i < dt->info.descs.len; i++) {
-			struct _ddebug *dp = &dt->info.descs.start[i];
+		for (i = 0; i < di->descs.len; i++) {
+			struct _ddebug *dp = &di->descs.start[i];
 
 			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
@@ -286,7 +286,7 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
-				  dt->mod_name, dp->function,
+				  di->mod_name, dp->function,
 				  ddebug_describe_flags(dp->flags, &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
@@ -1087,12 +1087,12 @@ static bool ddebug_class_in_range(const int class_id, const struct ddebug_class_
 		class_id < map->base + map->length);
 }
 
-static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
+static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct ddebug_class_map *map;
 	int i;
 
-	for_subvec(i, map, &dt->info, maps)
+	for_subvec(i, map, di, maps)
 		if (ddebug_class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1120,13 +1120,13 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
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
@@ -1187,7 +1187,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * and length of the subrange at its edges.
 	 */
 	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->mod_name)) {
+		if (!strcmp(cm->mod_name, dt->info.mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
 					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
@@ -1201,7 +1201,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	}
 	if (nc) {
 		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
+		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
 	}
 }
 
@@ -1209,27 +1209,26 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
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
@@ -1241,7 +1240,7 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
+	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name);
 	return 0;
 }
 
@@ -1304,7 +1303,7 @@ static int ddebug_remove_module(const char *mod_name)
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-		if (dt->mod_name == mod_name) {
+		if (dt->info.mod_name == mod_name) {
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
@@ -1324,7 +1323,8 @@ static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_COMING:
-		ret = ddebug_add_module(&mod->dyndbg_info, mod->name);
+		mod->dyndbg_info.mod_name = mod->name;
+		ret = ddebug_add_module(&mod->dyndbg_info);
 		if (ret)
 			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
 		break;
@@ -1422,7 +1422,8 @@ static int __init dynamic_debug_init(void)
 			mod_ct++;
 			di.descs.len = mod_sites;
 			di.descs.start = iter_mod_start;
-			ret = ddebug_add_module(&di, modname);
+			di.mod_name = modname;
+			ret = ddebug_add_module(&di);
 			if (ret)
 				goto out_err;
 
@@ -1433,7 +1434,8 @@ static int __init dynamic_debug_init(void)
 	}
 	di.descs.len = mod_sites;
 	di.descs.start = iter_mod_start;
-	ret = ddebug_add_module(&di, modname);
+	di.mod_name = modname;
+	ret = ddebug_add_module(&di);
 	if (ret)
 		goto out_err;
 

-- 
2.55.0

