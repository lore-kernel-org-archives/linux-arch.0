Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132550;
	b=i5usN0tOqE6WxPicokVBDFZMfMiNDfsiBJ1gL1SADnx630xBIY/cmRiAAJAM5oH2hd11
	 qSbXzfODI2aDmw5TMHxS2wdWVjeDFK9lyLhU20JOIB+0Ivx53YDPiP4d8qxmxvg8gFUy4
	 VQ7WE300Hmdicbxux2CnXlYZaI72ahXmJ0850nx35NmFLWdH5fv9nGH+FnwqDzTIUsiYh
	 y2kesXlXAnlzuEkSAdsGZoy47ZkyE4ie2cO7gHMJYeeO9TmHfEk01O4GbvYvPGmz+IW2O
	 MR/NZ4eBkrZkbzp9m1OaHts+SX7WhoQ56MShWe90w6wVOr+SgcPKSpc4DkocStk7XBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132550;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fhrAJWz9wvLikxRl3xE8uvjcgEt8tCIB++keNTtMXfY=;
	b=eYj7IdamxrK3GXGnU1WjO6OF8v6HfYffRQ0CevCZ0cQskaIsulQzGDlyE5LUjR7fFtsP
	 vU1hpHwGGBz/D6yWQb4vgWjIjZkfj99wNosUE25sTxhuE9/20G/7Q6zEVwvFqrT1IHyM+
	 IkJBAp131F772t8BPY2+qdHFUlJHU2GFlYk6mf/ECnxcwFoq80AXeAFmsspiJ6MaUMOpq
	 LGg4sxJwg21IRMl0r9eSl2fxxY4WTD0Im31FNHlFkAyh+i+jmF3C+mEGmw0YZDXEP3NPd
	 SF/Gc9PSbgcFafHexOPrjp8mgEultO/1Et/3SCLeXyk4Pzj8qSdoTZk3wz29tcClU2A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zw6fom2p;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1FD606A906;
	Tue, 27 Oct 2026 20:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zw6fom2p
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132550;
	b=K8TlYkPdZJ1nQh8/wJdLQgyYV6Uv1iYteRlBcfMqWdoKY1JpQq3wd6rYjuF/JXA7rNFb
	 AhHvkqgsCmo476XfuimqMTT0a2g4B6PpgmJHCbX7gmnDvGGcH21ATXDaVkwAneoMMvba4
	 WdM+zDg6i5sC2FDeVzmS4NSIjGAdGwnzYmU5PxOYfP9px6f8JJPYzMpT1A3i0AAqMFhyZ
	 2pq1l5mLeL5rOuugOX3w/BB3DTotdf56PrLBot5uHHlCqZJz6GobGRFp4cZxxwVhpO3l+
	 KqqmcdmR+pORjPHqanGNFrjRr83XAPYVMpO18rnS/qCXKQXk/JSYT8sa/ynHH919qaw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132550;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fhrAJWz9wvLikxRl3xE8uvjcgEt8tCIB++keNTtMXfY=;
	b=rXajZJZj44+M7XrHnn8WmVQM1ygM07hLIvbBSIhyNMhYgpCfzix0Ph5LMADdkyqiuHID
	 eHVhjlficNy/qKnVIl/EPKHFVG8cj0HIbdUsGH+KQdpJiBCyHc+P1fpj3usbeQmh5BKMy
	 SJMvw03oKKfORINDgjcH3V2GbQ1N9K6yXtAsOv2DLji2I19Q8Lx39jyUryC8xxk8CqNTf
	 PdFJoug1tE1rDkCbNqZDzQJ8ZKNf+alQB4EqjuRNDcR1KT5+ldPpfyrHvQEykyfCNQjSg
	 InJ/uub1xzuu3JXbj4fZevw7CHGj7jzrESflw6L3RlmVCGt+gquSCMu4mJqAMiiZJ6g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C21901F0135E;
	Tue, 27 Oct 2026 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132550;
	bh=fhrAJWz9wvLikxRl3xE8uvjcgEt8tCIB++keNTtMXfY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Zw6fom2pQneC0WynKgowcGD3dUcJdqXe2Pz6VCifkKkxAnYgl39tQmWymKRJNwKub
	 03KUYCIPvaRpOMNpm9s6cX3pEfPnkloT9cHH/x9SnPTq8TPlkp35eNMvNWrzzy1Gkk
	 f0KtMKLx9faIz5gFxLY+226zk0OK3VfXMJM8cc1nk+M2huvOqTHXjGXljlfz9SonF9
	 kqt/b6PO9r0nl9hecb4iEC+VdfWP841N3u6A09eXvucZLzsWA0gN2p1nUyBQR5Tvcv
	 kjFkRaV5yAA0v2pu8tF2DtCmYWaJ6nhCJ1hbbdyekrGbgslbG/+qqcaZkAoF5AUqqK
	 ygeJUSeCr6XIg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2DEC345270;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:32 -0600
