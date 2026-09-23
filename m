Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67AD58F061
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202931; cv=none; b=PJ4AO7UwJrbhgdQYdOWxrR82Mbilf9mxuqgxqO8rW1n8ZamRvf7nMBBZH5s64kH+EWD3J4hhZL56EPFczQVnesEQBfK/vOomcHcLwfpAl3+ZjeQZUXUE5F5SiNrgQFcixhas8XIrDjDgVOdL63xaK5ll2c1ylRbMVCIhdBWBF04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202931; c=relaxed/simple;
	bh=XF9TuI7EwUd7R/5p1goQDXEUHeqSHXBYlumLQH7bhFE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRVRniwL92kO2cHJpNCVZlyrohi/EcKs3a8xfptGeDtWfYmDMH+T/dx8/SUrJCy4AqelObBaHcJ/DeEz5blq3g3LfVXxEki9gYxcmdCb8O+uB0rBTosQd8l1MX0WzUKj2MaDi53YF5uXzBBH2Dww4Vd0XRYAvA4CmrBjYqU80eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHccLv1G; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHccLv1G"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-80199394f52so849638a34.3
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202927; x=1790807727; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w0I0XDUUBqAVINonEdzJII4kcBVhkI+9B4d3GixNGtM=;
        b=MHccLv1GJSLdd1KPpF7p2WkDWHQrbinXWgRNhUmzJ5Bv4vW7r6M4Xn6d/NxKukwDbE
         8NXccgbGM9IASkMNDLr9aM4YCCI7zs+aKxOiocjSMuZJ/EaWMhEdwHlgh4wuhBXDNzSh
         Ent0OPFFA+Kvl93oYfua7I44YHB2keHtaBQzqL7KDZGxvLFVxj2kvRgZSeeYx1Gceg5I
         rOX9V04kxsJLxtNrNdCfVGGr1+ret5kUkhop29FcQmXEU9Ll2tERdptEwaN+zNDVsC6c
         8UHwePP5p76ko72fvCKY9YkN9RjSD731/aXGYZGwWkRszc0ZUGcsHrcrAYp8M7GNgE5J
         Vysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202927; x=1790807727;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w0I0XDUUBqAVINonEdzJII4kcBVhkI+9B4d3GixNGtM=;
        b=Vx9g5+3aaICBd5ekI4ZaBpkDg9j7zcqBJ1MExDeWrUZoqiamPRE09CTzAV09PilfdX
         Ct29E+nDEY/7BR9D2NrBSyKjuFrMn6tyM2A4tS7tYWT/Uwqx6Om+/ErJk6OJpK5OEJLe
         neK+XGgnHB6G/s0egeCt8Ytk87fIFt5EyJEtCUoVC1caH+heJrWQSLfO8Ul8j8M+pSZq
         yXyoPLDy9pqZ2dWeXx7L2cHHiqUXPa/dXyMyYcEdkKdAiJTN/W9Qhky9TnXkquMc5WP2
         oeVl593NIAgzCeFotgkpx0gUE3hop4eyto8uKQ+vabnCmcRkcqRHUZTczgK2BlpU789Y
         8IYQ==
X-Forwarded-Encrypted: i=1; AKwUvBwAHBy/mUXBENlr8zcKfQ6sWRakDCwnzdsURnjvrpqPVixZVra2jBYw+2Z5NxDJSSG2LQu7DuzdH9Yf@vger.kernel.org
X-Gm-Message-State: AFuF++mBnYXPl1FIrhwsOSIRd4pwmpLGua8EyqF4WtzFZFo5+uKRPztU
	ElrHrSZmAxDPms/KuxhqBKHvSDVOBklEGoPw4lh7+ysD5ZwA23i3iVl9
X-Gm-Gg: AYBFou11qoK5fAj9hSd6K3PT68PGU3PlmfEAtb7MYQz3MTX//b8k3faj9On13Spu5/i
	7Ro7n0q6l/jN/wuPNMDXU8cJnwYna04xCz/xnZTNc6wtoCPrKcmHU2n+87keVZtuqdTZRvLPua9
	0G+LQVgwJQ8+SKRCa3WDlAwTGwz3xQobwwOpieWZYGyt8/GCnB0aVGiymorhiOh4Yw65yYgx5it
	ufckNCKkQkZNWMlPXlKc0RcmQHpDLvltTbCpFaNliX6M786INccCPztxzmVNKOZRznkTFbhKUaq
	9QSbm21jzOJA5ZAPgQaIpxhLciCdXauJs3JR7K0+9yAXTKuKIlveuhD1QsgOiI0dWvHyI8D7mv+
	axqNPrSQkqLq6ieg49M4wCQ0i49lsCD0nxumSoTBSw2g/0HyQb6PGYRuE+mrsoyGHgSQBP6mMyU
	hUYAthYfqbNM5oEphdXtCC4uKVnypXuVBQ68/FXCQ8by10L+8aZI2J8Ae36WI6hNEA7ObTWA0/W
	PTRs9ct2PVfM1X8bNHP016YaZNm//+z6Vepp3Kb6N7Zpwz9ACdPwR3CtbrQh8HQhnm23xYs5C5a
	+/ZllfGbd0DgneVnX2Q=
