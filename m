Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0A47607B
	for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 20:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667465; cv=none; b=VQM6/UOtlq9NMQRm2ltw7CgbFphFXBMEeUAX+sxkHiib9JU2VR+T1a4u3Dy9NKJIcy7Ez80iqJV8xtU/9LCLqSme7aDV105Y/wUDa7doZDzy7ep8y+0fLFkmTtdpVrPVXEaQnja2RTOqLBldbHj86N8A50VbptvVfZTgy8vz4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667465; c=relaxed/simple;
	bh=UvvdNmjYasQcfrXvHNJC1I4lW9B4CfA7EsDivJfXS3s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQOmTABGwdsNXRchxgr9HOmSU2XERsR8njJBznKDI0GFnfF2yC71ehL3QjmtmVKE5EJXS97itp5qYsEbgN25b1RlIQLj/ajVVOePyf1+i6adMmvCSPGYKz10fKezM5DRVgnEY5aKg3ImtHH+8gOkIFjg3+xyIHufWz0N9oA8dAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1GFSb5z; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1GFSb5z"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso3307332a34.0
        for <linux-arch@vger.kernel.org>; Tue, 21 Jul 2026 13:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784667458; x=1785272258; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ENoNkwvV1VjhwDC+HDQhxn3UZGq4A9V7zaG+rkGi914=;
        b=U1GFSb5zqUvmW5n6pBP35Osu8lFWkgdvQxJhj16hN7r6jfQKg59DTB3v1DohmpnTVC
         FIvNkcZzwS7XuHptMoVLF21lcWKyIIRffdyqt6bi1e7dKr9EguHg4cDirdOaOoFdjkE2
         3K67GmAw49e99B4riRNapYVOhFSTO9g8qnnlH7s+HKzVGeA9ciBqifYGKawhGhtXYNJF
         3E6J3r85voG21K+cda10zUoygsiLmksnuzDtV3ak9wa6B+RSLunmNQ6A3q9fQvvMPm2u
         EOTTQWK9zwIQoCR0De9YH/QGZ3GJ/BeYmxM0dkkz/MiXEcdra/vfFSxYkksgfMOQ/EBQ
         ZvhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667458; x=1785272258;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ENoNkwvV1VjhwDC+HDQhxn3UZGq4A9V7zaG+rkGi914=;
        b=YeZuCDSFSsOxxfAAeksNk3cIFzCh7s+rg3M7ZMDfd5B3GM10yHq206kQ1eB+YmEzOB
         HqHhOgWRTxgwAHGb79awA4GLDbZbtGcvVCerPpNVPONagQN9fevucveGq1JO4FdO2VAJ
         MINTcYBbG0Ct5dM1ZO/97TrO7/FrCjXQT57AhfmOYiByG85nNONDsVVnZ3Op3fa2KfFb
         Hdj4KHOwi8wOkGXWepmL2V2nXLvE9sCkwM/zVWBaefyEfXfVW7Xq84F09L0orL8wqPfg
         O9YciWViuHOUaCY8WQ0f0WvBnuQIu881485xzYC3j21THZ/Gst/N/K41XMbRa/oxH6H0
         e3Vg==
X-Forwarded-Encrypted: i=1; AHgh+RruhivTrM5E0QsXN28WFa8mZIoiov99n8nz1bfC+6SsNb314KeJ9tvWF67YCONFeu47PgafqNqkwmRg@vger.kernel.org
X-Gm-Message-State: AOJu0YzGadJ+X+Cmb7i/5sZNsDzAeJNOl6Daih3dzdPI1HlSHn7O+hkb
	yLtXfUQS0tjDVVngXUorVoL59gnAwEtBGLsatfIGI0rrVRetgbtHShhG
X-Gm-Gg: AfdE7clmIUQMTfko113sW3JtnjW9fJYCSTkRaxsc0NJEeIRceyTdWnaEEdbyC1gJ1xK
	NqtsY2YYFpafQ2qPO//QdmT1lBvvTZjEClLnYG09/QZI/+zw6W4jr3EQztM1nibZ5KrMsKC305o
	5yOzfU8ZcQ1uak4h2UBxmWyUvPj7zdcs/1wP4Nlif/OOhktfqSILxXWCN172771NjTAb5QaPA5v
	tjTXvHdmDZNDGbvzkCOIA8EZ8ebUsvrRL9+6wGUJPtssuRV2n3KAf4HbwtWzT82n+mgoBqC+KRZ
	vDt3a4t5YlpkdrxRsSUs6Vm8NIXQ1V0/zdtAPvlLppMXCQg3DF6hMwMBPXG6k7AXjAwsZs8Wm99
	FJx4RK6nbBYAPZ/I8O2s44cGvi4cUEpLVON2K7QThrTuFTa9rZjEv6Bb3pO3t7KXfnqMIBDzlnJ
	uqUwpftzF3VKZIZZoeBLBtVBvM+hRz7pqO39F+NtpXAc4boIL8fOp7KR66rSKqNwYupsYv1Ij1Q
	3OsZriP334vbuvz8CZ/OBkdcsDeyvp2DP/p
X-Received: by 2002:a05:6830:3145:b0:7ec:4121:f56 with SMTP id 46e09a7af769-7ee22cf01f7mr775083a34.1.1784667457927;
        Tue, 21 Jul 2026 13:57:37 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7edaf94a494sm11134501a34.13.2026.07.21.13.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 13:57:37 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 21 Jul 2026 14:57:11 -0600
Subject: [PATCH v7 22/29] dyndbg: replace classmap list with an array-slice
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-dd-maint-2-v7-22-010fbe73b311@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784667429; l=6080;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=UvvdNmjYasQcfrXvHNJC1I4lW9B4CfA7EsDivJfXS3s=;
 b=rxFb6ZGkhDYPOqJFnpXJBtHWBS8ZQjQtuLRf6dKIjo9UoKzjlViHh8BkvzPU1dmnhjOTXeusH
 jGrglaXPkxLDXjXuuf/29jJltCrzIWLhb4BlsqAUxv9rCUycIZ58+HJ
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
index 17cc1ae7baef..5e484862f814 100644
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
index 364a55fc9447..5abf6ff6be52 100644
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
@@ -1070,9 +1071,10 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 
 static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map;
+	struct ddebug_class_map *map = iter->table->classes;
+	int i, nc = iter->table->num_classes;
 
-	list_for_each_entry(map, &iter->table->maps, link)
+	for (i = 0; i < nc; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1156,30 +1158,34 @@ static const struct proc_ops proc_fops = {
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
@@ -1211,10 +1217,9 @@ static int ddebug_add_module(struct _ddebug_info *di, const char *modname)
 	dt->num_ddebugs = di->num_descs;
 
 	INIT_LIST_HEAD(&dt->link);
-	INIT_LIST_HEAD(&dt->maps);
 
 	if (di->classes && di->num_classes)
-		ddebug_attach_module_classes(dt, di->classes, di->num_classes);
+		ddebug_attach_module_classes(dt, di);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
@@ -1327,8 +1332,8 @@ static void ddebug_remove_all_tables(void)
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

