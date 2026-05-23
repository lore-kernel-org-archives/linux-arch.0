Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4678635F5F3
	for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779520541; cv=none; b=UMDbQW5QYWdXtTV4U6ARv0RI43aN3TI2kBe9pVgsn1uyJ4xcaK57fHTswY0m7YgpsaB1xz8kC6W7Uy5QWlqnE91nRGYBxnohMjSOvAp8JewRUY+EAgRjKSwBO9eK7Ugydhx3MOcnLqFRMyPFVFDNkfMbIEOPMW4povj1+GX7v6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779520541; c=relaxed/simple;
	bh=qsFp9hftJ9wN9JZF0ravNVaiqVz0jzQMsbL38C8P+po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pq3P/HFPmEwAz+DFH28RCwEeoO/aj8dc2PlX+JkDOUEsTJKx3Gz6s+x55zL3smv6YihnB7zE3+bNqsKiVKGPaPYGq4ZQgVLlSowHkV7V5aw5e94fc3z36o/8ClmAo4MZiDKPnYDivudwLvoGfT4yaAMPFvG65+FOfsmgA1KRmG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUYlzWXo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUYlzWXo"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso69933955e9.2
        for <linux-arch@vger.kernel.org>; Sat, 23 May 2026 00:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779520538; x=1780125338; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tgi5Ox6ccqbntSHArLmS05DNR8JpFiItMv2Y5xhyH8w=;
        b=YUYlzWXoUh1Qkqgs4Mwq7Z4ruaZzarY1wa78IbvwLGwKOc47WW+yydiwW72UaKotN/
         CcLX9UTe8638+L5gWrHZB/p2BHuqFrrUPJI0mpCE6/dEhYA8GTj0JzncezcwVqImH5xi
         M5Y8bifKiZfC389Dk1yYFtYiMNgO14PITazu6egnZegaaSkj0eR+6hb+natAxQIwe2is
         N8TXZrccNldixr/QVODNZWdp8nEuZ/N55A6kkdK/X2ntgEXVFQKEMhTNdsCtysxRgUFI
         NLx9Nynkc5fUVtmzCldT/FQe86FuCKiSKyrjOhWwAd+4AcyXda0YJoRCYdC1GyN2kjhh
         sLPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779520538; x=1780125338;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tgi5Ox6ccqbntSHArLmS05DNR8JpFiItMv2Y5xhyH8w=;
        b=Ir5dtQ0qPTlqd4nm+Ho5dQk0aoqKFIB4JDgAgYIeWZWdXCfhY1oZJT01UlK/L5Ukmr
         bYRBw6zC7GsDjr/bpnw+36wa8X4DxcZHawDpebvrHmzwo3huOT5DOBtndEBwjOFvXff2
         PwbE22cqb9zhyhco4DX53t0H7x7SMOGBOeVK2lGYfGNA9X4SY52fLMTyKy7riJEfpyJ3
         +ugesyNf7NJ7yV/r90A2pMVVw8VdBsbCnVmvx6ydB2FI+G3ii5YlVvPKs5w1Brd9dzyN
         ZvdOGvtO1PuiSJHx/XD1hROG5iN8EG0HCbEFtGlRSbdVGY3OuyvI4XU15LKbRdK2/8Kd
         Zp9g==
X-Forwarded-Encrypted: i=1; AFNElJ/X6Bsd8gLbN1TgtD82Qh2D8KPvd7hOm6WjsqIHHavErH71iqNzrQb8B3NUyQ96odGiauyiTYCnX/t6@vger.kernel.org
X-Gm-Message-State: AOJu0YzzcPYxXowed5GFHddaiyCSQqXnceD2QM6vFW9i+2tJ2dmgOySn
	IXoa06JGfdzI25q3Ao+pvGmC9bjJLakxLmaRBrOK+BLZj7wGEsLqnr/NLpJoMLnm/K4=
X-Gm-Gg: Acq92OHj7XP/pHAG/X0ssmAatogDQSW93Qjer3NodGGfgbqfCODoi4WX8NwXiYBMbxe
	pgqMX8dM+RhOjFbQgenYqSkFd2UTSFIILL9+Qbuw2pnnM38z+1gM2WRJt9ra4RyWrZV9ChBJ1b1
	LyfrrmAWRzbIxb98wqhSERDaQoiX9GGl2sPuqg2bYeRLMzwKRuAKWkLeLOF42I7fyhIJpCt5Oi7
	s5rA1jQuF8GVMoMnL/S8fRl54UeZ2pLiqHzOJoW3hiwcwhhKuz4i5cTkbj0jrGLUKINeHRkmEaw
	r9obwseEl6wJ1h0jziugwD9pq4Z0GEE7hge5H4INRyINiubM5c5P9cP7mVmOR2v5naK6n9Gsl/6
	5OIorznvJq7UiVqvcRtApEx4exPs4EdM3N0tZ+58A4N12PwimoRNgY3djtX0urbGuEmaAB6EQNP
	YctryFRFSrsavISUvNyvy8TT35NRu2
X-Received: by 2002:a05:600c:6217:b0:490:44d0:11b6 with SMTP id 5b1f17b1804b1-49044d01257mr98907975e9.12.1779520537521;
        Sat, 23 May 2026 00:15:37 -0700 (PDT)
Received: from [192.168.0.174] ([31.96.183.250])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-45eb6d5cb76sm8639838f8f.25.2026.05.23.00.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 00:15:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 23 May 2026 01:14:54 -0600
Subject: [PATCH v2 21/24] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-dd-maint-2-v2-21-b937312aa083@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779520485; l=5267;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=qsFp9hftJ9wN9JZF0ravNVaiqVz0jzQMsbL38C8P+po=;
 b=+/Gl/98lDu7LKgYvdWOycYyomPyNfnP+mh+C2VNzuySQ9RcMRFbTeLbjLxOPUyD+wtUy8nq59
 5a74xldU4XCBPnRM6g66sgE5yvDrQWsY9bB43s+GAuuEzz3CdsNZNqw
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
v2:

move RvB after SoB

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
---
 lib/dynamic_debug.c | 65 +++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 4a9b9bc9efc5..b877f4c6d778 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -162,8 +162,8 @@ static void vpr_info_dq(const struct ddebug_query *query, const char *msg)
 }
 
 static struct _ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							const char *class_string,
-							int *class_id)
+							 const char *class_string,
+							 int *class_id)
 {
 	struct _ddebug_class_map *map;
 	int i, idx;
@@ -1166,34 +1166,34 @@ static const struct proc_ops proc_fops = {
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
+ * Narrow a _ddebug_info's vector (@_vec) to the contiguous subrange
+ * of elements where ->mod_name matches @__di->mod_name.
+ *
+ * This scans the @_di->_vec for the first element matching the module
+ * name, and counts contiguous matches to define the subrange.
+ *
+ * @_i:   caller-provided index var
+ * @_sp:  cursor into @_vec
+ * @_di:  pointer to the struct _ddebug_info to be narrowed
+ * @_vec: name of the vector member (must have .start and .len)
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
@@ -1202,6 +1202,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
+	struct _ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1223,8 +1225,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 
 	INIT_LIST_HEAD(&dt->link);
 
-	if (di->maps.len)
-		ddebug_attach_module_classes(dt, di);
+	dd_set_module_subrange(i, cm, &dt->info, maps);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);

-- 
2.54.0

