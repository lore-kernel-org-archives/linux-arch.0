Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793132552;
	b=xUoq5LCQ92I7N+CXnRUeUYEFgYCNwdkGo/jmCECUrrpE2t1maIcN3ti3hwmurAIvtHBZ
	 96ISePMOQYbNQyjXvOFv7odOYhhZ1yh2Cs/goUODLWAergIvitp5/hIk91tySg0TmdptA
	 xTCl/CUCJdQXElSRaD2V1B+0gDaBlcmdr5AdA+MIF4zxNb4RZRzCuasDkNNbjXl8ZP5Qx
	 nHH/oK5knrfxBF79Maqv7i2VkdRK6TJkMmW4cxVn4qSxGEKF+fgbqQXiT86UDxsVEK8JL
	 jHhOAYpH7wA0ckqM/iU94YdglXPnInDnaxD2atpLWPHQDeq59T0/tM+x3JX3WfM5jsw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793132552;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xOA2FLpybncEB3Wpscc+UM/VIX7agN7kvacpy6QLGYg=;
	b=H0j2d3FGk9MPjGU0kxYYMsjHDRKFIH7Tp09e5Efds+ymgl1FiLEN4drsmMFR2sp7e2Cn
	 DIVIsrGhrmIsodN0y+1JhHSsbnThJZDDPXRRf5Pfb6YMvrXl3UUANthMorMFPx9VjCwW3
	 nlABtvhEDKnQJRks+bYYPyueJcZ5sNUPlHZ0UNLJlXn6RIJSgZTVYeILE7j6pTuZVVsp2
	 jrgEqIaIIfzKxmxtwriIAMTzqpkwcrA+I9QdSBAIwch2VQ4M+6zdKrfxfqN4zwiirgN02
	 ysn/7UPTVL3fo8FitrwXgu18PAATCLoSrBu1+IefVKZ3fC5fVQK/3OPN0DoBZRM8+1Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKNz299D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132B8606A921;
	Tue, 27 Oct 2026 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BKNz299D
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793132550;
	b=zC1m3gfXjS0fmT7pecTkp/zSybW61KDBxKtHRXJ4wWPnmgE61BsrecD05v8sPmED4iu7
	 yrArSDsN9dlLXV9mltmuOMw/4IZCYNFdO/ry22GvFyPlqgAfDuaQBs5uQV++sPT0lPpcb
	 WsNx3eIK+I4bul8WRbDQI4XxnYL6kL0S5KE1QndEH8QEh2A0n51kCiP3iubd/RAXub3qo
	 ixjbdvW+foZ+OVvy9R7LpuHR5jOqU7OvNkV5QlNHYlsqw0TzQDoI0GT5rhQYkue0uTAvi
	 iiCHqwSsdTGbn1KB73UsjShmCJ3bykpfNiyuP1X9fhfU5lb/4j2YARDOVcDC6tHRr3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793132550;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=xOA2FLpybncEB3Wpscc+UM/VIX7agN7kvacpy6QLGYg=;
	b=DnKxUOQP4ff5EwV7/3kHC/uzpxfwXVU2NffDcfoK1ppyYkZ2wYfzsuMogcrTuXxi88h7
	 QVFiGMkZaeap1mG/QEdgG/eq0SibTRlH/Qw8fPt65zBYbQ78xdb42DUFPfEcWfgAC6oxr
	 XElYztLfyWsqBhW2jgZJiPyKYKwRzFLrPMRpbkFeSlkgm8tat3PelyCNpEOzVe95wmZEl
	 BteA31i4ATiwH2HMwf1xhg+szEjpbRD2I+V4xz+ay7aYEeNyF5enaRkwWCI2IyjYICjwg
	 M+0AR+Fhqdmo4gZPKgv5s0lWI5pNltyCRC6RoGYJDfjbT/+qxQBU7GDlsqd3NJKmcXw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B67D31F0136F;
	Tue, 27 Oct 2026 20:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793132550;
	bh=xOA2FLpybncEB3Wpscc+UM/VIX7agN7kvacpy6QLGYg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BKNz299DZcWZ80xe5y8fXswVqMcpzm8lVf37KwSN215cLudOG+OGsVVRU0t+1X4Hs
	 NIX+rOZ5VjNPeuPKYq+PqCqqVt5Y4FZI3HXuNUPivr2Yxo5eBUOKCwFgEtPq9W9HuT
	 +uYPmIJ5BxBQCLdbU6XR2PiN6Vtsku2HsgsHHf9Q8dZ2nJQbMd1QpS8zBJSES7J5Ye
	 Qyfw9DlGEu0QLR3AL1a5g/yC6NDs1tmxVBlr8IuT1t8qB5j5lrpz6grEyDH64VeHC8
	 pnFaFq7hkTLPeQpmNwqDSqrWunGdobPT1d1Rd7u/Bf8jNMLKtrSifvXT9FXlEYRYmG
	 ooPH439z2G24A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2331A4526C;
	Tue, 27 Oct 2026 20:22:11 +0000 (UTC)
