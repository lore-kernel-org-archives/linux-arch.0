Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6881450AC08;
	Sat,  5 Sep 2026 18:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788632022; cv=none; b=GRX00/nMYBpkuwpCkFhtP+9x4JYQ/0AxtGWRNYNJH+MqAZONZwVYgOXawkAzEQbk+NP47f8m4zCzJpcuF4KYxWb/OpAlOSDsPBLRep/P6Mry14DYD5fiKLr7b8tzDA2du5tp+Neeixacm7u8HZ5LktNGN1Us5/VkFxSxcL/wWeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788632022; c=relaxed/simple;
	bh=ykzvjv9g3urih5b1s0edaBxRBltCf9kMqYWmDJ7ZdP0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VviwYYaf2Jk8XXYZEgkXpwjf/nTPtXHrEAIr3chNsU/Wafusaa4LslevrhCZXVEtCnQ/WMXw2DPYtes5RLXUfcXvl2/1HKk5ypFREJxJlAFLTsiNGYiRD0p5mBpxgA7WRaugR3pc5a7g1nh5kDO9ohgOuFbU8fu2Ppcb40q6+Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEu4SFbQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEu4SFbQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3FFA0C4AF0F;
	Sat,  5 Sep 2026 18:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788632022;
	bh=ykzvjv9g3urih5b1s0edaBxRBltCf9kMqYWmDJ7ZdP0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CEu4SFbQWJ+DQMto97gnUUpIDFVB5hBThT8l5HBdedbMfU5JvflMvQI9O1xo5y4ry
	 /niWzj6tIqBy5sqC2VjQ+Ic6grkBoK1sxjEo11MYQoPbNVwQJfnnalQxMuvaBSS49A
	 8/ja9k1KztEwt2LAXIZ7E7iIvqf+zefrc2UP9EBFi2E+vD85S4p1mfCRLIHxXUq0Sc
	 H4pFJqv2U30v9Bqx/wpfxneHUxRQwZBP6VpqXbt/iVXBCikGO6oYeODc9xBpDM0YJD
	 So1+zrYxLRnXaHACDWmruBtYmSk43zMdyCFP7dQoi6sO4dbMRizc+A44uBzlK+GXCy
	 1z+JXycy+z04Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEB1C79F99;
	Sat,  5 Sep 2026 18:13:42 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Sat, 05 Sep 2026 12:13:52 -0600
Subject: [PATCH v8 38/43] docs/dyndbg: add classmap info to howto
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-dd-cmap-part2-clean-v8-38-a4cc0674f6fd@gmail.com>
References: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
In-Reply-To: <20260905-dd-cmap-part2-clean-v8-0-a4cc0674f6fd@gmail.com>
To: Jason Baron <jbaron@akamai.com>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788632017; l=7696;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=LhXY0aFJMyGQ0fI0VgTIjGM3Np2TCeK9PgZxUYZs3ks=;
 b=pX1XgwUOvVMMxjfQsBGqaEO/+fzHSpNwGOdhWzZ6A39sa8J11qUyYpnydrX7OMCgIHpKnUjOW
 85A7ofHAPOTDuCMGPbu6Ec2kpVNS4mJScKX0ryfeNMQ9I9Tpb3dJXl0
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com

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
v2: RvB after SoB
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 142 ++++++++++++++++++++--
 1 file changed, 132 insertions(+), 10 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 6b934fab695b..aa3a74deb68f 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -146,6 +146,9 @@ keywords are::
   "1-30" is valid range but "1 - 30" is not.
 
 
+Keywords
+--------
+
 The meanings of each keyword are:
 
 func
@@ -197,16 +200,6 @@ format
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
@@ -221,6 +214,25 @@ line
 	line -1605          // the 1605 lines from line 1 to line 1605
 	line 1600-          // all lines from line 1600 to the end of the file
 
+class
+
+    The given class_name is validated against each module, which may
+    have declared a list of class_names it accepts.  If the class_name
+    accepted by a module, callsite & class matching and adjustment
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
@@ -242,6 +254,11 @@ The flags are::
   l    Include line number
   d    Include call trace
 
+.. note::
+
+   * To query without changing	``+_`` or ``-_``.
+   * To clear all flags		``=_`` or ``-fslmpt``.
+
 For ``print_hex_dump_debug()`` and ``print_hex_dump_bytes()``, only
 the ``p`` flag has meaning, other flags are ignored.
 
@@ -398,3 +415,108 @@ just a shortcut for ``print_hex_dump(KERN_DEBUG)``.
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
+DYNAMIC_DEBUG_CLASSMAP_PARAM(clname) - creates the sysfs/kparam,
+maps/exposes bits 0..N as class-names.
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
2.55.0


