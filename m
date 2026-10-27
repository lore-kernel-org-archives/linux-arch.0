Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132538;
	b=2zZtJoObbaO2yvPBpwy3cpONF9BgM3hxpx10kH/xb0nvJVnJDjGqKHVskdJhmOqi8pl+
	 PdkhTRlybhcwEEnM47s7G0LyOLTz9IdjrNB8IhZ6xfXcKb0GM3SNXEhdS4AtU6agSQzKa
	 xIagdBLfyqct2GE3NK3qntSabTIHNnT+lKE77IcgWKe9TaBFNJ4cktFhwKj4+sl0wew5u
	 sSzv80o7UjOR5j5TsKLPc2G5xYWpweJxJTTZwhPmWAziZhyp4B78Q1Uglm5oBG5OqHZ8Z
	 bI1Z7hmsgkQYbDDqe/lGvGzuv1sYxKRlrRrK7d+OgwioMFJjBOzqRxaWHp9AZsblmYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132538;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ylBjqJViMhpTwcLNrs0KnR6NvwvPIgav3iuJuli7BzQ=;
	b=SV/8q16fg8n8aQ+fEDpi3h73LtseiK6AfCgnr89qrHIlfuCaNsCRRHNDJUph/+wfRg1j
	 ips+VIclb5T+WxO46JHrOR8Fl20ECH2WHq1KfjEiNe77fn7jWvMGaVlPWy7bIPLTZuS9I
	 UavJbW7BZx22ko6HAZOc23u0AcERwE0d4ZqssKHWn1xbTXZLwKNEaWAMh2HDXsZdk3ZyG
	 MBhifKI2gLdobk0N2t7sPmI1SHww1dP0CXZDRT7LFEu4+A7UNo4HrwvHJpgBLR+LEL3BB
	 yxikV1HkGLT/bu7oL5UHWiJGMoZ0YsSrU2lbvqTnR/chawKxFYU8ZVmByFad5zO8J5Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvaUAoJk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5511606A336;
	Tue, 27 Oct 2026 20:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RvaUAoJk
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132537;
	b=bZRMvY3m/ZP5GIrSqg1RYQ1NYO9IBwphRJkS76JY9KbwwYlyld7nla0kpCMuDea+jwCG
	 tCVMHmjKMsWnQtjYoA7ZF5/2fGfK1Qw+Cv+VyOgB8k7VxlFngTqzN1wEI35HBsaXfXPi/
	 MufKKvGr6GskTpuydQXJapSUeAKLQOtOchsMF+nQqu5AO1bVg3BibDl/Litm4nS2vdOb3
	 TorFDEUhG9MfwuFT8wPxqKHKMrWdiziNSWNaV1h/4ava8i3TB6kDHfItxQYW9conC7496
	 yRY/5OvYOcgm0hFI1nVGYWys7L2qRlG6mbIFL4RJVgjcHtqAGnxFNvGC7UvM6mtpsww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132537;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ylBjqJViMhpTwcLNrs0KnR6NvwvPIgav3iuJuli7BzQ=;
	b=pS7jfIxXT5VJzF+7ph7RFanNReztbaSsJlO6DS9+9hOZ+4r/jO/9oTQd4L/M8k5ruSig
	 xgdshCJ+VDJfZf2LW7Aw1HZDS85G/J8P8LqAfh4ScOHGwjvf9H9qsiyCgHY/1XQW7FE7a
	 qT5UKoPkHFz/jB5pEPl29TVM62mIBA6/TrnuCo+4JYlpRxzD0f+8I0HtQoz6jrG+fXfkK
	 EIfq/I22ySiSvwbpKLh+Crt92eX3jol64VnFfF1KsYJ5tCtLZHq2EvBbLTC6fDThI4c+/
	 ooHp61D2W4MbapiZLDajVtEC5/MLcysq6ZYUqSEBQGzOsm944iaH4JvxWu7tSiA/EGg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 18FBE1F031E3;
	Tue, 27 Oct 2026 20:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132537;
	bh=ylBjqJViMhpTwcLNrs0KnR6NvwvPIgav3iuJuli7BzQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=RvaUAoJkFejTH+q4FtPfrlADQS/Ig6s0Kovv8K/FVA0YXDsp/2ECb/uhBtY8/CjBf
	 pDrbZTADam/Ufgs7qWYw/MLYiIZaxbacmHtQaDFFUJRtq4ZqDbGqvKT9Zr3AeX8t8Q
	 kC/AiI8xsdES3GBTjQJ+mMFjv8k2uAIcFyUqvVZQiv2IiuNNuKRudWQUAUBSxbALRP
	 4zanEHRD8Zew2s6WkP32Ls2Z+xDs/3oCpV7ppHCtqNkUov7x7HykbTp1jr/RnufWsQ
	 QgeQKlJCj7stcAiIiGjap1yepQ3obLXbO595rLiJE6T9TgdDB1WSLDoV0Lz5TA+VRJ
	 bJnLrrK+v/6vg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 63FDF45231;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:16 -0600
Subject: [PATCH v13 16/39] dyndbg: replace classmap list with an
 array-slice
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Post: <mailto:linux-arch@vger.kernel.org>
List-Help: <mailto:linux-arch+help@vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-arch+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261027-dd-cmap-part2-clean-v13-16-9267923be612@gmail.com>
References: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
In-Reply-To: <20261027-dd-cmap-part2-clean-v13-0-9267923be612@gmail.com>
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
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jason Baron <jbaron@redhat.com>, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=5766;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=FbC+U5SzF/MC71lnuOjxn7IrkxDsicC3GNkHfHM9UpU=;
 b=q79OU6vc630PkBVDUK9JoBgM/JlsjeK1KRKgCbNMLQn0vXIBoQJz/NG/vxAjUBOitZcBWuMtT
 ai6cmAjTDTRCjB6ru7w15+f64FhqPJ6zdXW1X6+W3TUhC7Mr6608Zrw
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

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
 lib/dynamic_debug.c           | 64 +++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index baf5c0853f45..9cd262a3fcba 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -76,7 +76,6 @@ enum ddebug_class_map_type {
 };
 
 struct ddebug_class_map {
-	struct list_head link;
 	struct module *mod;
 	const char *mod_name;	/* needed for builtins */
 	const char **class_names;
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 474df0dbedc1..1c0604d7e3cc 100644
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
@@ -235,7 +237,7 @@ static int ddebug_change(const struct ddebug_query *query,
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
-	int __outvar valid_class;
+	int valid_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
@@ -1067,9 +1069,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1153,30 +1156,34 @@ static const struct proc_ops proc_fops = {
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
@@ -1208,10 +1215,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1324,8 +1330,8 @@ static void ddebug_remove_all_tables(void)
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
2.56.0