X-Received: by 2002:a05:6820:1612:b0:6b7:83c5:fdf7 with SMTP id 006d021491bc7-6d440df0d33mr802632eaf.56.1790202926598;
        Wed, 23 Sep 2026 15:35:26 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:26 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:45 -0600
Subject: [PATCH v11 21/38] dyndbg: move mod_name down from struct
 ddebug_table to _ddebug_info
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-21-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Jonathan Corbet <corbet@net.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=7681;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=XF9TuI7EwUd7R/5p1goQDXEUHeqSHXBYlumLQH7bhFE=;
 b=sVPD5jMKMfSdyTRGdEa7lMi2Q5x/Lj8MNXI0RTKr5jyN8O9mR4QGaUBOaSZMahaBHhZ0QDmhw
 Gp+K6aBbJj5BHVYGtboAG2B/VDIgBVrz3J+xOowh6uZLwimLjKXI8Qy
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
 lib/dynamic_debug.c           | 50 ++++++++++++++++++++++---------------------
 2 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index ec9b2544d537..bf6039191fa7 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -108,6 +108,7 @@ struct _ddebug_class_maps {
 };
 
 struct _ddebug_info {
+	const char *mod_name;
 	struct _ddebug_descs descs;
 	struct _ddebug_class_maps maps;
 };
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1880a9546944..1627e40efc8f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -46,7 +46,6 @@ extern struct ddebug_class_map __stop___dyndbg_class_maps[];
 
 struct ddebug_table {
 	struct list_head link;
-	const char *mod_name;
 	struct _ddebug_info info;
 };
 
@@ -254,10 +253,11 @@ static int ddebug_change(const struct ddebug_query *query,
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
@@ -269,8 +269,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
-		for (i = 0; i < dt->info.descs.len; i++) {
-			struct _ddebug *dp = &dt->info.descs.start[i];
+		for (i = 0; i < di->descs.len; i++) {
+			struct _ddebug *dp = &di->descs.start[i];
 
 			if (!ddebug_match_desc(query, dp, valid_class))
 				continue;
@@ -290,7 +290,7 @@ static int ddebug_change(const struct ddebug_query *query,
 #endif
 			v4pr_info("changed %s:%d [%s]%s %s => %s\n",
 				  trim_prefix(dp->filename), dp->lineno,
-				  dt->mod_name, dp->function,
+				  di->mod_name, dp->function,
 				  ddebug_describe_flags(dp->flags, &fbuf),
 				  ddebug_describe_flags(newflags, &nbuf));
 			dp->flags = newflags;
@@ -1085,12 +1085,12 @@ static bool ddebug_class_in_range(const int class_id, const struct ddebug_class_
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
 
@@ -1118,13 +1118,13 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 
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
@@ -1185,7 +1185,7 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	 * and length of the subrange at its edges.
 	 */
 	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->mod_name)) {
+		if (!strcmp(cm->mod_name, dt->info.mod_name)) {
 			if (!nc) {
 				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
 					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
@@ -1199,34 +1199,33 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 	}
 	dt->info.maps.len = nc;
 	if (nc)
-		vpr_info("module:%s attached %d classes\n", dt->mod_name, nc);
+		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
 }
 
 /*
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
@@ -1238,7 +1237,7 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", di->descs.len, modname);
+	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name);
 	return 0;
 }
 
@@ -1301,7 +1300,7 @@ static int ddebug_remove_module(const char *mod_name)
 
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry_safe(dt, nextdt, &ddebug_tables, link) {
-		if (dt->mod_name == mod_name) {
+		if (dt->info.mod_name == mod_name) {
 			ddebug_table_free(dt);
 			ret = 0;
 			break;
@@ -1321,7 +1320,8 @@ static int ddebug_module_notify(struct notifier_block *self, unsigned long val,
 
 	switch (val) {
 	case MODULE_STATE_COMING:
-		ret = ddebug_add_module(&mod->dyndbg_info, mod->name);
+		mod->dyndbg_info.mod_name = mod->name;
+		ret = ddebug_add_module(&mod->dyndbg_info);
 		if (ret)
 			WARN(1, "Failed to allocate memory: dyndbg may not work properly.\n");
 		break;
@@ -1417,7 +1417,8 @@ static int __init dynamic_debug_init(void)
 		if (strcmp(modname, iter->modname)) {
 			di.descs.len = mod_sites;
 			di.descs.start = iter_mod_start;
-			ret = ddebug_add_module(&di, modname);
+			di.mod_name = modname;
+			ret = ddebug_add_module(&di);
 			if (ret)
 				goto out_err;
 
@@ -1431,7 +1432,8 @@ static int __init dynamic_debug_init(void)
 
 	di.descs.len = mod_sites;
 	di.descs.start = iter_mod_start;
-	ret = ddebug_add_module(&di, modname);
+	di.mod_name = modname;
+	ret = ddebug_add_module(&di);
 	if (ret)
 		goto out_err;
 

-- 
2.55.0

