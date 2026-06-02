Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E215E3D412B
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440554; cv=none; b=Yi7GKWYFYAJEOwLQFJHMBTKw+jLfODbUsfmGD6WZCP4Bij2fpWt2EEYJh9GAcqYGfTBu2O6/1TinabFZAhTfW9ZqyaqTBdVJrpc/OBO1wSS/2BSyyK5ZxxXPkx+EXCM6E8Q2O7CntIBXQwGYGdX4bpdNYZq08TIj+FJMKyMLAvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440554; c=relaxed/simple;
	bh=+3u25R2k2CdkONqYGWxvFW2luG05oZKja972BI/5Ht4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=scxMo967vwxjGTMqy9fsOhl2VY3uNCZU/ajEPS7STZSFpO40dVDtQe4v2pZ/JIoZOZCJQ77Sisk02A4wXxKfoh8E4OpKzzbLp4Okd31XA/xc32kwT47ZeRrf5EijbZyLxXIPFbGeclBFO4VYf1kh0f0rCAFWDdt6hJ9Av6VXXog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjDDtABi; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjDDtABi"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso4079084f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440550; x=1781045350; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjEFWr76AQqSw2M5qV2f/lpUyzp+VWKfHIVgFJLQv10=;
        b=MjDDtABiauuk+RUrA7JvoBMzHLAL4gZevA5+3faeNJQ0V5YcAm66NXfAjS4MWrOpYm
         hYtRvNzf6i19zbpprxSALJIoRxu540DMbg1faU3APWCAU8ZEg02dAYWcR295H6ZYQKkd
         UnycIXo2FG77N32HOg38pKH7MXpdgIBdFBIhxbwqBkm/uDpmVtxVsLxAkeNnLrHQJS9V
         vs7zSRJJ+3l0fYgUjbe9ml6HueKs09NXlByuRMVP9VZbDKcdk29ZONXFP9DTBcf1uhyZ
         KFDJRZlkkhPUg+qmfEF9ztioTQDbcrFpPikp3We/OTAdH+XVUKXyTy7SMzX2gQtDXYgu
         iy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440550; x=1781045350;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EjEFWr76AQqSw2M5qV2f/lpUyzp+VWKfHIVgFJLQv10=;
        b=TtnJyVE006BsntrnlSOtAtR/LRBJIRmyPlvzEOKMzn60J/SP2oqlklj5HRzwnxbVfL
         4RPrSiCdAIuoTdFB7XboLfZFFUEy6MDN2zyYVmDGhfJmNj01Zv7VWYWF7Vy5xq15aXd/
         q0r/J9U25A5cJEQVFPshGNCNqkQo0ZtI+Bm6aNFJEouPplmP15rc4A6SWPR4WFNs4MZA
         IWh4qiJ3ew9ZWW+Qowc7Ew7ogs1EU1JLk9Rq5FJGvh4ndTRqVF5PmUnL1tKrpv4qhXYL
         0BoQz/WpgJ1LBdiXeKBOxQsAvJjkT+7zDXLK86GBI2lUBn2Tx7ibnUYi+s6GkA8gLbkt
         i6vQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aDqtbxm8ukvbax74nffiDRXgGMf3AdsfikIS5sJ/GUUkALFc9GzCS2ZWN+/re6PPmWSJtPRzFjZqf@vger.kernel.org
X-Gm-Message-State: AOJu0YwhPVCO5ey3RGP+RZQys8pxrBu/jlHEjSozX0Mrzlt2NJ2rj9hH
	8xOSOOUc+zAMtC3fF8XybkrG+sNAJtM7cIbryn8sZDsAhFgLoAK1V7t7
X-Gm-Gg: Acq92OFCUfdknwZmXjAZ6iKXBth3QYIjf+QyuveRdYcJvKIeJJUdejr9FsUbf/7r9+v
	H1i98zdVzMoUcJC6VxsHpUg6z0bajq9Y7SpKNYFYWuR3AkKskCwhxKYE2+Q+bTZu43D0mT7ZVav
	Q8Ez2SOT7XuuaDUAnEKQRQFGhLnwWfKI3mM5qJrmJVMHAgllXuZwy3qmaujaCmDMgXGTRkKqhsq
	UsOl/w4dk8mTBKX/rsMrGhgc+eaDixCcZxyJsIhAvtgtWdR2RFXR6i4NgckzPiyhQ/PQxY6GFA0
	pZj9pFqjOBK3fNNs9zPVbZBwb4lIkv/AO2bND+gyjuRF8o0Nrn/C/93WdJubMhSfeCfTTeycXQb
	ggLftmRGVSFl22UVKZiU1iZFiP5VPKwSY4yHiuzPRhwFEpCAtXf0XN8D6nsa/6xstxzCFcom0oe
	EWKZ42fzejqgB823ueUxanVkAEWFe7ZPI5Zp//klCJ1g==
X-Received: by 2002:a05:600c:3104:b0:490:b265:7940 with SMTP id 5b1f17b1804b1-490b5ebd2d0mr10787025e9.23.1780440550416;
        Tue, 02 Jun 2026 15:49:10 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:49:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:18 +0000
Subject: [PATCH v4 21/25] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-21-19a1445585a8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=5917;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=+3u25R2k2CdkONqYGWxvFW2luG05oZKja972BI/5Ht4=;
 b=4kehgvsl6FS6J0ZJB6KBKBTiT++oD1Wavj5nbRSlyVY0opN4/nukJzkp8RUjCVQSXKYN1rhA1
 7ZXyI/jZ2VYB9HvjfdsnYRwKPs8LFAB7cV8RLJhe+MXHOaAodn10hi2
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

