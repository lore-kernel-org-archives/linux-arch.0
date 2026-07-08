Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AA83BF69D
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477157; cv=none; b=LaxjVGnbw8hvRwsrTEsJVB9Y4fMlGgh5cS/y5+peRc295X5zmhjcnqadw9uDFzamDwqJaocF27WNoZwYXK+NkPGa4U7+oLvcl4lU6RDtostJO569PBXzbkSRdlkXwM/bmVKOg/3jmAEq3QCgF6gUDE50ylSGUFlP0T/cUv2fK/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477157; c=relaxed/simple;
	bh=2q2n+8ejQdo/4mvd1oTonN8wExA8g2sCJuEedKzaOhM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IOVEixKfenSQ3wrSW83CCYSBmIqXMygF+f2J51458I2rFyBn6wo776VrZh3u5kWJ84v3OHAuXynwntcRfGrJpXGar05hwBGacOli89eN+lmejU58gMKgfKbrIXsEJMGwAlXa3B4Hap+0w6/+fnaaWkhx/VvD2EVwKlHRt0uI9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1Vt8muV; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Vt8muV"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-48751bd4abeso95599b6e.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477150; x=1784081950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qx9rFBhr2bJ63BnQroXKIA/F4FgP3Oq8Y63AhKs47UQ=;
        b=d1Vt8muVbChGu0pL2FdNEhdVoU7ehjY8R7ZKswLbvC7TJg+Hd/9l4FT/nMbj0lhqeQ
         8mhsLTn2oTqbz4n3Zm9/1s4wbccfu0Qmoc2wdGc14Zdcln3qe7WMtJGHttqXcRb/dhDS
         BO95+uuaNciYWOdJ7CyGSzpy+EjE72BTfvOUr+AbYJux9nQuZJnRhMs8rcNMc6sxqauI
         uRt1fZECohh7XO0kobD/DX+fPOxQ9DYLJGjsMP4hWTsCEyOrTPdUMirKAk1Tc/eKdDQR
         l1Hvy+qwBwD++uu2OZQDjSAPd8xx66WRFxLdzg1NPyZ39J+OF47/GWZY0sMrdIJD8fRL
         OkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477150; x=1784081950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qx9rFBhr2bJ63BnQroXKIA/F4FgP3Oq8Y63AhKs47UQ=;
        b=tKEqapa+gC/vTOjfMkC3gL1Rr7kjAV1H3FSaDvuVeOHigE8SQMr3BWERUst3JXtUoa
         EPXOoZzOnMPVel6iVvbRXvObn5quZRQp1yMDL4WZYZ8HlwFCiHa4LyGbkL1Tqxi2XLyT
         HDAb05ed9RVZkjjNWpC2pxfV0oi2YfRk4DOY65vsz5x7TGijkpmE4MhoGqyk+CXCfkP8
         qt0Nk+1UdOMN0XsgdeKA+h9b4i6nO0jPEshWhmf4WoC1gHvERgkPo076vkvDL+Xciw9z
         LSAMmRlOVttnILok7co+mHihaP3fEf0ZAMytU1fU0aUgYcAGCoUZ5kWycVZQHFvFSZaO
         6dyA==
X-Forwarded-Encrypted: i=1; AFNElJ+GsMl+UVjalkGg30Hgqu4eDuVtYHM4gy9wKLqCehl34rxFS9O1MjuzalAZpN7RfAzHLhAKNacRCAI/@vger.kernel.org
X-Gm-Message-State: AOJu0YxGY8cjcKZw41ZSpHeqCqOJR4dZOK0hYJAbQgfCGGUeC/nlZCuS
	BrD02+201HAOXvnQaNzsSwRIsFmoG7opP0BhgfAb8QIjXEid2d0FAlGj
X-Gm-Gg: AfdE7clpi7Pj0NBn2pQYNcXAJwcEbL7vWgDKOT+k3nVSp7VvEapdo923ybSaYtgsuVv
	pCAuXUlzdFwUwB5K7q/H7juj/4290Ei4K0UPv5T9y9P0G+x2HgvmASPUJpyRcWDllTgGMYptLnB
	kKKp8HC+2sfovAWC02vY4J+wXWrS/D0vUJYn86GjJYUvxf5/4wtskSllsnYK3aqgKD9dkJAkTMG
	pV94x2RlzNsm6jYskQ1v7zs4XFTZeDex7BImc8OyKWFAuEHpRw4CGX5Uc3DVm9wrQcTVQOjni48
	3ARwTyx27S3M2mdrYEhAb6E4NU0K8wgQ9IEwucXcIN7D/gDMc9YTJP/wn+MxL9uuvzXSfncBj8F
	DJp5USmOcPBH7MmyLmxtcD5FYPujFpqK8wlo65ozr0adP1eLePNOhjvu8vUw+Od23T6ouegjtt/
	ZatSgmtvSMBssW6hFM5/d3G4UI/7JMEaXcrNJA0UTBk6QteNXrA2w=
X-Received: by 2002:a05:6808:1924:b0:489:f088:5f70 with SMTP id 5614622812f47-4a202b68574mr374782b6e.12.1783477150039;
        Tue, 07 Jul 2026 19:19:10 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:19:09 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:24 -0600
Subject: [PATCH v6 24/24] dyndbg-API: replace DECLARE_DYNDBG_CLASSMAP
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-24-381f3edb0045@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=38489;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=2q2n+8ejQdo/4mvd1oTonN8wExA8g2sCJuEedKzaOhM=;
 b=kdsLhhIx9uNZhBtuD05ZQ7CehagZkVyZkWb6WHTLVO6FLdHIwFUKrWkuWuQxJtsRgdEPdNDk6
 yCTo5DrRewpAU6qIti6ucBDWKS6d7/zTGSaYSgUoNyQoELjoR2WKpIf
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

commit aad0214f3026 ("dyndbg: add DECLARE_DYNDBG_CLASSMAP macro")

DECLARE_DYNDBG_CLASSMAP() has a design error; its usage fails a
basic K&R rule: "define once, refer many times".

When CONFIG_DRM_USE_DYNAMIC_DEBUG=y, it is used across DRM core &
drivers; each invocation allocates/inits the classmap understood by
that module.  They *all* must match for the DRM modules to respond
consistently when drm.debug categories are enabled.  This is at least
a maintenance hassle.