Subject: [PATCH v13 32/39] docs/dyndbg: add classmap info to howto
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-32-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=8037;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=9qDhMIWXQpssv+DMRwP+IaaePLgf9ITKVLs4Vn1ATPI=;
 b=ROym0gm1WgnsrE4TX6i0H0xcX9qaP8ELlvp27c9oWKm6fPICcRZ4nSw7yeQBKNA31xhNGK8Cz
 9cw6j2SIkNmDWS9TqchyheC2kPAlA2oHtpqpoAjDq53OwrAh9Haqws1
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

Describe the 3 API macros providing dynamic_debug's classmaps

DYNAMIC_DEBUG_CLASSMAP_DEFINE - create & export a classmap
DYNAMIC_DEBUG_CLASSMAP_USE    - refer to exported map
DYNAMIC_DEBUG_CLASSMAP_PARAM  - bind control param to the classmap
DYNAMIC_DEBUG_CLASSMAP_PARAM_REF + use module's storage - __drm_debug

NB: The _DEFINE & _USE model makes the user dependent on the definer,
just like EXPORT_SYMBOL(__drm_debug) already does.

cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v13:
. document full 3-arg signature for DYNAMIC_DEBUG_CLASSMAP_PARAM in
  howto (noted by Sashiko).

v9:
. fix typo in class keyword documentation.
. document DYNAMIC_DEBUG_CLASSMAP_PARAM_REF.
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 145 ++++++++++++++++++++--
 1 file changed, 135 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index a8962ab22aaf..30dc315766a5 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -146,6 +146,9 @@ keywords are::
   "1-30" is valid range but "1 - 30" is not.
 
 
+Keywords
+--------
+
 The meanings of each keyword are:
 
 func
@@ -193,16 +196,6 @@ format
 	format "nfsd: SETATTR"  // a neater way to match a format with whitespace
 	format 'nfsd: SETATTR'  // yet another way to match a format with whitespace
 
-class
-    The given class_name is validated against each module, which may
-    have declared a list of known class_names.  If the class_name is
-    found for a module, callsite & class matching and adjustment
-    proceeds.  Examples::
-
-	class DRM_UT_KMS	# a DRM.debug category
-	class JUNK		# silent non-match
-	// class TLD_*		# NOTICE: no wildcard in class names
-
 line
     The given line number or range of line numbers is compared
     against the line number of each ``pr_debug()`` callsite.  A single
@@ -217,6 +210,25 @@ line
 	line -1605          // the 1605 lines from line 1 to line 1605
 	line 1600-          // all lines from line 1600 to the end of the file
 
+class
+
+    The given class_name is validated against each module, which may
+    have declared a list of class_names it accepts.  If the class_name
+    is accepted by a module, callsite & class matching and adjustment
+    proceeds.  Examples::
+
+	class DRM_UT_KMS	# a drm.debug category
+	class JUNK		# silent non-match
+	// class TLD_*		# NOTICE: no wildcard in class names
+
+.. note::
+
+    Unlike other keywords, classes are "name-to-change", not
+    "omitting-constraint-allows-change".  See Dynamic Debug Classmaps
+
+Flags
+-----
+
 The flags specification comprises a change operation followed
 by one or more flag characters.  The change operation is one
 of the characters::
@@ -238,6 +250,11 @@ The flags are::
   l    Include line number
   d    Include call trace
 
+.. note::
+
+   * To query without changing	``+_`` or ``-_``.
+   * To clear all flags		``=_`` or ``-fslmpt``.
+
 For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 the ``p`` flag has meaning, other flags are ignored.
 
@@ -394,3 +411,111 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
 For ``print_hex_dump_debug()``/``print_hex_dump_bytes()``, format string is
 its ``prefix_str`` argument, if it is constant string; or ``hexdump``
 in case ``prefix_str`` is built dynamically.
