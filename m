Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8F359572D
	for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 22:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790202961; cv=none; b=TPkpbzkyjRLytrBF0cPgu9YQAsHvbcmwKpG+LCIZNKAalm4ja805VpKQxC8CeguXEILVD5IJ7gB4EHZdzyWNxLxpTtB8tdkBmtlPKkY7v/RhiuyFxZ9nMooZ1jyMhEadXJWf1z9GxZ4BDmojoPiNynwUPFZHfR+0rWa/V4JS6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790202961; c=relaxed/simple;
	bh=n9Z8JXtV+hbQarrwr/08uWnROErL8cUNEOMgEF+8lZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=etcEu6GnUsTROhSeLcRPUVjXy1rO3uPXMwco2PZJsllUR5GHYC3vrVxPXn8yZ4zbK1Vl0Ctf+MkPuV7CBgNuDKDdfSc3QUq4JyXhOp7AFhk1mUYKrbqe/HIf4nEetSBROqcNO+/MN7jPEOrmbhR6p0BbHqfM6c9jISN5QZ5fgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmRd67rO; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmRd67rO"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccdd76a9so1650078fac.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Sep 2026 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790202952; x=1790807752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fzyHdOl4LBhnGjv+agUTHwxe+Zo72I6YnHJM+htK4QI=;
        b=JmRd67rOENbbdTBN3Pb48S8lv3/2mlmhlj26bG5dpXgNPKtdrxypIFWvY/i7dAQY6J
         EwdjLB/ZRGIqnPoY5iUSixqi2fSFK6mqJCAisyXGvYFnTvPCB1t+egh0Usby54XNnCid
         1Mc4CSIZRU2jgMhrp6FahiJqkKfoha2ZcvovFoIM0IGOkoV0c/isIVbs54w/hh0Y82AU
         Hu4xaTmVSlv40rMhGrhM1e4PYKgGaVuP80jXLbhVuqe5s3OI8++BiyDL88+KFRQ/+S/U
         RiSoVyv4HWrW/keb/eW2zfZz1feS4q6wuwVUZo7yygWZLzyiFo5ICPb7KtIVuMXzRPhp
         6TSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790202952; x=1790807752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fzyHdOl4LBhnGjv+agUTHwxe+Zo72I6YnHJM+htK4QI=;
        b=GffZ1CyUMI5qkjd4i8lNqHea5SosrB2cGUHnnM71f9yPcuWJyov0g67tmiiKyZ3J43
         UPnUxneMcyERxNWuSJecV20a0Af5Q1mTW6N0ols+zBYTM6l1fHNfpElzshU31t+rTOkR
         aLB+ycvAM2b2r1C5VTODtQgHeedNWzuRxzsEuZZzVWqe0OxGtgxgvB7k72VnDl+05uO5
         3M4PUCYrv2sMEPe3FIeaux3cb6GM1Z8gAoGKEegZ2LzMBuGry8Iph1bOY1ia4YjqyQfe
         NH1gcFeGz2HOIbA7yUSuZYekw3YsmyaS7JI7w8Pfjl0/U0uwPZc2rsRHlweA7SLrLy42
         rrMQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnh777HND4c8BJV+Ol3X/UwISzB2iwfmQSeNsRpkDMJ6aWC8y1K+ZoFoUt4sL3w4zmvty+KNBnIw08@vger.kernel.org
X-Gm-Message-State: AFuF++n2ouEevLkmufLl/roCu2d/yK+/IWY21w0wuywNqegJHNbn3Blq
	LrIOSA/rLhScf9LIGXW2Jgjs7UOODmTAe2dkFqJE6WUpFwaisVsJDTxs
X-Gm-Gg: AYBFou1eJr3RiTUKwNdPMUt97v0Qs+I7ecd4OGvvqpR2O4cZWbmBaUEPbuIEMa5n4Up
	Il+3tF8yYPgVfByjR9y7l/VqwZRMaVZxGdc2b1Rx1q/uSPWvG+dVnFF6wKq6aVKIW5fnBo3LzpZ
	DM982XUopPb/k79RW12P8eHiApCfccwmtJt6tbud/8mMRkpI3+tewM87v7I84t2AV/Z2l5csGzj
	eZqnCdYWkxUMPulQbEmGRXKpRMo2VghBYmjlppGdyMg+Eq8gbzfZ0e85IIbyBRN5BiB/kBoCyPX
	ukOH3nUABgUtVT+xMBI4Bk4yC+f33GDkl2H9Jfj8nFjEQumFTFqXYgYuYvncjw9GaW6/LDgsUMA
	+0qH4dn/nQiDNlD1Z5kgrxWCFnhEi94FrUCAnJVD2zT1xDs/yyDg3rbXXZANIsHU29mxWTlTSti
	vpvResujqNv1AyoGMAXQgAB/g4oUHsXcbU6ObklW67J83iY0UKFgncfEDL4gwYtjZQM2YBLThDJ
	WHgKIgZFzYneTeHiTvgG3OJ39RGuWZBGxqOIdfyw4C2yAul5V6gZxM7WkUEncB9ix1hVAJnwKWP
	4NI99ZiNpJ/vDIz4q9k=
