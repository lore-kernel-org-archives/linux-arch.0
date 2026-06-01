Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF8E3A6405
	for <linux-arch@vger.kernel.org>; Mon,  1 Jun 2026 12:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780315557; cv=none; b=WM/5Fuymlk5k0hVpPo/TG/pGgC+bad05kzj/eAxDd3l1SPznXZSe377loiUKegtCET0UMA8hTaYqsjIpeAN5cqDtgq1oTe6Swokmq5hzFTbRSb1US4HiF8F++Hs4VDSD22N623JLGyozFfGrwvpk0yC0vZsn+iR6xI3BGRPTyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780315557; c=relaxed/simple;
	bh=+pK3ELU4w20zDsjOhD6mPHGUqpMWzd0Bpz7aF7sTnso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i45TmbV9Do9YEfzKncN8K8+xZTSR+30OLXZNC6k+jB1pdIYtiJYRYjvr7yhuzNi+9LiEpkL8z0CZTzUZQEY9HqqA2A6lVhI4aGCm6IJyTxgFLJkyvGeYHmeLvtp2/3iO2/Vv4W5f/7SUFqhxvo3qXTsgT3ztx1oxFmO2iYiIexw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p3WQ229V; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3WQ229V"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-45ef189aa1cso2562523f8f.0
        for <linux-arch@vger.kernel.org>; Mon, 01 Jun 2026 05:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780315552; x=1780920352; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hgs5d09klBJiSQ6rUhilK4VUYGAVQwrVr78Zd+w8cSs=;
        b=p3WQ229VAQoRcGr8T8Rp72oKuHzXAmi5IYwpLYvBjC9WAfva7kwmPNqDO24pK/IbrX
         K7GWoMMLmaZf/lJz/X1ojRcveYJXVlkkBaQaj8rdi8G2YDgfMxJx49s2xkhUF0YXaR9H
         Jn4fNSEMbpFJlIbZd5V1AQZIA0DS5tck8gzQ9x72IfXJ0R/lQOnpNnfbHSOvkR31tuZA
         GJa1suddix3nuFDp9s1Uxk0c1zaOjb7FxC0ixPw2K2gosxUXgVjqpP1DkY7Uv/Zi0RQf
         hksQsEkrYLMm4nhOAKevdn30BOZQZKaz5PYNARpAnmHBygL7oKrXZMo48gUwnMUT2pzE
         csew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780315552; x=1780920352;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Hgs5d09klBJiSQ6rUhilK4VUYGAVQwrVr78Zd+w8cSs=;
        b=O34h7UhEMIPMhsGx3LtQiGga1kB2zptSkbIAryV7BdOGe+qDrV0T/8P+eblPrXWrnb
         +/f6KHt2WpU2DTYv9lwUmatGGTeIzRbV/nKymbo12Ehf5J6ePSAVL3KHzy0SUC9cJwg4
         szovQCP7LMR2aqVA/JKL9BjLJ7vbMJJE5nq1bdAUozfSQi5c0QClh09nLKc3w5bnUubO
         kY+Bnki39y5iyAbeGF+7oUhN2jcxcZwRIgkvJt13ieEyRaVh1B5yKVe7cmF91OIJ0t7p
         ep5h+rn78bc4cqtUy3yVzJKV7BkmyieiyXGTWS+vxL4GQ4I+4Hy6gQNr6MzTboe3haGz
         +Zhg==
X-Forwarded-Encrypted: i=1; AFNElJ+pC8eVtGGH0uL9+bev4I4UraqmJgKsdNHuH5wO3CywNohwV3ilI0WJ8oW2uf2CXrCAny/NSUEqhN5Q@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCGxJGIVk2ZNri+H0jHouhboacoLj2la+QSA6iYgNcptUVo6f
	/o+cM8kLAlqvHdrfZSRdirVq66E/kgrB+6c2cXYViMUxHcF2XhbsMRvS
X-Gm-Gg: Acq92OHF6FiQD5wRqziDK70RmXrsrcG4LLe1dp9XaGvw5GOkouUXfAFNxUbtt9lU8Ep
	LJ48War42koZ25rU3ceMpWaDkWD3ZLd1o1GVUYZG5LFwk163IwvfFqZbICzeX+eQ/QlgYwM1kc0
	ucnCY6VThuq+w7V4v4TAbiEfqghkXck/cPrGHLqbl6I2W/kYYgzG/eQHr/BsqHzLD5VenKJKJ+H
	cBa6Zw6PaZMr0vVcGV2pLUm68er5pkUYG0QajZrSZFXHYon0C+1MG4dDdY9bfOL8In6Y3ThMJDf
	scwI4xgG8J+ZtiTL3TbFBHSeprFuGqOATbXZZYjBdA9HXQLJSluaEb4WPtoY91qVNUeQ6+VO2Qn
	HeIjitodxuw6LIl+4ScGjiugSLJOxRWeAUDB+SuGRxhOU3OjOK4L1f8BQckn6Ji5BqYPi2LoZXi
	fTxoMZhS1qMoILr3r1p4zMkosWIpbpmUi4UYTGzGiYtA==
X-Received: by 2002:a05:600c:6091:b0:490:6237:521b with SMTP id 5b1f17b1804b1-490a2b6b21cmr202105565e9.27.1780315552020;
        Mon, 01 Jun 2026 05:05:52 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4909c152570sm103972805e9.9.2026.06.01.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:05:51 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Mon, 01 Jun 2026 12:05:07 +0000
Subject: [PATCH v3 21/24] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-dd-maint-2-v3-21-4a15b241bd3c@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780315495; l=6283;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=+pK3ELU4w20zDsjOhD6mPHGUqpMWzd0Bpz7aF7sTnso=;
 b=TbS1phZ6wCP9h1H8gSJ3AR6y0BvwAqEZArTZQwJ8qYv+aXmDh+2BAvoO8DY2i6pV26d8lADbU
 0qmPtH7gGYjAJyolynwAyf50nCvEEH59PFNeDem71pJ6wZCuqwLuupT
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
 lib/dynamic_debug.c | 84 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 39 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index ebfff48c4a6c..fdb730db385e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -161,8 +161,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static struct _ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							const char *class_string,
-							int *class_id)
+							 const char *class_string,
+							 int *class_id)
 {
 	struct _ddebug_class_map *map;
 	int i, idx;
@@ -1167,34 +1167,34 @@ static const struct proc_ops proc_fops = {
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
@@ -1203,6 +1203,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
+	struct _ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1215,17 +1217,21 @@ static int ddebug_add_module(struct _ddebug_info *di)
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