Worse, its the root cause of the CONFIG_DRM_USE_DYNAMIC_DEBUG=Y
regression; its use in both core & drivers obfuscates the 2 roles,
muddling the design, yielding an incomplete initialization when
modprobing drivers:

1st drm.ko loads, and dyndbg initializes its drm.debug callsites, then
a drm-driver loads, but too late for the drm.debug enablement.

And that led to:
commit bb2ff6c27bc9 ("drm: Disable dynamic debug as broken")

So retire it, replace with 2 macros:
  DYNAMIC_DEBUG_CLASSMAP_DEFINE - invoked once from core - drm.ko
  DYNAMIC_DEBUG_CLASSMAP_USE*   - from all drm drivers and helpers.
  NB: name-space de-noise

DYNAMIC_DEBUG_CLASSMAP_DEFINE: this reworks DECLARE_DYNDBG_CLASSMAP,
basically by dropping the static qualifier on the classmap, and
exporting it instead.

DYNAMIC_DEBUG_CLASSMAP_USE: then refers to the exported var by name:
  used from drivers, helper-mods
  lets us drop the repetitive "classname" declarations
  fixes 2nd-defn problem
  creates a ddebug_class_user record in new __dyndbg_class_users section
  new section is scanned similarly

DECLARE_DYNDBG_CLASSMAP is preserved temporarily, to decouple DRM
adaptation work and avoid compile errs before its done.

The DEFINE,USE distinction, and the separate classmap-use record,
allows dyndbg to initialize the driver's & helper's drm.debug
callsites separately after each is modprobed.  Basically, the classmap
initial scan is repeated for classmap-users.

Data Structure and Header Changes:
  - Introduce 'struct ddebug_class_user':
    Contains the user-module-name and a pointer to the classmap definition.
    It records a drm-driver's use of a classmap in a new section,
    allowing runtime lookup.
  - Update 'struct ddebug_info' with two new fields:
    'class_users' and 'num_class_users'. These are initialized by
    dynamic_debug_init() for built-ins, and by load_info() in
    kernel/module/main.c for loadable modules.
  - Update 'vmlinux.lds.h':
    Add a new BOUNDED_SECTION for '__dyndbg_class_users' to define
    __start and __stop C symbols for the section.
  - Rename the '__dyndbg_classes' section to '__dyndbg_class_maps'.

Execution Engine Changes:
  - ddebug_add_module():
    Refactor and split ddebug_attach_module_classes() into
    debug_apply_class_maps() and ddebug_apply_class_users(), both of
    which call ddebug_apply_params().
  - ddebug_apply_params():
    Scans a module's or built-in's kernel-parameters, calling
    ddebug_match_apply_kparam() for each to locate parameters wired
    to a classmap.
  - ddebug_match_apply_kparam():
    Verifies that the kernel-parameter ops belong to dyndbg, ensuring
    the target parameter is valid.

Fixes: aad0214f3026 ("dyndbg: add DECLARE_DYNDBG_CLASSMAP macro")
cc: linux-doc@vger.kernel.org
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
---
v5:

old, overwrought commit-msg:

dyndbg's existing __dyndbg_classes[] section does:

. catalogs the module's classmaps
. tells dyndbg about them, allowing >control
. DYNAMIC_DEBUG_CLASSMAP_DEFINE creates section records.
. we rename it to: __dyndbg_class_maps[]

this patch adds __dyndbg_class_users[] section:

. catalogs users of classmap definitions from elsewhere
. authorizes dyndbg to >control user's class'd prdbgs
. DYNAMIC_DEBUG_CLASSMAP_USE() creates section records.

Now ddebug_add_module(etal) can handle classmap-uses similar to (and
after) classmaps; when a dependent module is loaded, if it has
classmap-uses (to a classmap-def in another module), that module's
kernel params are scanned to find if it has a kparam that is wired to
dyndbg's param-ops, and whose classmap is the one being ref'd.

To support this, there are a few data/header changes:

new struct ddebug_class_user
  contains: user-module-name, &classmap-defn
  it records drm-driver's use of a classmap in the section, allowing lookup

struct ddebug_info gets 2 new fields for the new sections:
  class_users, num_class_users.
  set by dynamic_debug_init() for builtins.
  or by kernel/module/main:load_info() for loadable modules.

vmlinux.lds.h: Add a new BOUNDED_SECTION for __dyndbg_class_users.
this creates start,stop C symbol-names for the section.

Callchain Details:

dynamic_debug.c: 2 changes from ddebug_add_module() & ddebug_change():

ddebug_add_module():

ddebug_attach_module_classes() is reworked/renamed/split into
debug_apply_class_maps(), ddebug_apply_class_users(), which both call
ddebug_apply_params().

ddebug_apply_params(new fn):

It scans module's/builtin kernel-params, calls ddebug_match_apply_kparam
for each to find any params/sysfs-nodes which may be wired to a classmap.

ddebug_match_apply_kparam(new fn):

1st, it tests the kernel-param.ops is dyndbg's; this guarantees that
the attached arg is a struct ddebug_class_param, which has a ref to
the param's state, and to the classmap defining the param's handling.

2nd, it requires that the classmap ref'd by the kparam is the one
we've been called for; modules can use many separate classmaps (as
test_dynamic_debug does).

Then apply the "parent" kparam's setting to the dependent module,
using ddebug_apply_class_bitmap().

ddebug_change(and callees) also gets adjustments:

ddebug_find_valid_class(): This does a search over the module's
classmaps, looking for the class FOO echo'd to >control.  So now it
searches over __dyndbg_class_users[] after __dyndbg_classes[].

ddebug_class_name(): return class-names for defined OR used classes.

test_dynamic_debug.c, test_dynamic_debug_submod.c:

This demonstrates the 2 types of classmaps & sysfs-params, following
the 4-part recipe:

0. define an enum for the classmap's class_ids
   drm.debug gives us DRM_UT_<*> (aka <T>)
   multiple classmaps in a module(s) must share 0-62 classid space.

