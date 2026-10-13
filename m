Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED5247A0C3;
	Tue, 13 Oct 2026 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858999; cv=none; b=Pc2CcjiaMjak+pdRlzyCaNrfpk2pEJN2Ph8b3W1qI/d5MtMDA7ApuST0zdDX1oLsXaIZpJjddEsYgIwMnXGLYSjFt8XLvjJ2Xx4qaNW5yF2TmgQ3MjbbBjxpaK1Ugl6fZ1Zt3G9Q76/z65rn6DquAIgLg0A1Gcr+kRnV9hd1a0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858999; c=relaxed/simple;
	bh=d4fHYL1oawYv1SgxdIc+9V0K/wiZS/zzFNyXIpqp2no=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lStv7ttt4SA8xevvJV0JSO9yAKu7ZOZDLSl3AMZ81ubrrIsiCcv3YNDXiSkvfjyILbJwOMlMCEGWQpbl+q7TcfZiD16oQ+Dk3Utrr2wyS3dwiQxXQjF5Q7D3xpdSzeasQonIbpI5nDrdy0FsZhRPEByfhTotgEfvG7XroQGPN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUa4Th73; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUa4Th73"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8BC9EC2BD04;
	Tue, 13 Oct 2026 02:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791858999;
	bh=d4fHYL1oawYv1SgxdIc+9V0K/wiZS/zzFNyXIpqp2no=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HUa4Th73TMMK5SoV0XqtMsYF7+p/7GwYXlY1NvYHYqDM9zjondVK4zDirYXzeCBAV
	 kBsPJJZFKz2/0lc2xWp/qEnJMWXpCG3/t2C/Oe5cWR7yY1tr/WZAAsHzfRqb6HjKUB
	 WafWCZ3o+RwTnv8c2alstxR5ZfNsViuResSRa0oLJAR5MsxkOjf9BjQ0azSbFPpKog
	 3QN4nxaFNlAJMAgaz50Vgq7cQ4yA2W256th+sSvFrW/mGQkGFocxeEEifF0niEmBIE
	 Qznqg3oYlii1R9/2dKTxneLFRWv66gXW9oTupCLIuzvJ3EIEvfCTP6NKl8uoq0uOnD
	 P8YcOlYgVopJw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7306DCA9EC5;
	Tue, 13 Oct 2026 02:36:39 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Mon, 12 Oct 2026 20:36:52 -0600
Subject: [PATCH v12 21/40] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-dd-cmap-part2-clean-v12-21-3c8cc5725def@gmail.com>
References: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
In-Reply-To: <20261012-dd-cmap-part2-clean-v12-0-3c8cc5725def@gmail.com>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791858995; l=5946;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=PB0GIt3ET4Ab4p9mTW7eHh3u21VWB8JI22spx3248sY=;
 b=LfLiu3R+euWJolobctTBWORtEazE7BBUuJb1/zvES2i5W5cjA1gEwu2/3MkDDWJaInHqvcRsP
 9II5yo3Yn21D6wok1Bw9JU96ZNu8/wuHptYxuJoNSWDipC66BDFXR34
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

From: Jim Cromie <jim.cromie@gmail.com>

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
v8: set maps.len = nc unconditionally
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
 lib/dynamic_debug.c | 79 +++++++++++++++++++++++++++++------------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1627e40efc8f..18289ca7170b 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1174,33 +1174,34 @@ static const struct proc_ops proc_fops = {
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
-	dt->info.maps.len = nc;
-	if (nc)
-		vpr_info("module:%s attached %d classes\n", dt->info.mod_name, nc);
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
+	__di->_vec.len = __nc;						\
+	if (__nc)							\
+		__di->_vec.start = __start;				\
+})
 
 /*
  * Allocate a new ddebug_table for the given module
@@ -1209,6 +1210,8 @@ static void ddebug_attach_module_classes(struct ddebug_table *dt, struct _ddebug
 static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
+	struct ddebug_class_map *cm;
+	int i;
 
 	if (!di->descs.len)
 		return 0;
@@ -1221,17 +1224,21 @@ static int ddebug_add_module(struct _ddebug_info *di)
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
2.56.0