The body of ddebug_attach_module_classes() is just a code-block that
finds the contiguous subrange of classmaps matching on modname, and
saves it into the ddebug_table's info record.

Implement this block in a macro to accommodate different component
vectors in the "box" (as named in the for_subvec macro).  We will
reuse this macro shortly.

And hoist its invocation out of ddebug_attach_module_classes() up into
ddebug_add_module().  This moves the filtering step up closer to
dynamic_debug_init(), which already segments the builtin pr_debug
descriptors on their mod_name boundaries.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v3: expand block-comment in ddebug_add_module

v2: move RvB after SoB

finish hoist - drop old fn - ddebug_attach_module_classes

the v1 rev left the old ddebug_attach_module_classes in place, but it
is completely redundant now, since it already lost the list-linking
job it was doing.

It was being cut out later in the patchset (in the unsent API
adaptation phase), but for cleaner review, lets excise it now.

OLD all-in-1-series (pre split into reviewable chunks)

v10?- reordered params to match kdoc

v12- refactor/rename: s/dd_mark_vector_subrange/dd_set_module_subrange/

1. Renamed the macro from dd_mark_vector_subrange to
   dd_set_module_subrange to better reflect its purpose of narrowing a
   vector to a module-specific subrange.

2. Simplified the arguments by removing the redundant _dst, as the _di
   pointer already provides access to the target _ddebug_info struct.

3. Refactored for Clarity: Instead of overwriting the struct's start
   pointer while the for_subvec loop is using it to iterate, I
   introduced a temporary __start variable. This avoids the "subtle"
   side effect and makes the logic easier to follow.

4. Updated Documentation: Improved the comment block to explicitly
   state that the macro scans for the first match and counts
   contiguous elements.

fiuxp
---
 lib/dynamic_debug.c | 80 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index c15b692ffc60..996daf0a05b5 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1169,34 +1169,34 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
-static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
-{
-	struct _ddebug_class_map *cm;
-	int i, nc = 0;
-
-	/*
-	 * Find this module's classmaps in a subrange/wholerange of
-	 * the builtin/modular classmap vector/section.  Save the start
-	 * and length of the subrange at its edges.
-	 */
-	for_subvec(i, cm, di, maps) {
-		if (!strcmp(cm->mod_name, dt->info.mod_name)) {
-			if (!nc) {
-				v2pr_info("start subrange, class[%d]: module:%s base:%d len:%d ty:%d\n",
-					  i, cm->mod_name, cm->base, cm->length, cm->map_type);
-				dt->info.maps.start = cm;
-			}
-			nc++;
-		} else if (nc) {
-			/* end of matching classmaps */
-			break;
-		}
-	}
-	if (nc) {
-		dt->info.maps.len = nc;
-		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
-	}
-}
+/*
+ * dd_set_module_subrange - find matching subrange of classmaps
+ * @_i:   caller-provided index var
+ * @_sp:  cursor into @_vec
+ * @_di:  pointer to the struct _ddebug_info to be narrowed
+ * @_vec: name of the vector member (must have .start and .len)
+ *
+ * Narrow a _ddebug_info's vector (@_vec) of classmaps to the
+ * contiguous subrange of elements where ->mod_name matches
+ * @__di->mod_name.  This is primarily for builtins, loadable modules
+ * have only their classmaps, and dont need this sub-selection.
+ */
+#define dd_set_module_subrange(_i, _sp, _di, _vec) ({			\
+	struct _ddebug_info *__di = (_di);				\
+	typeof(__di->_vec.start) __start = NULL;			\
+	int __nc = 0;							\
+	for_subvec(_i, _sp, __di, _vec) {				\
+		if (!strcmp((_sp)->mod_name, __di->mod_name)) {		\
+			if (!__nc++)					\
+				__start = (_sp);			\
+		} else if (__nc) {					\
+			break; /* end of consecutive matches */		\
+		}							\
+	}								\
+	if (__nc)							\
+		__di->_vec.start = __start;				\
+	__di->_vec.len = __nc;						\
+})
 
 /*
  * Allocate a new ddebug_table for the given module
@@ -1205,6 +1205,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
+	struct _ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1217,17 +1219,21 @@ static int ddebug_add_module(struct _ddebug_info *di)
 		return -ENOMEM;
 	}
 	/*
-	 * For built-in modules, name (as supplied in di by its
-	 * callers) lives in .rodata and is immortal. For loaded
-	 * modules, name points at the name[] member of struct module,
-	 * which lives at least as long as this struct ddebug_table.
+	 * For built-in modules, di is a partial cursor into the
+	 * builtin dyndbg data; the descriptors are the subrange
+	 * matching the modname, but the classmaps are the full set.
+	 * We find and set the relevant subrange of classmaps here.
+	 *
+	 * The modname string is in .rodata, the descriptors and
+	 * classmaps are in writable .data. All are immortal.
+	 *
+	 * For loaded modules, mod_name points at the name[] member
+	 * of struct module, and the descriptors and classmaps point
+	 * at the module's ELF sections; all have lifetimes matching
+	 * the module's presence.
 	 */
 	dt->info = *di;
-
-	INIT_LIST_HEAD(&dt->link);
-
-	if (di->maps.len)
-		ddebug_attach_module_classes(dt, di);
+	dd_set_module_subrange(i, cm, &dt->info, maps);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);

-- 
2.54.0