From: Jim Cromie via B4 Relay <devnull+jim.cromie.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 14:22:31 -0600
Subject: [PATCH v13 31/39] dyndbg: resolve "protection" of class'd pr_debug
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
Message-Id: <20261027-dd-cmap-part2-clean-v13-31-9267923be612@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793132527; l=18192;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=nuIShYVzTod1kx5S/IOTa5rdNatJuoxexuPAzPIiwbQ=;
 b=chI1l01o4x5E0EjeKc6dTNlc0MtZ32V1O6DcXbf0taNwhwTpvfgB3ymRAkKb43YBY8TGKF2/F
 wcNXpvzrYm2AZzJxWpfIWqieDSOUwEMNeufP47fzxHDsjPTmu0+HCzK
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=
X-Endpoint-Received: by B4 Relay for jim.cromie@gmail.com/20260203 with
 auth_id=958
X-Original-From: Jim Cromie <jim.cromie@gmail.com>
Reply-To: jim.cromie@gmail.com
Content-Transfer-Encoding: 7bit

From: Jim Cromie <jim.cromie@gmail.com>

classmap-v1 code protected class'd pr_debugs from unintended
changes by unclassed/_DFLT queries:

  # - to declutter examples:
  alias ddcmd='echo $* > /proc/dynamic_debug/control'

  # IOW, this should NOT alter drm.debug settings
  ddcmd -p

  # Instead, you must name the class to change it.
  # Protective but tedious
  ddcmd class DRM_UT_CORE +p

  # Or do it the (old school) subsystem way
  # This is ABI !!
  echo 1 > /sys/module/drm/parameters/debug

Since the debug sysfs-node is ABI, if dyndbg is going to implement it,
it must also honor its settings; it must at least protect against
accidental changes to its classes from legacy queries.

The protection allows all previously conceived queries to work the way
they always have; ie select the same set of pr_debugs, despite the
inclusion of whole new classes of pr_debugs.

But that choice has 2 downsides:

1. "name the class to change it" makes a tedious long-winded
interface, needing many commands to set DRM_UT_* one at a time.

2. It makes the class keyword special in some sense; the other
keywords skip only on query mismatch, otherwise the code falls thru to
adjust the pr-debug site.

 Jason Baron	didn't like v1 on point 2.
 Louis Chauvet	didn't like recent rev on point 1 tedium.

But that said: /sys/ is ABI, so this must be reliable:

  #> echo 0x1f > /sys/module/drm/parameters/debug

It 'just works' without dyndbg underneath; we must deliver that same
stability.  Convenience is secondary.

The new resolution:

If ABI is the blocking issue, then no ABI means no blocking issue.
IOW, if the classmap has no presence under /sys/*, ie no PARAM, there
is no ABI to guard, and no reason to enforce a tedious interface.

In the future, if DRM wants to alter this protection, that is
practical, but I think default-on is the correct mode.

So atm classes without a PARAM are unprotected at >control, allowing
admins their shortcuts.  I think this could satisfy all viewpoints.

That said, theres also a possibility of wildcard classes:

   #> ddcmd class '*' +p

Currently, the query-class is exact-matched against each module's
classmaps.names.  This gives precise behavior, a good basis.

But class wildcards are possible, they just did'nt appear useful for
DRM, whose classmap names are a flat DRM_UT_* namespace.

IOW, theres no useful selectivity there:

   #> ddcmd class "DRM_*" +p		# these enable every DRM_* class
   #> ddcmd class "DRM_UT_*" +p

   #> ddcmd class "DRM_UT_V*" +p	# finally select just 1: DRM_UT_VBL
   #> ddcmd class "DRM_UT_D*" +p	# but this gets 3

   #> ddcmd class "D*V*" +p		# here be dragons

But there is debatable utility in the feature.

   #> ddcmd class __DEFAULT__ -p	# what about this ?
   #> ddcmd -p				# thats what this does. automatically

Anyway, this patch does:

1. adds link field from _ddebug_class_map to the .controlling_param

2. sets it in ddebug_match_apply_kparam(), during modprobe/init,
   when options like drm.debug=VAL are handled.

3. ddebug_class_has_param() now checks .controlling_param

4. ddebug_class_wants_protection() macro renames 3.
   this frames it as a separable policy decision

5. ddebug_match_desc() gets the most attention:

a. move classmap consideration to the bottom
   this insures all other constraints act 1st.
   allows simpler 'final' decisions.

b. split class choices cleanly on query:
   class FOO vs none, and class'd vs _DPRINTK_CLASS_DFLT site.

c. calls 4 when applying a class-less query to a class'd pr_debug
   here we need a new fn to find the classmap with this .class_id

d. calls new ddebug_find_classmap_by_class_id().
   when class-less query looks at a class'd pr_debug.
   finds classmap, which can then decide, currently by PARAM existence.

NOTES:

protection is only against class-less queries, explicit "class FOO"
adjustments are allowed (that is the mechanism).

The drm.debug sysfs-node heavily under-specifies the class'd pr_debugs
it controls; none of the +mfls prefixing flags have any effect, and
each callsite remains individually controllable. drm.debug just
toggles the +p flag for all the modules' class'd pr_debugs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v11:
. bind controlling_param and enforce ABI protection for native
  classmaps in ddebug_match_apply_kparam() and early in
  param_set_dyndbg_module_classes(). Note that ddebug_apply_class_maps()
  itself was hoisted to Patch 23 for lifecycle symmetry between definers
  and users.
. drop const from struct ddebug_class_param.map and ddebug_class_map *cm
  in ddebug_apply_params() to allow controlling_param binding.

v10:
. drop dead #if 0 ddebug_apply_class_maps() block.

v9:
. assign map->controlling_param = dcp in ddebug_match_apply_kparam()
  to enforce protection on parameterized classmaps.
v2: RvB after SoB

old-v12

minor fixup after squashing subsequent commits to previous ones
---
 include/linux/dynamic_debug.h                      |  16 +-
 lib/dynamic_debug.c                                | 171 ++++++++++++++++-----
 .../selftests/dynamic_debug/dyndbg_selftest.sh     |  20 +--
 3 files changed, 156 insertions(+), 51 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 83ea42f25e06..cf245aefb16b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -82,6 +82,7 @@ enum ddebug_class_map_type {
  * map @class_names 0..N to consecutive constants starting at @base.
  */
 struct ddebug_class_map {
+	struct ddebug_class_param *controlling_param;
 	const struct module *mod;	/* NULL for builtins */
 	const char *mod_name;		/* needed for builtins */
 	const char **class_names;
@@ -131,7 +132,7 @@ struct ddebug_class_param {
 		u32 *lvl;
 	};
 	char flags[8];
-	const struct ddebug_class_map *map;
+	struct ddebug_class_map *map;
 };
 
 /*
@@ -289,7 +290,12 @@ struct ddebug_class_param {
  *
  * Creates a sysfs-param to control the classes defined by the
  * exported classmap, with bits 0..N-1 mapped to the classes named.
- * This version keeps class-state in a private long int.
+ *
+ * Since sysfs-params are ABI, this also protects the classmap'd
+ * pr_debugs from un-class'd `echo -p > /proc/dynamic_debug/control`
+ * changes.
+ *
+ * This keeps class-state in a private long int.
  */
 #define DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _var, _flags)		\
 	static u32 _name##_bvec = _DPRINTK_CLASSBITS_INIT;		\