X-Received: by 2002:a05:6870:45a8:b0:47b:e948:4d6f with SMTP id 586e51a60fabf-491e58d0f81mr693435fac.17.1790202952075;
        Wed, 23 Sep 2026 15:35:52 -0700 (PDT)
Received: from [100.82.231.29] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-491ee1ac486sm559401fac.16.2026.09.23.15.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 15:35:51 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 23 Sep 2026 16:34:56 -0600
Subject: [PATCH v11 32/38] dyndbg: resolve "protection" of class'd pr_debug
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-dd-cmap-part2-clean-v11-32-9b6c217fdf2f@gmail.com>
References: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
In-Reply-To: <20260923-dd-cmap-part2-clean-v11-0-9b6c217fdf2f@gmail.com>
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
 Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-pm@vger.kernel.org, 
 Jim Cromie <jim.cromie@gmail.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790202874; l=14275;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=n9Z8JXtV+hbQarrwr/08uWnROErL8cUNEOMgEF+8lZ0=;
 b=TpQ2B1pyJPtaOfzG9s270Vj5Aol5cENNbiRWtD7RNMDK6Gz/3kgspmLS9ATcqKX7XSNm+99G1
 21Ult+otJXiCERU59pX9uGcTQqlq5Cz1e6P771yOKOGaHzuXitLOy4k
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

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
 include/linux/dynamic_debug.h |  16 ++++--
 lib/dynamic_debug.c           | 124 ++++++++++++++++++++++++++++++++++--------
 2 files changed, 111 insertions(+), 29 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 686060c13692..5b5f5bb31c48 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -89,6 +89,7 @@ enum ddebug_class_map_type {
  * map @class_names 0..N to consecutive constants starting at @base.
  */
 struct ddebug_class_map {
+	struct ddebug_class_param *controlling_param;
 	const struct module *mod;	/* NULL for builtins */
 	const char *mod_name;		/* needed for builtins */
 	const char **class_names;
@@ -138,7 +139,7 @@ struct ddebug_class_param {
 		u32 *lvl;
 	};
 	char flags[8];
-	const struct ddebug_class_map *map;
+	struct ddebug_class_map *map;
 };
 
 /*
@@ -296,7 +297,12 @@ struct ddebug_class_param {
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
@@ -309,10 +315,8 @@ struct ddebug_class_param {
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
index 636a88994a77..d300d44c1a82 100644
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
@@ -772,11 +833,14 @@ static int param_set_dyndbg_module_classes(const char *instr,
 					   const struct kernel_param *kp,
 					   const char *mod_name)
 {
-	const struct ddebug_class_param *dcp = kp->arg;
-	const struct ddebug_class_map *map = dcp->map;
+	struct ddebug_class_param *dcp = kp->arg;
+	struct ddebug_class_map *map = dcp->map;
 	u32 inrep, new_bits, old_bits, old_val;
 	int rc, totct = 0;
 
+	if (map && !map->controlling_param)
+		map->controlling_param = dcp;
+
 	rc = kstrtou32(instr, 0, &inrep);
 	if (rc) {
 		int len = strcspn(instr, "\n");
@@ -1171,7 +1235,6 @@ static bool ddebug_class_user_in_range(const int class_id, const struct ddebug_c
 		return false;
 	return ddebug_class_map_in_range(class_id - user->offset, user->map);
 }
-
 static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct ddebug_class_map *map;
@@ -1332,25 +1395,40 @@ static void ddebug_sync_classbits(const struct kernel_param *kp, const char *mod
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
+	return (map == dcp->map)
+		? dcp : (struct ddebug_class_param *)NULL;
+}
+
+static void ddebug_match_apply_kparam(const struct kernel_param *kp,
+				      struct ddebug_class_map *map,
+				      const char *mod_name)
+{
+	struct ddebug_class_param *dcp = ddebug_get_classmap_kparam(kp, map);
 
 	if (dcp && dcp->map == map) {
+		/*
+		 * Bind controlling_param to activate ABI protection in
+		 * ddebug_match_desc(), shielding callsites from non-class
+		 * wildcard (>control) queries.
+		 */
+		map->controlling_param = dcp;
 		v2pr_info(" kp:%s.%s =0x%x", mod_name, kp->name, *dcp->bits);
 		vpr_cm_info(map, " %s maps ", mod_name);
 		ddebug_sync_classbits(kp, mod_name);
 	}
 }
 
-static void ddebug_apply_params(const struct ddebug_class_map *cm, const char *mod_name)
+static void ddebug_apply_params(struct ddebug_class_map *cm, const char *mod_name)
 {
 	const struct kernel_param *kp;
 

-- 
2.55.0