+
+.. _dyndbg-classmaps:
+
+Dynamic Debug Classmaps
+=======================
+
+The "class" keyword selects prdbgs based on author supplied,
+domain-oriented names.  This complements the nested-scope keywords:
+module, file, function, line.
+
+The main difference from the others: classes must be named to be
+changed.  This protects them from unintended overwrite::
+
+  # IOW this cannot undo any drm.debug settings
+  :#> ddcmd -p
+
+This protection is needed; /sys/module/drm/parameters/debug is ABI.
+drm.debug is authoritative when dyndbg is not used, dyndbg-under-DRM
+is an implementation detail, and must not behave erratically, just
+because another admin fed >control something unrelated.
+
+So each class must be enabled individually (no wildcards)::
+
+  :#> ddcmd class DRM_UT_CORE +p
+  :#> ddcmd class DRM_UT_KMS +p
+  # or more selectively
+  :#> ddcmd class DRM_UT_CORE module drm +p
+
+That makes direct >control wordy and annoying, but it is a secondary
+interface; it is not intended to replace the ABI, just slide in
+underneath and reimplement the guaranteed behavior.  So DRM would keep
+using the convenient way, and be able to trust it::
+
+  :#> echo 0x1ff > /sys/module/drm/parameters/debug
+
+That said, since the sysfs/kparam is the ABI, if the author omits the
+CLASSMAP_PARAM, theres no ABI to guard, and he probably wants a less
+pedantic >control interface.  In this case, protection is dropped.
+
+Dynamic Debug Classmap API
+==========================
+
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(clname,type,_base,classnames) - this maps
+classnames (a list of strings) onto class-ids consecutively, starting
+at _base.
+
+DYNAMIC_DEBUG_CLASSMAP_USE(clname) & _USE_(clname,_base) - modules
+call this to refer to the var _DEFINEd elsewhere (and exported).
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM(clname, var, flags) - creates the
+sysfs/kparam, maps/exposes bits 0..N as class-names.
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(name,bits,var,flags) - connects an
+existing module parameter variable (e.g. __drm_debug) to a classmap.
+
+Classmaps are opt-in: modules invoke _DEFINE or _USE to authorize
+dyndbg to update those named classes.  "class FOO" queries are
+validated against the classes defined or used by the module, this
+finds the classid to alter; classes are not directly selectable by
+their classid.
+
+Classnames are global in scope, so subsystems (module-groups) should
+prepend a subsystem name; unqualified names like "CORE" are discouraged.
+
+NB: It is an inherent API limitation (due to class_id's int type) that
+the following are possible:
+
+  // these errors should be caught in review
+  __pr_debug_cls(0, "fake DRM_UT_CORE msg");  // this works
+  __pr_debug_cls(62, "un-known classid msg"); // this compiles, does nothing
+
+There are 2 types of classmaps:
+
+* DD_CLASS_TYPE_DISJOINT_BITS: classes are independent, like drm.debug
+* DD_CLASS_TYPE_LEVEL_NUM: classes are relative, ordered (V3 > V2)
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM - modelled after module_param_cb, it
+refers to a DEFINEd classmap, and associates it to the param's
+data-store.  This state is then applied to DEFINEr and USEr modules
+when they're modprobed.
+
+The PARAM interface also enforces the DD_CLASS_TYPE_LEVEL_NUM relation
+amongst the contained classnames; all classes are independent in the
+control parser itself.  There is no implied meaning in names like "V4"
+or "PL_ERROR" vs "PL_WARNING".
+
+Modules or subsystems (drm & drivers) can define multiple classmaps,
+as long as they (all the classmaps) share the limited 0..62
+per-module-group _class_id range, without overlap.
+
+If a module encounters a conflict between 2 classmaps it is _USEing or
+_DEFINEing, it can invoke the extended _USE_(name,_base) macro to
+de-conflict the respective ranges.
+
+``#define DEBUG`` will enable all pr_debugs in scope, including any
+class'd ones.  This won't be reflected in the PARAM readback value,
+but the class'd pr_debug callsites can be forced off by toggling the
+classmap-kparam all-on then all-off.
+
+Self-Testing and Validation
+===========================
+
+Dynamic debug includes a regression test script in kselftest::
+
+  :#> make -C tools/testing/selftests TARGETS=dynamic_debug run_tests
+  # Or run directly on a running kernel:
+  :#> ./tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+

-- 
2.56.0


