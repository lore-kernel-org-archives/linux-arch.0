Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340543C10A4
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477152; cv=none; b=MvTfJDn3yNFD2u1WxB8iDCO6Zz4886PYwkGODgEvDobeUvAHo3Hqu/azDjoZMxX3LsZuUWDuTDkkg/FecjaotHpsaoxmyMNYl/m8qouH52y7TfVuuONfqqVEuFVhAkOORYm32TiL36cp0jeqiYDBPIqGkAOtc0UuLz/VFJvxjLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477152; c=relaxed/simple;
	bh=y6qM/kqNwYmuj1o8I5+E9cTtId3LZfSsuD6PkviU3E8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O4xUkRSND5m7G6UllfG1LYheI70NhfFZ1e13b0ogB7NR0QYzTlMv/RGpfBq34mHgnmFMlnhJoB03lEVFhrQOIR7F58RswPW4j/QIg4vRHyk2OY4gJ69LsmcwZcP7IbOnd/D//bleUaM4NJR71Wzo71IN34QgywAQxJtUHkbOucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EL1k3mJ+; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EL1k3mJ+"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-48d6c621a67so105331b6e.3
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477147; x=1784081947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TI/qT4p9NQ5m/zckRNwVJN2R51Z23VJQglm9K8Zvmjw=;
        b=EL1k3mJ+BF2vIn9fQvzJy2uFwyFn9ur5sHZU6nBd9d3INut7WN8uwNzj1xoKzYXRxL
         tk3LyuQNwQxKPc7f9U0wu6DyNdBd2XERCa9GTIkZxRljIRSKbTmrMgOqei69dBFsvdIz
         0kEhmyqn02AwAaiM2hYKGqM3RNA+1gqhg/bFhuu9+ucZJsq9O11PIxXa+vlB/j6Y1hvW
         iMkEgI6cuQ2l3d6HHWHbL2Csi73DDE8JI+cxwexJi9ZC5XrAySAw/l53WQkH3ZzFpJ0M
         BDB/vKxJfTshgieh43ivVia3DwO7yJHLj8WEJCalt28iHu5hg2VgiJlPLixI/K8LyuFv
         Ny+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477147; x=1784081947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TI/qT4p9NQ5m/zckRNwVJN2R51Z23VJQglm9K8Zvmjw=;
        b=d4MmUeNSJEpHVGEvHykQpEhOIF21wNAq5fpZbvdMSUlPyeG/Xi0lDCnBjXDHw/GmTz
         alJ+nlcO1Xu/Bw99Qaq8ETTsA7RyCGKD5G2LYrdhDxat213vrLHERAP6IvrQuc9WHFTo
         c5Hgr7xvzFYeEd/dMN1A1tnKfy21AwB43xoVkfo5aROCza0TAJmErq0y+C3GQ8gLTSPk
         YWfU2j8G4YUDhMQDVJXIU1damQUokCZSpG/F/4nVI2wyJMzLgSHx9WXd6QK5n/qUnp4H
         DcFqexFudAxaBYqANM62IWeNkDL8/N3frrv3Hez6wEkaHJOh46BNi94GxqQP4ytcSnm8
         6kQA==
X-Forwarded-Encrypted: i=1; AFNElJ/c61CBxM2gpXla/TxJoVMvtYsirZhijMl+W5/zhxSD3Ub4H/JR6sXEDJWckoaCFUsjv7DfhP4+zeMZ@vger.kernel.org
X-Gm-Message-State: AOJu0YyGLq+3bv/oM2m0TJq70smGAIW0oTgBeQoVFA5a2jNLUPXvUNJU
	6nuvTsO7MH/xmglS3za+45QMrvDkHgEnC6HkORNzGg8IIHFs44naNIRG
X-Gm-Gg: AfdE7cmSFtDXwUR4jP3VQQKGngMfcHtgydWdEesjPPNpvFMbh16GTI7FYR8BG+b7L+I
	NCFL4tzDIBGT8eGK7S7IL5+TEE082d49vGIkgdmKqQ6vzI+4IUY1zFJAlvbRo3SFdhxWEVIzYtG
	yV8jdQStqlxlnqiJvw3sEO20l+BxUy1k3fozP8Lb1Ua4150TAw31QWP0ACDNRVhuHmRe0A+uDns
	maxXmpZKRtgbz8bRt52XKcC3u+skXQwkgoYJ/jkKQyDAdjY8V/yKF0hO7jvJ5Fda77r2SElJCyE
	nokbzrYStzF46y/2qa4O9GdHwTBZMEeLDi9iKp1tFBprY0jkS5UsgfNHCTd4cchAma9xw/zveOa
	g9D4b/3MFzdd59pylc5DUnRSjnnrAX59Sf1XqThVexJwXpo/4dD9W7AI8rlLObD/7X0P6LdPks3
	6hroqHOliWlWcb0zD27QTKsQnr6t1HGmRO7TECHYN3sLhvPJe9R7w=
X-Received: by 2002:a05:6808:8955:b0:487:530f:5754 with SMTP id 5614622812f47-4a2043e4bbamr405960b6e.20.1783477146722;
        Tue, 07 Jul 2026 19:19:06 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:19:06 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:22 -0600
Subject: [PATCH v6 22/24] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-22-381f3edb0045@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=5915;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=y6qM/kqNwYmuj1o8I5+E9cTtId3LZfSsuD6PkviU3E8=;
 b=C5xWlPnwit9dEjn/4haJlgEZovBoNEgQOrPx5Fh0A237vD3NHtJlfMpFEVk19VCdGtMr8C2Sh
 jy0uX9h8MyiABpBXikgA2rj6+hoaWNI5vUMPdz9FlgN1W33i9+xOFFS
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
index a9965ec1807a..1d5b9f68791a 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1175,34 +1175,34 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
-static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug_info *di)
-{
-	struct ddebug_class_map *cm;
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
@@ -1211,6 +1211,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
+	struct ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1223,17 +1225,21 @@ static int ddebug_add_module(struct _ddebug_info *di)
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
2.55.0

