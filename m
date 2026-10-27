Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132549;
	b=q+4UbG22aAn5cpOhMC/GpLzKtFBfwD2aNmZPCdZK6hMmxIVRkpRfYP38h22AupuCGV4S
	 PNkQ7rcE97eIJlWXfIxcnMHCUYrif6MR3CH3rGjZCd2fMkWkTK+N1wIrepAy9TC7VdNmo
	 HHGVNSwAZsX/jWHJ+jz2TfBAsUyN6PYP5m0Fe0PSBJG6LKMfIiEku0EYm4BKE5b7lDuDS
	 qG1VjHgjq5YzpY5yuvuu0RpFgRkMH/ifoNcrI8BNswyMXugA0RSpnergUBu4OtjW60H+A
	 R9esRYt52FYKD2mH947D/enY2X/rKDvzUj0QONgE02G25ViJ1xh5Tg23sxA3ek5HgFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132549;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qmJaWAM7FyiJnR1RXpXVdlJYkcZ6k524c07t7WNMxYQ=;
	b=Ral9cd9/zKx2BIf6VJ55bxRlTYRsxKgi8yj+55qh49pVeagK9jq5L0xFzzUx5OlpzGDt
	 NS0hjkasG5rtfRqutBVj1FdFTsMBiShXIwC0xmO7WX6Mw3gMKzE104rBazWS41ueJbHu/
	 NBPVWSi4xqrlCtXH/914KcLgvAfonbjVk0LyLbT628tWDWXmyJXzN9fC3Ue4oB7QQBRhb
	 cZunb9m9GPxCBDchkX0Hl+DMqV8pgRVB+psJpdvr3V932vN48hbhw1wgCqP3C/M5ATKpl
	 Bm7djSP4K8pByG9R24NmEKR8uez7M8d93Hrsj6d0Qhxldqtql5jeKTLSPPy39CUVMyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrKX9Icx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997516073569;
	Tue, 27 Oct 2026 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HrKX9Icx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132549;
	b=ERll22cj45nSrDnO4uqQBXTsz8P30PNYrON8qku9QJ7RVqHAfj6myjwbR9BoyhwCclv7
	 NPhLyToLo3AY+SVvr/CI9uEHffOPt+lHeyyuOlISkbk/AUCt1m0Pnqcuv1sGB9W04TWiJ
	 Jr2iHnIjCLi50hiD72VCqXhp60rf7qXxYvjZzxZig1XU+jR+rJFlTZ1RX3MvWyf5/ipVa
	 4C0KKJQ6GQVaVcxBl45X6ASyIn2BM+r77xX9GQnMmzMcg88CfvRax/kEznfuMyLOwP4Pt
	 hFWNA8iZ/Bsl1+Ups3PgGorj7w4rtucF9GRioAGPB4gAjBgXcF07odxqqdm7C5iAw+A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132549;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qmJaWAM7FyiJnR1RXpXVdlJYkcZ6k524c07t7WNMxYQ=;
	b=kr0De2UFg+se6Dzo+T6/Le7hnjdk58tY0MqMlMdn8Eeuze38rroHGk6DrM5AhdK9lO76
	 fQJRPdFEmYEnmOOwVmjlaYHoiNl0JaIsf0g/mg+aKKLqs4sh/Pf3m7/guV1Z1dzG5uwye
	 4bkPk99RpRcNlnYFwn1C2xZEKXwAerH8rAopZZLjRi04AB9HQsWIXRZz16YlEMLLH4yMx
	 tDRdgJPE5OR0zBs3WbC6oVYB2JVPEA8YBmDPC28ZZOkj5Yw6b4VGa8cTwTzlD/vy8wyzW
	 iE+yNOD2KmS0ierTV+h2axx8RixC0Hn8IGdK+Id/vHbpGcRW82YoGhwXg26JeR5Clzg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2AD5B1F01340;
	Tue, 27 Oct 2026 20:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132549;
	bh=qmJaWAM7FyiJnR1RXpXVdlJYkcZ6k524c07t7WNMxYQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=HrKX9IcxPu6WMUQm08x4IEk0QVfX8KzvdYkLMSXC/JhJoxFWdH7zGMjYSYwsauOFT
	 sMkhapyZOKT7ImUmBbQ95PA2/ATYM8DzTm3/2N22g+sHvZR6i/fSgp357f5dGTVvRZ
	 osNhfoYc6TEkMeM/H5aZ17C8StL9GjoWJu/9e9IoiBZAecFnCwTyL4MB13n40fJ2rd
	 rLiVdorUZ/CtaMJ1ath3DTz3IvI3isW7ll1hP9i1WC6msxq7ndwGcNlRWbcYIG23U/
	 VSxWLTwF2aZlj9/UgFV7eRXuebDNPQI4711hBwac0tYUGo62dtyrZXDJxDw2KLYgis
	 mitH5lAei36Jg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id A2F1B45245;
	Tue, 27 Oct 2026 20:22:10 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:21 -0600
Subject: [PATCH v13 21/39] dyndbg: hoist classmap-filter-by-modname up to
 ddebug_add_module
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-21-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=5946;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=PB0GIt3ET4Ab4p9mTW7eHh3u21VWB8JI22spx3248sY=;
 b=SZ+F9Bd2p2eh30w8K74kkaIrAALD9DQxrIu6aixxVrugMVUKQy9r2m0i4X5n2O6Nq/WTCye/C
 GlgUcwRSJIZCxgItIjab73TbQGVcjB18er2Lg9+Yi9YWIDuvbW4fzvU
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

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