@@ -302,10 +308,8 @@ struct ddebug_class_param {
  * @_var:   name of the (exported) classmap var defining the classes/bits
  * @_flags: flags to be toggled, typically just 'p'
  *
- * Creates a sysfs-param to control the classes defined by the
- * exported clasmap, with bits 0..N-1 mapped to the classes named.
- * This version keeps class-state in user @_bits.  This lets drm check
- * __drm_debug elsewhere too.
+ * Like DYNAMIC_DEBUG_CLASSMAP_PARAM, but maintains param-state in
+ * extern @_bits.  This lets DRM check __drm_debug elsewhere too.
  */
 #define DYNAMIC_DEBUG_CLASSMAP_PARAM_REF(_name, _bits, _var, _flags)	\
 	__DYNAMIC_DEBUG_CLASSMAP_PARAM(_name, _bits, _var, _flags)
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 11f7350f3590..82edec19c67e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -71,6 +71,10 @@ struct flag_settings {
 	unsigned int mask;
 };
 
+static bool ddebug_class_map_in_range(const int class_id,
+				      const struct ddebug_class_map *map);
+static bool ddebug_class_user_in_range(const int class_id,
+				       const struct ddebug_class_user *user);
 static DEFINE_MUTEX(ddebug_lock);
 static LIST_HEAD(ddebug_tables);
 static int verbose;
@@ -200,14 +204,52 @@ static struct ddebug_class_map *ddebug_find_valid_class(struct _ddebug_info cons
 	return NULL;
 }
 
-#define __outvar /* filled by callee */
+
+
+static struct ddebug_class_map *
+ddebug_find_map_by_class_id(struct _ddebug_info *di, int class_id)
+{
+	struct ddebug_class_map *map;
+	struct ddebug_class_user *cli;
+	int i;
+
+	for_subvec(i, map, di, maps)
+		if (ddebug_class_map_in_range(class_id, map))
+			return map;
+
+	for_subvec(i, cli, di, users)
+		if (ddebug_class_user_in_range(class_id, cli))
+			return cli->map;
+
+	return NULL;
+}
+
+/*
+ * classmaps-V1 protected classes from changes by legacy commands
+ * (those selecting _DPRINTK_CLASS_DFLT by omission).  This had the
+ * downside that saying "class FOO" for every change can get tedious.
+ *
+ * V2 is smarter, it protects class-maps if the defining module also
+ * calls DYNAMIC_DEBUG_CLASSMAP_PARAM to create a sysfs parameter.
+ * Since the author wants the knob, we should assume they intend to
+ * use it (in preference to "class FOO +p" >control), and want to
+ * trust its settings.  This gives protection when its useful, and not
+ * when its just tedious.
+ */
+static inline bool ddebug_class_has_param(const struct ddebug_class_map *map)
+{
+	return !!(map->controlling_param);
+}
+
+/* re-framed as a policy choice */
+#define ddebug_class_wants_protection(map) (ddebug_class_has_param(map))
+
 static bool ddebug_match_desc(const struct ddebug_query *query,
 			      struct _ddebug *dp,
-			      int valid_class)
+			      struct _ddebug_info *di,
+			      int selected_class)
 {
-	/* match site against query-class */
-	if (dp->class_id != valid_class)
-		return false;
+	struct ddebug_class_map *site_map;
 
 	if (!dp->format) {
 		pr_err_ratelimited("ddebug: NULL format string at %s:%s:%u\n",
@@ -252,7 +294,28 @@ static bool ddebug_match_desc(const struct ddebug_query *query,
 	    dp->lineno > query->last_lineno)
 		return false;
 
-	return true;
+	/*
+	 * above are all satisfied, so we can make final decisions:
+	 * 1- class FOO or implied class __DEFAULT__
+	 * 2- site.is_classed or not
+	 */
+	if (query->class_string) {
+		/* class FOO given, exact match required */
+		return (dp->class_id == selected_class);
+	}
+	/* query class __DEFAULT__ by omission. */
+	if (dp->class_id == _DPRINTK_CLASS_DFLT) {
+		/* un-classed site */
+		return true;
+	}
+	/* site is class'd */
+	site_map = ddebug_find_map_by_class_id(di, dp->class_id);
+	if (!site_map) {
+		WARN_ONCE(1, "unknown class_id %d, check %s's CLASSMAP definitions", dp->class_id, di->mod_name);
+		return false;
+	}
+	/* module(-param) decides protection */
+	return !ddebug_class_wants_protection(site_map);
 }
 
 /*
@@ -268,33 +331,31 @@ static int ddebug_change(const struct ddebug_query *query, struct flag_settings
 	unsigned int newflags;
 	unsigned int nfound = 0;
 	struct flagsbuf fbuf, nbuf;
-	struct ddebug_class_map *map = NULL;
-	int valid_class;
+	int selected_class;
 
 	/* search for matching ddebugs */
 	mutex_lock(&ddebug_lock);
 	list_for_each_entry(dt, &ddebug_tables, link) {
 		struct _ddebug_info *di = &dt->info;
+		struct ddebug_class_map *mods_map;
 
 		/* match against the module name */
 		if (query->module &&
 		    !match_wildcard(query->module, di->mod_name))
 			continue;
 
+		selected_class = _DPRINTK_CLASS_DFLT;
 		if (query->class_string) {
-			map = ddebug_find_valid_class(&dt->info, query->class_string,
-						      &valid_class);
-			if (!map)
+			mods_map = ddebug_find_valid_class(di, query->class_string,
+							   &selected_class);
+			if (!mods_map)
 				continue;
-		} else {
-			/* constrain query, do not touch class'd callsites */
-			valid_class = _DPRINTK_CLASS_DFLT;
 		}
 
 		for (i = 0; i < di->descs.len; i++) {
 			struct _ddebug *dp = &di->descs.start[i];
 
-			if (!ddebug_match_desc(query, dp, valid_class))
+			if (!ddebug_match_desc(query, dp, di, selected_class))
 				continue;
 
 			nfound++;
@@ -772,8 +833,8 @@ static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
 					   const char *mod_name)
 {
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
+	struct ddebug_class_param *dcp = kp->arg;
+	struct ddebug_class_map *map = dcp->map;
 	u32 inrep, new_bits, old_bits, old_val;
 	int rc, totct = 0;
 
@@ -1174,7 +1235,6 @@ static bool ddebug_class_user_in_range(const int class_id, const struct ddebug_c
 		return false;
 	return ddebug_class_map_in_range(class_id - user->offset, user->map);
 }
-
 static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct ddebug_class_map *map;
@@ -1335,44 +1395,80 @@ static void ddebug_sync_classbits(const struct kernel_param *kp, const char *mod
 	}
 }
 
-static void ddebug_match_apply_kparam(const struct kernel_param *kp,
-				      const struct ddebug_class_map *map,
-				      const char *mod_name)
+static struct ddebug_class_param *
+ddebug_get_classmap_kparam(const struct kernel_param *kp,
+			   const struct ddebug_class_map *map)
 {
 	struct ddebug_class_param *dcp;
 
 	if (kp->ops != &param_ops_dyndbg_classes)
-		return;
+		return NULL;
 
 	dcp = (struct ddebug_class_param *)kp->arg;
-
-	if (dcp && dcp->map == map) {
-		v2pr_info(" kp:%s.%s =0x%x", mod_name, kp->name, *dcp->bits);
-		vpr_cm_info(map, " %s maps ", mod_name);
-		ddebug_sync_classbits(kp, mod_name);
-	}
+	return (map == dcp->map)
+		? dcp : (struct ddebug_class_param *)NULL;
 }
 
-static void ddebug_apply_params(const struct ddebug_class_map *cm, const char *mod_name)
+static const struct kernel_param *ddebug_find_class_kparam(const struct ddebug_class_map *cm)
 {
 	const struct kernel_param *kp;
 
 	if (!cm)
-		return;
+		return NULL;
 #if IS_ENABLED(CONFIG_MODULES)
 	int i;
 
 	if (cm->mod) {
-		vpr_cm_info(cm, "loaded classmap: %s ", mod_name);
-		/* ifdef protects the cm->mod->kp deref */
 		for (i = 0, kp = cm->mod->kp; i < cm->mod->num_kp; i++, kp++)
-			ddebug_match_apply_kparam(kp, cm, mod_name);
+			if (ddebug_get_classmap_kparam(kp, cm))
+				return kp;
 	}
 #endif
 	if (!cm->mod) {
-		vpr_cm_info(cm, "builtin classmap: %s ", mod_name);
 		for (kp = __start___param; kp < __stop___param; kp++)
-			ddebug_match_apply_kparam(kp, cm, mod_name);
+			if (ddebug_get_classmap_kparam(kp, cm))
+				return kp;
+	}
+	return NULL;
+}
+
+static void ddebug_bind_param(struct ddebug_class_map *cm)
+{
+	const struct kernel_param *kp;
+
+	if (!cm || cm->controlling_param)
+		return;
+
+	kp = ddebug_find_class_kparam(cm);
+	if (kp)
+		cm->controlling_param = kp->arg;
+}
+
+static void ddebug_bind_class_params(const struct _ddebug_info *di)
+{
+	struct ddebug_class_map *cm;
+	struct ddebug_class_user *cli;
+	int i;
+
+	for_subvec(i, cm, di, maps)
+		ddebug_bind_param(cm);
+
+	for_subvec(i, cli, di, users)
+		ddebug_bind_param(cli->map);
+}
+
+static void ddebug_apply_params(struct ddebug_class_map *cm, const char *mod_name)
+{
+	const struct kernel_param *kp;
+
+	if (!cm || !cm->controlling_param)
+		return;
+
+	kp = ddebug_find_class_kparam(cm);
+	if (kp) {
+		v2pr_info(" kp:%s.%s =0x%x", mod_name, kp->name, *cm->controlling_param->bits);
+		vpr_cm_info(cm, " %s maps ", mod_name);
+		ddebug_sync_classbits(kp, mod_name);
 	}
 }
 
@@ -1493,7 +1589,12 @@ static int ddebug_add_module(struct _ddebug_info *di)
 			goto cleanup;
 
 	/*
+	 * Bind controlling_param before publishing dt to ddebug_tables so
+	 * that class protection is active against concurrent wildcard queries
+	 * the instant the table becomes visible.
 	 */
+	ddebug_bind_class_params(&dt->info);
+
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 1811a9982f6a..b976fef40ef1 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -600,23 +600,23 @@ function GOLDEN_RECORDS {
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.16
 #K= d682c98ced7d31f1555ab474a9ebe253 FT_modprobe_w_param.17
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.18
-#K= 362ab2e7e5f5e3ede8b69645c64fb987 FT_modprobe_w_param.19
-#K= 362ab2e7e5f5e3ede8b69645c64fb987 FT_modprobe_w_param.20
-#K= 4f539816f9cc9fb9dd4a032138e3abde FT_modprobe_w_param.21
+#K= c468e49e8ce1f1aa25a3c6684f221fe5 FT_modprobe_w_param.19
+#K= c468e49e8ce1f1aa25a3c6684f221fe5 FT_modprobe_w_param.20
+#K= ef2408a036206c895d95061521f67906 FT_modprobe_w_param.21
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.22
-#K= 20659d16ffb5b18475e83602223216d1 FT_modprobe_w_param.23
+#K= 92c0174d5de412de82e3d5837b0690d0 FT_modprobe_w_param.23
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.24
-#K= 0b24971fb1018c38353141f8fcb9cbdc FT_modprobe_w_param.25
+#K= a563a79aeffbf3d8cf2e37ab93898ae9 FT_modprobe_w_param.25
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.26
-#K= 66eb387a95512f679eb5cad4168b0992 FT_modprobe_w_param.27
+#K= 8d2f4db3b7885064a56594e1d81deb26 FT_modprobe_w_param.27
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.28
-#K= 7df05523f4d61917fd7659357eeec1bc FT_modprobe_w_param.29
+#K= 05e8884875609af295ec71a7acf33c60 FT_modprobe_w_param.29
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.30
-#K= a75600ac4e129f4315c5a50ad3a3103c FT_modprobe_w_param.31
+#K= c70f769b4c9cc905d23d6b3e5ac432c8 FT_modprobe_w_param.31
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.32
-#K= f43ccce73ac2b0e1529312af66a4ddfe FT_modprobe_w_param.33
+#K= 72bf5368385d19e7843cf268d1bac7f9 FT_modprobe_w_param.33
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.34
-#K= 4819f715ba485c493afb455542f7ab8c FT_modprobe_w_param.35
+#K= 28ace93a95da7aaea5b9b54a8656a2cf FT_modprobe_w_param.35
 #K= 0239d8c0808eef396782362613f675b0 FT_modprobe_w_param.36
 EO_DYNDBG_GOLDEN_REFS
         # Read the K-recs and skip those for tests that can't run

-- 
2.56.0