1. DYNAMIC_DEBUG_CLASSMAP_DEFINE(classmap_name, .. "<T>")
   names the classes, maps them to consecutive class-ids.
   convention here is stringified ENUM_SYMBOLS
   these become API/ABI if 2 is done.

2. DYNAMIC_DEBUG_CLASSMAP_PARAM* (classmap_name)
   adds a controlling kparam to the class

3. DYNAMIC_DEBUG_CLASSMAP_USE(classmap_name)
   for subsystem/group/drivers to use extern created by 1.

Move all the enum declarations together, to better explain how they
share the 0..62 class-id space available to a module (non-overlapping
subranges).

reorg macros 2,3 by name.  This gives a tabular format, making it easy
to see the pattern of repetition, and the points of change.

And extend the test to replicate the 2-module (parent & dependent)
scenario which caused the CONFIG_DRM_USE_DYNAMIC_DEBUG=y regression
seen in drm & drivers.

The _submod.c is a 2-line file: #define _SUBMOD, #include parent.

This gives identical complements of prdbgs in parent & _submod, and
thus identical print behavior when all of: >control, >params, and
parent->_submod propagation are working correctly.

It also puts all the parent/_submod declarations together in the same
source; the new ifdef _SUBMOD block invokes DYNAMIC_DEBUG_CLASSMAP_USE
for the 2 test-interfaces.  I think this is clearer.

These 2 modules are both tristate, allowing 3 super/sub combos: Y/Y,
Y/M, M/M (not N/Y, since this is disallowed by dependence).

Y/Y, Y/M testing once exposed a missing __align(8) in the _METADATA
macro, which M/M didn't see, probably because the module-loader memory
placement constrained it from misalignment.

---
v2: RvB after SoB

old-v?
replace di with &dt->info, since di becomes stale
fix dd_mark_vector_subrange macro param ordering to match kdoc
s/base/offset/ in _ddebug_class_user, to reduce later churn

-v12 - squash in _USE_ and refinements.

A: dyndbg: add DYNAMIC_DEBUG_CLASSMAP_USE_(dd_class_name, offset)

Allow a module to use 2 classmaps together that would otherwise have a
class_id range conflict.

Suppose a drm-driver does:

  DYNAMIC_DEBUG_CLASSMAP_USE(drm_debug_classes);
  DYNAMIC_DEBUG_CLASSMAP_USE(drm_accel_xfer_debug);

If (for some reason) drm-accel cannot define their constants to avoid
DRM's drm_debug_category 0..10 reservations, we would have a conflict
with reserved-ids.

In this case a driver needing to use both would _USE_ one of them with
an offset to avoid the conflict.  This will handle most forseeable
cases; perhaps a 3-X-3 of classmap-defns X classmap-users would get
too awkward and fiddly.

B: dyndbg: refine DYNAMIC_DEBUG_CLASSMAP_USE_ macro

The struct _ddebug_class_user _varname construct is needlessly
permissive; it has a static qualifier, and a unique name.  Together,
these allow a module to have 2 or more _USE(foo)s, which is contrary
to its purpose, and therefore potentially confusing.

So drop the unique name, and the static qualifier, and replace it with
an extern pre-declaration.  Construct the name by pasting together the
_var (which is the name of the exported ddebug_class_map), and
__KBUILD_MODNAME (which is the user module name).  This allows only a
single USE() reference to the exported record, which is all that is
required.
---
 include/asm-generic/dyndbg.lds.h |   6 +-
 include/linux/dynamic_debug.h    | 165 +++++++++++++++++++++++++++++++++++----
 kernel/module/main.c             |   3 +
 lib/Kconfig.debug                |  24 ++++--
 lib/Makefile                     |   3 +
 lib/dynamic_debug.c              | 140 ++++++++++++++++++++++++++++++---
 lib/test_dynamic_debug.c         | 119 ++++++++++++++++++++++------
 lib/test_dynamic_debug_submod.c  |  14 ++++
 8 files changed, 415 insertions(+), 59 deletions(-)

diff --git a/include/asm-generic/dyndbg.lds.h b/include/asm-generic/dyndbg.lds.h
index ec661f9f3793..0ffc9cde4377 100644
--- a/include/asm-generic/dyndbg.lds.h
+++ b/include/asm-generic/dyndbg.lds.h
@@ -5,7 +5,8 @@
 #include <asm-generic/bounded_sections.lds.h>
 #define DYNDBG_SECTIONS()						\
 	BOUNDED_SECTION_BY(__dyndbg_descs, ___dyndbg_descs)		\
-	BOUNDED_SECTION_BY(__dyndbg_class_maps, ___dyndbg_class_maps)
+	BOUNDED_SECTION_BY(__dyndbg_class_maps, ___dyndbg_class_maps)	\
+	BOUNDED_SECTION_BY(__dyndbg_class_users, ___dyndbg_class_users)
 
 #define MOD_DYNDBG_SECTIONS()						\
 	__dyndbg_descs 0 : ALIGN(8) {					\
@@ -13,6 +14,9 @@
 	}								\
 	__dyndbg_class_maps 0 : ALIGN(8) {				\
 		KEEP(*(__dyndbg_class_maps))				\
+	}								\
+	__dyndbg_class_users 0 : ALIGN(8) {				\
+		KEEP(*(__dyndbg_class_users))				\
 	}
 
 #endif /* __ASM_GENERIC_DYNDBG_LDS_H */
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 8822f9a3605f..48a8e6145d51 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -86,19 +86,30 @@ enum ddebug_class_map_type {
 	 */
 };
 
+/*
+ * map @class_names 0..N to consecutive constants starting at @base.
+ */
 struct ddebug_class_map {
-	struct module *mod;	/* NULL for builtins */
-	const char *mod_name;	/* needed for builtins */
+	const struct module *mod;	/* NULL for builtins */
+	const char *mod_name;		/* needed for builtins */
 	const char **class_names;
 	const int length;
 	const int base;		/* index of 1st .class_id, allows split/shared space */
 	enum ddebug_class_map_type map_type;
-};
+} __aligned(8);
+
+struct ddebug_class_user {
+	char *mod_name;
+	struct ddebug_class_map *map;
+	const int offset;	/* offset from map->base */
+} __aligned(8);
 
 /*
- * @_ddebug_info: gathers module/builtin dyndbg_* __sections together.
+ * @_ddebug_info: gathers module/builtin __dyndbg_<T> __sections
+ * together, each is a vec_<T>: a struct { struct T start[], int len }.
+ *
  * For builtins, it is used as a cursor, with the inner structs
- * marking sub-vectors of the builtin __sections in DATA.
+ * marking sub-vectors of the builtin __sections in DATA_DATA
  */
 struct _ddebug_descs {
 	struct _ddebug *start;
@@ -110,10 +121,16 @@ struct _ddebug_class_maps {
 	unsigned int len;
 };
 
+struct _ddebug_class_users {
+	struct ddebug_class_user *start;
+	int len;
+};
+
 struct _ddebug_info {
 	const char *mod_name;
 	struct _ddebug_descs descs;
 	struct _ddebug_class_maps maps;
+	struct _ddebug_class_users users;
 };
 
 struct ddebug_class_param {
@@ -132,25 +149,132 @@ struct ddebug_class_param {
 #if defined(CONFIG_DYNAMIC_DEBUG) || \
 	(defined(CONFIG_DYNAMIC_DEBUG_CORE) && defined(DYNAMIC_DEBUG_MODULE))
 
+/*
+ * dyndbg classmaps is modelled closely upon drm.debug:
+ *
+ *  1. run-time control via sysfs node (api/abi)
+ *  2. each bit 0..N controls a single "category"
+ *  3. a pr_debug can have only 1 category, not several.
+ *  4. "kind" is a compile-time constant: 0..N or BIT() thereof
+ *  5. macro impls - give compile-time resolution or fail.
+ *
+ * dyndbg classmaps design axioms/constraints:
+ *
+ *  . optimizing compilers use 1-5 above, so preserve them.
+ *  . classmaps.class_id *is* the category.
+ *  . classmap definers/users are modules.
+ *  . every user wants 0..N
+ *  . 0..N exposes as ABI
+ *  . no 1 use-case wants N > 32, 16 is more usable
+ *  . N <= 64 in *all* cases
+ *  . modules/subsystems make category/classmap decisions
+ *  . ie an enum: DRM has DRM_UT_CORE..DRM_UT_DRMRES
+ *  . some categories are exposed to user: ABI
+ *  . making modules change their numbering is bogus, avoid if possible
+ *
+ * We can solve for all these at once:
+ *  A: map class-names to a .class_id range at compile-time
+ *  B: allow only "class NAME" changes to class'd callsites at run-time
+ *  C: users/modules must manage 0..62 hardcoded .class_id range limit.
+ *  D: existing pr_debugs get CLASS_DFLT=63
+ *
+ * By mapping class-names at >control to class-ids underneath, and
+ * responding only to class-names DEFINEd or USEd by the module, we
+ * can private-ize the class-id, and adjust class'd pr_debugs only by
+ * their names.
+ *
+ * This give us:
+ *  E: class_ids without classnames are unreachable
+ *  F: user modules opt-in by DEFINEing a classmap and/or USEing another
+ *
+ * Multi-classmap modules/groups are supported, if the classmaps share
+ * the class_id space [0..62] without overlap/conflict.
+ *
+ * NOTE: Due to the integer class_id, this api cannot disallow these:
+ * __pr_debug_cls(0, "fake CORE msg");  works only if a classmap maps 0.
+ * __pr_debug_cls(22, "no such class"); compiles but is not reachable
+ */
+
 /**
- * DECLARE_DYNDBG_CLASSMAP - declare classnames known by a module
- * @_var:   a struct ddebug_class_map, passed to module_param_cb
- * @_maptype: enum ddebug_class_map_type, chooses bits/verbose
- * @_base:  offset of 1st class-name. splits .class_id space
- * @classes: class-names used to control class'd prdbgs
+ * DYNAMIC_DEBUG_CLASSMAP_DEFINE - define debug classes used by a module.
+ * @_var:   name of the classmap, exported for other modules coordinated use.
+ * @_mapty: enum ddebug_class_map_type: 0:DISJOINT - independent, 1:LEVEL - v2>v1
+ * @_base:  reserve N classids starting at _base, to split 0..62 classid space
+ * @classes: names of the N classes.
+ *
+ * This tells dyndbg what class_ids the module is using: _base..+N, by
+ * mapping names onto them.  This qualifies "class NAME" >controls on
+ * the defining module, ignoring unknown names.
+ */
+#define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)		\
+	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
+	extern struct ddebug_class_map _var;				\
+	struct ddebug_class_map __aligned(8) __used			\
+		__section("__dyndbg_class_maps") _var = {		\
+		.mod = THIS_MODULE,					\
+		.mod_name = DDEBUG_MODNAME,				\
+		.base = (_base),					\
+		.map_type = (_mapty),					\
+		.length = ARRAY_SIZE(_var##_classnames),		\
+		.class_names = _var##_classnames,			\
+	};								\
+	EXPORT_SYMBOL(_var)
+
+/*
+ * XXX: keep this until DRM adapts to use the DEFINE/USE api, it
+ * differs from DYNAMIC_DEBUG_CLASSMAP_DEFINE by the lack of the
+ * extern/EXPORT on the struct init, and cascading thinkos.
  */
 #define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
 	static struct ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_class_maps") _var = {			\
+		__section("__dyndbg_class_maps") _var = {		\
 		.mod = THIS_MODULE,					\
 		.mod_name = DDEBUG_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
-		.length = (sizeof(_var##_classnames) / sizeof(_var##_classnames[0])), \
+		.length = __DDEBUG_ARRAY_SIZE(_var##_classnames),	\
 		.class_names = _var##_classnames,			\
 	}
 
+/**
+ * DYNAMIC_DEBUG_CLASSMAP_USE - refer to a classmap, DEFINEd elsewhere.
+ * @_var: name of the exported classmap var
+ *
+ * This tells dyndbg that the module has prdbgs with classids defined
+ * in the named classmap.  This qualifies "class NAME" >controls on
+ * the user module, and ignores unknown names. This is a wrapper for
+ * DYNAMIC_DEBUG_CLASSMAP_USE_() with a base offset of 0.
+ */
+#define DYNAMIC_DEBUG_CLASSMAP_USE(_var) \
+	DYNAMIC_DEBUG_CLASSMAP_USE_(_var, 0)
+
+/**
+ * DYNAMIC_DEBUG_CLASSMAP_USE_ - refer to a classmap with a manual offset.
+ * @_var:   name of the exported classmap var to use.
+ * @_offset:  an integer offset to add to the class IDs of the used map.
+ *
+ * This is an extended version of DYNAMIC_DEBUG_CLASSMAP_USE(). It should
+ * only be used to resolve class ID conflicts when a module uses multiple
+ * classmaps that have overlapping ID ranges.
+ *
+ * The final class IDs for the used map will be calculated as:
+ * original_map_base + class_index + @_offset.
+ */
+#define DYNAMIC_DEBUG_CLASSMAP_USE_(_var, _offset)			\
+	extern struct ddebug_class_map _var;				\
+	static_assert((_offset) >= 0 && (_offset) < _DPRINTK_CLASS_DFLT, \
+		      "classmap use offset must be in 0..62");          \
+	extern struct ddebug_class_user __aligned(8)			\
+		__PASTE(_var ## _, __KBUILD_MODNAME);			\
+	struct ddebug_class_user __aligned(8) __used			\
+		__section("__dyndbg_class_users")			\
+		__PASTE(_var ## _, __KBUILD_MODNAME) = {		\
+		.mod_name = DDEBUG_MODNAME,				\
+		.map = &(_var),						\
+		.offset = _offset					\
+	}
+
 extern __printf(2, 3)
 void __dynamic_pr_debug(struct _ddebug *descriptor, const char *fmt, ...);
 
@@ -314,12 +438,18 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 				   KERN_DEBUG, prefix_str, prefix_type,	\
 				   rowsize, groupsize, buf, len, ascii)
 
-/* for test only, generally expect drm.debug style macro wrappers */
-#define __pr_debug_cls(cls, fmt, ...) do {			\
+/*
+ * This is the "model" class variant of pr_debug.  It is not really
+ * intended for direct use; I'd encourage DRM-style drm_dbg_<T>
+ * macros for the interface, along with an enum for the <T>
+ *
+ * __printf(2, 3) would apply.
+ */
+#define __pr_debug_cls(cls, fmt, ...) ({			\
 	BUILD_BUG_ON_MSG(!__builtin_constant_p(cls),		\
 			 "expecting constant class int/enum");	\
 	dynamic_pr_debug_cls(cls, fmt, ##__VA_ARGS__);		\
-	} while (0)
+})
 
 #else /* !(CONFIG_DYNAMIC_DEBUG || (CONFIG_DYNAMIC_DEBUG_CORE && DYNAMIC_DEBUG_MODULE)) */
 
@@ -327,6 +457,8 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #include <linux/errno.h>
 #include <linux/printk.h>
 
+#define DYNAMIC_DEBUG_CLASSMAP_DEFINE(_var, _mapty, _base, ...)
+#define DYNAMIC_DEBUG_CLASSMAP_USE(_var)
 #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
 #define DYNAMIC_DEBUG_BRANCH(descriptor) false
 #define DECLARE_DYNDBG_CLASSMAP(...)
@@ -375,8 +507,7 @@ static inline int param_set_dyndbg_classes(const char *instr, const struct kerne
 static inline int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 { return 0; }
 
-#endif
-
+#endif /* !CONFIG_DYNAMIC_DEBUG_CORE */
 
 extern const struct kernel_param_ops param_ops_dyndbg_classes;
 
diff --git a/kernel/module/main.c b/kernel/module/main.c
index bd7899a91755..6414608b5c3c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2780,6 +2780,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 	mod->dyndbg_info.maps.start = section_objs(info, "__dyndbg_class_maps",
 						   sizeof(*mod->dyndbg_info.maps.start),
 						   &mod->dyndbg_info.maps.len);
+	mod->dyndbg_info.users.start = section_objs(info, "__dyndbg_class_users",
+						   sizeof(*mod->dyndbg_info.users.start),
+						   &mod->dyndbg_info.users.len);
 #endif
 
 	return 0;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1244dcac2294..1bcce12cd875 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3152,12 +3152,26 @@ config TEST_STATIC_KEYS
 	  If unsure, say N.
 
 config TEST_DYNAMIC_DEBUG
-	tristate "Test DYNAMIC_DEBUG"
-	depends on DYNAMIC_DEBUG
+	tristate "Build test-dynamic-debug module"
+	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
 	help
-	  This module registers a tracer callback to count enabled
-	  pr_debugs in a 'do_debugging' function, then alters their
-	  enablements, calls the function, and compares counts.
+	  This module exercises/demonstrates dyndbg's classmap API, by
+	  creating 2 classes: a DISJOINT classmap (supporting DRM.debug)
+	  and a LEVELS/VERBOSE classmap (like verbose2 > verbose1).
+
+	  If unsure, say N.
+
+config TEST_DYNAMIC_DEBUG_SUBMOD
+	tristate "Build test-dynamic-debug submodule"
+	default m
+	depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
+	depends on TEST_DYNAMIC_DEBUG
+	help
+	  This sub-module uses a classmap defined and exported by the
+	  parent module, recapitulating drm & driver's shared use of
+	  drm.debug to control enabled debug-categories.
+	  It is tristate, independent of parent, to allow testing all
+	  proper combinations of parent=y/m submod=y/m.
 
 	  If unsure, say N.
 
diff --git a/lib/Makefile b/lib/Makefile
index 7f75cc6edf94..75d4c5e596e9 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_TEST_RHASHTABLE) += test_rhashtable.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
 obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
+obj-$(CONFIG_TEST_DYNAMIC_DEBUG_SUBMOD) += test_dynamic_debug_submod.o
 
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
 ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_KASAN),yy)
@@ -206,6 +207,8 @@ obj-$(CONFIG_ARCH_NEED_CMPXCHG_1_EMU) += cmpxchg-emu.o
 obj-$(CONFIG_DYNAMIC_DEBUG_CORE) += dynamic_debug.o
 #ensure exported functions have prototypes
 CFLAGS_dynamic_debug.o := -DDYNAMIC_DEBUG_MODULE
+CFLAGS_test_dynamic_debug.o := -DDYNAMIC_DEBUG_MODULE
+CFLAGS_test_dynamic_debug_submod.o := -DDYNAMIC_DEBUG_MODULE
 
 obj-$(CONFIG_SYMBOLIC_ERRNAME) += errname.o
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 1d5b9f68791a..358e603a3173 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -29,6 +29,7 @@
 #include <linux/string_helpers.h>
 #include <linux/uaccess.h>
 #include <linux/dynamic_debug.h>
+
 #include <linux/debugfs.h>
 #include <linux/slab.h>
 #include <linux/jump_label.h>
@@ -43,6 +44,8 @@ extern struct _ddebug __start___dyndbg_descs[];
 extern struct _ddebug __stop___dyndbg_descs[];
 extern struct ddebug_class_map __start___dyndbg_class_maps[];
 extern struct ddebug_class_map __stop___dyndbg_class_maps[];
+extern struct ddebug_class_user __start___dyndbg_class_users[];
+extern struct ddebug_class_user __stop___dyndbg_class_users[];
 
 struct ddebug_table {
 	struct list_head link;
@@ -160,20 +163,39 @@ static void v3pr_info_dq(const struct ddebug_query *query, const char *msg)
 	     (_i) < (_box)->_vec.len;			\
 	     (_i)++, (_sp)++)		/* { block } */
 
-static struct ddebug_class_map *ddebug_find_valid_class(struct ddebug_table const *dt,
-							 const char *class_string,
+#define v2pr_di_info(di_p, msg_p, ...)					\
+({									\
+	struct _ddebug_info const *_di = di_p;				\
+	v2pr_info(msg_p "module:%s nd:%d nc:%d nu:%d\n", ##__VA_ARGS__, \
+		  _di->mod_name, _di->descs.len, _di->maps.len,         \
+		  _di->users.len);                                      \
+})
+
+static struct ddebug_class_map *ddebug_find_valid_class(struct _ddebug_info const *di,
+							 const char *query_class,
 							 int *class_id)
 {
 	struct ddebug_class_map *map;
+	struct ddebug_class_user *cli;
 	int i, idx;
 
-	for_subvec(i, map, &dt->info, maps) {
-		idx = match_string(map->class_names, map->length, class_string);
+	for_subvec(i, map, di, maps) {
+		idx = match_string(map->class_names, map->length, query_class);
 		if (idx >= 0) {
+			v2pr_di_info(di, "good-class: %s.%s ", map->mod_name, query_class);
 			*class_id = idx + map->base;
 			return map;
 		}
 	}
+	for_subvec(i, cli, di, users) {
+		idx = match_string(cli->map->class_names, cli->map->length, query_class);
+		if (idx >= 0) {
+			v2pr_di_info(di, "class-ref: %s -> %s.%s ",
+				    cli->mod_name, cli->map->mod_name, query_class);
+			*class_id = idx + cli->map->base - cli->offset;
+			return cli->map;
+		}
+	}
 	*class_id = -ENOENT;
 	return NULL;
 }
@@ -234,8 +256,7 @@ static bool ddebug_match_desc(const struct ddebug_query *query,
 	return true;
 }
 
-static int ddebug_change(const struct ddebug_query *query,
-			 struct flag_settings *modifiers)
+static int ddebug_change(const struct ddebug_query *query, struct flag_settings *modifiers)
 {
 	int i;
 	struct ddebug_table *dt;
@@ -257,7 +278,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			continue;
 
 		if (query->class_string) {
-			map = ddebug_find_valid_class(dt, query->class_string, &valid_class);
+			map = ddebug_find_valid_class(&dt->info, query->class_string,
+						      &valid_class);
 			if (!map)
 				continue;
 		} else {
@@ -590,7 +612,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
 
 /* handle multiple queries in query string, continue on error, return
    last error or number of matching callsites.  Module name is either
-   in param (for boot arg) or perhaps in query string.
+   in the modname arg (for boot args) or perhaps in query string.
 */
 static int ddebug_exec_queries(char *query, const char *modname)
 {
@@ -737,7 +759,7 @@ static int param_set_dyndbg_module_classes(const char *instr,
 /**
  * param_set_dyndbg_classes - classmap kparam setter
  * @instr: string echo>d to sysfs, input depends on map_type
- * @kp:    kp->arg has state: bits/lvl, map, map_type
+ * @kp:    kp->arg has state: bits/lvl, classmap, map_type
  *
  * enable/disable all class'd pr_debugs in the classmap. For LEVEL
  * map-types, enforce * relative levels by bitpos.
@@ -774,6 +796,7 @@ int param_get_dyndbg_classes(char *buffer, const struct kernel_param *kp)
 	default:
 		return -1;
 	}
+	return 0;
 }
 EXPORT_SYMBOL(param_get_dyndbg_classes);
 
@@ -1089,12 +1112,17 @@ static bool ddebug_class_in_range(const int class_id, const struct ddebug_class_
 static const char *ddebug_class_name(struct _ddebug_info *di, struct _ddebug *dp)
 {
 	struct ddebug_class_map *map;
+	struct ddebug_class_user *cli;
 	int i;
 
 	for_subvec(i, map, di, maps)
 		if (ddebug_class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
+	for_subvec(i, cli, di, users)
+		if (ddebug_class_in_range(dp->class_id, cli->map))
+			return cli->map->class_names[dp->class_id - cli->map->base - cli->offset];
+
 	return NULL;
 }
 
@@ -1175,6 +1203,87 @@ static const struct proc_ops proc_fops = {
 	.proc_write = ddebug_proc_write
 };
 
+#define vpr_cm_info(cm_p, msg_fmt, ...) ({				\
+	struct ddebug_class_map const *_cm = cm_p;			\
+	v2pr_info(msg_fmt "%s [%d..%d] %s..%s\n", ##__VA_ARGS__,	\
+		  _cm->mod_name, _cm->base, _cm->base + _cm->length,	\
+		  _cm->class_names[0], _cm->class_names[_cm->length - 1]); \
+	})
+
+static void ddebug_sync_classbits(const struct kernel_param *kp, const char *modname)
+{
+	const struct ddebug_class_param *dcp = kp->arg;
+
+	/* clamp initial bitvec, mask off hi-bits */
+	if (*dcp->bits & ~CLASSMAP_BITMASK(dcp->map->length)) {
+		*dcp->bits &= CLASSMAP_BITMASK(dcp->map->length);
+		v2pr_info("preset classbits: %x\n", *dcp->bits);
+	}
+	/* force class'd prdbgs (in USEr module) to match (DEFINEr module) class-param */
+	ddebug_apply_class_bitmap(dcp, dcp->bits, ~0, modname);
+	ddebug_apply_class_bitmap(dcp, dcp->bits, 0, modname);
+}
+
+static void ddebug_match_apply_kparam(const struct kernel_param *kp,
+				      const struct ddebug_class_map *map,
+				      const char *mod_name)
+{
+	struct ddebug_class_param *dcp;
+
+	if (kp->ops != &param_ops_dyndbg_classes)
+		return;
+
+	dcp = (struct ddebug_class_param *)kp->arg;
+
+	if (dcp) {
+		v2pr_info(" kp:%s.%s =0x%x", mod_name, kp->name, *dcp->bits);
+		vpr_cm_info(map, " %s maps ", mod_name);
+		ddebug_sync_classbits(kp, mod_name);
+	}
+}
+
+static void ddebug_apply_params(const struct ddebug_class_map *cm, const char *mod_name)
+{
+	const struct kernel_param *kp;
+#if IS_ENABLED(CONFIG_MODULES)
+	int i;
+
+	if (cm->mod) {
+		vpr_cm_info(cm, "loaded classmap: %s ", mod_name);
+		/* ifdef protects the cm->mod->kp deref */
+		for (i = 0, kp = cm->mod->kp; i < cm->mod->num_kp; i++, kp++)
+			ddebug_match_apply_kparam(kp, cm, mod_name);
+	}
+#endif
+	if (!cm->mod) {
+		vpr_cm_info(cm, "builtin classmap: %s ", mod_name);
+		for (kp = __start___param; kp < __stop___param; kp++)
+			ddebug_match_apply_kparam(kp, cm, mod_name);
+	}
+}
+
+static void ddebug_apply_class_maps(const struct _ddebug_info *di)
+{
+	struct ddebug_class_map *cm;
+	int i;
+
+	for_subvec(i, cm, di, maps)
+		ddebug_apply_params(cm, cm->mod_name);
+
+	v2pr_di_info(di, "attached %d class-maps to ", i);
+}
+
+static void ddebug_apply_class_users(const struct _ddebug_info *di)
+{
+	struct ddebug_class_user *cli;
+	int i;
+
+	for_subvec(i, cli, di, users)
+		ddebug_apply_params(cli->map, cli->mod_name);
+
+	v2pr_di_info(di, "attached %d class-users to ", i);
+}
+
 /*
  * dd_set_module_subrange - find matching subrange of classmaps
  * @_i:   caller-provided index var
@@ -1212,6 +1321,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 {
 	struct ddebug_table *dt;
 	struct ddebug_class_map *cm;
+	struct ddebug_class_user *cli;
 	int i;
 
 	if (!di->descs.len)
@@ -1224,6 +1334,7 @@ static int ddebug_add_module(struct _ddebug_info *di)
 		pr_err("error adding module: %s\n", di->mod_name);
 		return -ENOMEM;
 	}
+	INIT_LIST_HEAD(&dt->link);
 	/*
 	 * For built-in modules, di is a partial cursor into the
 	 * builtin dyndbg data; the descriptors are the subrange
@@ -1240,12 +1351,19 @@ static int ddebug_add_module(struct _ddebug_info *di)
 	 */
 	dt->info = *di;
 	dd_set_module_subrange(i, cm, &dt->info, maps);
+	dd_set_module_subrange(i, cli, &dt->info, users);
+
+	if (dt->info.maps.len)
+		ddebug_apply_class_maps(&dt->info);
+	if (dt->info.users.len)
+		ddebug_apply_class_users(&dt->info);
 
 	mutex_lock(&ddebug_lock);
 	list_add_tail(&dt->link, &ddebug_tables);
 	mutex_unlock(&ddebug_lock);
 
-	vpr_info("%3u debug prints in module %s\n", di->descs.len, di->mod_name);
+	vpr_info("%3u debug prints in module %s\n",
+		 dt->info.descs.len, dt->info.mod_name);
 	return 0;
 }
 
@@ -1395,8 +1513,10 @@ static int __init dynamic_debug_init(void)
 	struct _ddebug_info di = {
 		.descs.start = __start___dyndbg_descs,
 		.maps.start  = __start___dyndbg_class_maps,
+		.users.start = __start___dyndbg_class_users,
 		.descs.len = __stop___dyndbg_descs - __start___dyndbg_descs,
 		.maps.len  = __stop___dyndbg_class_maps - __start___dyndbg_class_maps,
+		.users.len = __stop___dyndbg_class_users - __start___dyndbg_class_users,
 	};
 
 #ifdef CONFIG_MODULES
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 9e8e028461ad..512bac3179ad 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -6,11 +6,30 @@
  *      Jim Cromie	<jim.cromie@gmail.com>
  */
 
-#define pr_fmt(fmt) "test_dd: " fmt
+/*
+ * This file is built 2x, also making test_dynamic_debug_submod.ko,
+ * whose 2-line src file #includes this file.  This gives us a _submod
+ * clone with identical pr_debugs, without further maintenance.
+ *
+ * If things are working properly, they should operate identically
+ * when printed or adjusted by >control.  This eases visual perusal of
+ * the logs, and simplifies testing, by easing the proper accounting
+ * of expectations.
+ *
+ * It also puts both halves of the subsystem _DEFINE & _USE use case
+ * together, and integrates the common ENUM providing both class_ids
+ * and class-names to both _DEFINErs and _USERs.  I think this makes
+ * the usage clearer.
+ */
+#if defined(TEST_DYNAMIC_DEBUG_SUBMOD)
+  #define pr_fmt(fmt) "test_dd_submod: " fmt
+#else
+  #define pr_fmt(fmt) "test_dd: " fmt
+#endif
 
 #include <linux/module.h>
 
-/* run tests by reading or writing sysfs node: do_prints */
+/* re-gen output by reading or writing sysfs node: do_prints */
 
 static void do_prints(void); /* device under test */
 static int param_set_do_prints(const char *instr, const struct kernel_param *kp)
@@ -39,14 +58,36 @@ module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
  * Additionally, here:
  * - tie together sysname, mapname, bitsname, flagsname
  */
-#define DD_SYS_WRAP(_model, _flags)					\
-	static u32 bits_##_model;					\
-	static struct ddebug_class_param _flags##_model = {		\
+#define DYNAMIC_DEBUG_CLASSMAP_PARAM_(_model, _flags, _init)		\
+	static u32 bits_##_model = _init;				\
+	static struct ddebug_class_param _flags##_##_model = {		\
 		.bits = &bits_##_model,					\
 		.flags = #_flags,					\
 		.map = &map_##_model,					\
 	};								\
-	module_param_cb(_flags##_##_model, &param_ops_dyndbg_classes, &_flags##_model, 0600)
+	module_param_cb(_flags##_##_model, &param_ops_dyndbg_classes,	\
+			&_flags##_##_model, 0600)
+#ifdef DEBUG
+#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_model, _flags)		\
+	DYNAMIC_DEBUG_CLASSMAP_PARAM_(_model, _flags, ~0)
+#else
+#define DYNAMIC_DEBUG_CLASSMAP_PARAM(_model, _flags)		\
+	DYNAMIC_DEBUG_CLASSMAP_PARAM_(_model, _flags, 0)
+#endif
+
+/*
+ * Demonstrate/test DISJOINT & LEVEL typed classmaps with a sys-param.
+ *
+ * To comport with DRM debug-category (an int), classmaps map names to
+ * ids (also an int).  So a classmap starts with an enum; DRM has enum
+ * debug_category: with DRM_UT_<CORE,DRIVER,KMS,etc>.  We use the enum
+ * values as class-ids, and stringified enum-symbols as classnames.
+ *
+ * Modules with multiple CLASSMAPS must have enums with distinct
+ * value-ranges, as arranged below with explicit enum_sym = X inits.
+ * To clarify this sharing, declare the 2 enums now, for the 2
+ * different classmap types
+ */
 
 /* numeric input, independent bits */
 enum cat_disjoint_bits {
@@ -60,26 +101,51 @@ enum cat_disjoint_bits {
 	D2_LEASE,
 	D2_DP,
 	D2_DRMRES };
-DECLARE_DYNDBG_CLASSMAP(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS, 0,
-			"D2_CORE",
-			"D2_DRIVER",
-			"D2_KMS",
-			"D2_PRIME",
-			"D2_ATOMIC",
-			"D2_VBL",
-			"D2_STATE",
-			"D2_LEASE",
-			"D2_DP",
-			"D2_DRMRES");
-DD_SYS_WRAP(disjoint_bits, p);
-DD_SYS_WRAP(disjoint_bits, T);
-
-/* numeric verbosity, V2 > V1 related */
-enum cat_level_num { V0 = 14, V1, V2, V3, V4, V5, V6, V7 };
-DECLARE_DYNDBG_CLASSMAP(map_level_num, DD_CLASS_TYPE_LEVEL_NUM, 14,
-		       "V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7");
-DD_SYS_WRAP(level_num, p);
-DD_SYS_WRAP(level_num, T);
+
+/* numeric verbosity, V2 > V1 related.  V0 is > D2_DRMRES */
+enum cat_level_num { V0 = 16, V1, V2, V3, V4, V5, V6, V7 };
+
+/* recapitulate DRM's multi-classmap setup */
+#if !defined(TEST_DYNAMIC_DEBUG_SUBMOD)
+/*
+ * In single user, or parent / coordinator (drm.ko) modules, define
+ * classmaps on the client enums above, and then declares the PARAMS
+ * ref'g the classmaps.  Each is exported.
+ */
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_disjoint_bits, DD_CLASS_TYPE_DISJOINT_BITS,
+			      D2_CORE,
+			      "D2_CORE",
+			      "D2_DRIVER",
+			      "D2_KMS",
+			      "D2_PRIME",
+			      "D2_ATOMIC",
+			      "D2_VBL",
+			      "D2_STATE",
+			      "D2_LEASE",
+			      "D2_DP",
+			      "D2_DRMRES");
+
+DYNAMIC_DEBUG_CLASSMAP_DEFINE(map_level_num, DD_CLASS_TYPE_LEVEL_NUM,
+			      V0, "V0", "V1", "V2", "V3", "V4", "V5", "V6", "V7");
+
+/*
+ * now add the sysfs-params
+ */
+
+DYNAMIC_DEBUG_CLASSMAP_PARAM(disjoint_bits, p);
+DYNAMIC_DEBUG_CLASSMAP_PARAM(level_num, p);
+
+#else /* TEST_DYNAMIC_DEBUG_SUBMOD */
+
+/*
+ * in submod/drm-drivers, use the classmaps defined in top/parent
+ * module above.
+ */
+
+DYNAMIC_DEBUG_CLASSMAP_USE(map_disjoint_bits);
+DYNAMIC_DEBUG_CLASSMAP_USE(map_level_num);
+
+#endif
 
 /* stand-in for all pr_debug etc */
 #define prdbg(SYM) __pr_debug_cls(SYM, #SYM " msg\n")
@@ -115,6 +181,7 @@ static void do_levels(void)
 
 static void do_prints(void)
 {
+	pr_debug("do_prints:\n");
 	do_cats();
 	do_levels();
 }
diff --git a/lib/test_dynamic_debug_submod.c b/lib/test_dynamic_debug_submod.c
new file mode 100644
index 000000000000..672aabf40160
--- /dev/null
+++ b/lib/test_dynamic_debug_submod.c
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Kernel module for testing dynamic_debug
+ *
+ * Authors:
+ *      Jim Cromie	<jim.cromie@gmail.com>
+ */
+
+/*
+ * clone the parent, inherit all the properties, for consistency and
+ * simpler accounting in test expectations.
+ */
+#define TEST_DYNAMIC_DEBUG_SUBMOD
+#include "test_dynamic_debug.c"

-- 
2.55.0

