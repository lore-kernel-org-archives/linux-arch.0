Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6F3B7742
	for <linux-arch@vger.kernel.org>; Wed,  8 Jul 2026 02:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783477136; cv=none; b=UWSafWfJRSvnNoig1o+M7Z981ZZNGIMCewxU4e49oFPLq/E46E4zMUn+gtjs+Br2+5lQnZaBLrU4Wd0J2pzO5Z/uH4fBxX4WGde9JiM1o/NgyVy7xsqXJloQuAWRyGHRvLoeTqbABSDPYLA9ZX0fzg9+zlIy05q7NYhNOnnLEC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783477136; c=relaxed/simple;
	bh=RzrIxar2pUCMOS3uvTB/QLvw+jvQ/WW5WK4QNk+y9is=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qNo7gFB20RZXUnoBZPgCpOx2pox8IeurItQiwbDyPQ7NUCuILizA9CrVwO9NsYsC3kIe9jq794RoOzVgUrUe37rk7ZbsaUNrXtnTRWhd3l0TvDhtDcdaK9JzqhbzAiznnBdFU136TwHIlyhldpVYUOuDPsMBJ3sKjYpML2Xml4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RawzE/oM; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RawzE/oM"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7e9ed64d490so86218a34.3
        for <linux-arch@vger.kernel.org>; Tue, 07 Jul 2026 19:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783477131; x=1784081931; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QOLvA6jbnfc/c27LIRV0n7mgdpMF8Pu4CkvMzdxT5Oc=;
        b=RawzE/oMue/piQV++icXw0F+RDPbPpDEUvGqUB7VF97m6IqcGARSA7HeK7Hp4jjZNp
         tDt9yK1BnsklU1cS3BOwcUiSykywzAllsfJroPhnWIlAp8iPi2zWo9yyBhIWh2Trj2bD
         H0w3o2diliuFb+bFhU/fTgZmR76an9ulJVBg3cYrcgjr4N5z1bXBR5b+VLQvQoh90LQG
         8fbDPvPl5/zWXu9iPFsb6Lbqk5onbZC6OhmPkHjgq1Q7G/vCQ2FlmdQEMbdyUy703DDc
         X0sbQUM5exOzEsXqsFRXtR+WTwpf6jXrO2Eu8BceTwt3i2h6X7v7qXX19Ne/J4t4kUeX
         NggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783477131; x=1784081931;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QOLvA6jbnfc/c27LIRV0n7mgdpMF8Pu4CkvMzdxT5Oc=;
        b=HfOX40Pp2R0RgQNasx+7DyV7bn40fpg89iP3S2EWw/lUWalccEK53HAFTvHKQwxPqM
         t4SvJ+3PvkFrBTDq7Ndf9cBYv7cjGxKbngdtjZ2svl3sNknicGiIPxpncGUFd07isUr2
         k73/wp7e/ESq4MVmxXwC8xzavkm3JCyUAg8tBVi8Td+c7Msw2UCzZlA+F21Cu2rKloFf
         Baow+0zUBs7XdbEYwmV2/2c0QsfgfBXaka+z6GTy1/sNsi4Y/zX6LHFTsN4+yNxvTSpw
         RRXrTGcei4XSE7ohOfsIMGE7dv1nnWk5TGg7iv0nBUB7JbnyeMeVmBq04Fm+yKP4dzMr
         aUrw==
X-Forwarded-Encrypted: i=1; AFNElJ8Hmhd3vEh9JEeFcqeKH2/Ib9bekKJjgAkqviEejVaFTJYICS0GxPQa3X2ccQvg8aEI09Zhf/rL/gpV@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuxKsZO2ngqICnBvPkl6nMcb6gXIUGcqNXo4D4aqrnkR9vibG
	Q9NblLytUvJ/zBV2bSMY17mYxQE7LTRSpSotZcMURKBDPYuo37+5ktoW
X-Gm-Gg: AfdE7cnSSW59zPZ+uW/Xc5Q6bMu5xkvaDLAVxfQWnsO/EOQf3Mp9M9BjjRg0pQg9Nud
	7D1iaDEK/V43y0zf3yfDVOwvmFzkAqm9+xhD1o6haHG0tcPx1BRUT191dGKENFNVv6q8taSJvnk
	UbvVXLeN1lvuz3ndirGIZNh0k/TvQz75RXStviyAXSExE7xEp9yIWZW0mo97Zp3fg24o5IaiZx5
	BHKU42PKvLDDqc7ikTWI62GBI3oFAm3o4KyLqF7EygmQBMZLMetXNSUbbUrLmlZ4xmbDyWvIiNn
	sDm64DcbPB/gby2icqEDl++4audBjk/E7XJT4/rEbccV8i0o6Udh2pq62Xt56U6X0mxJoestjsn
	Qg6LLHr9hT9E7o9N1qf41UBQSX4v7wzl8LUcY1f1mZx/LmWChK1e9owWSrLvlxjEmglqXj1IU36
	ljIk49e7tw78535C0fNhxt3uFarQ19BSenXtlG0P1FKRLmwh3CVKo=
X-Received: by 2002:a05:6808:5282:b0:486:5466:e41f with SMTP id 5614622812f47-4a204dfcdddmr356853b6e.38.1783477131430;
        Tue, 07 Jul 2026 19:18:51 -0700 (PDT)
Received: from [192.168.0.245] (c-98-38-17-99.hsd1.co.comcast.net. [98.38.17.99])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-4a1aa006f74sm799975b6e.0.2026.07.07.19.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 19:18:50 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 07 Jul 2026 20:18:14 -0600
Subject: [PATCH v6 14/24] dyndbg: use KBUILD_MODFILE for unique builtin
 module names
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-dd-maint-2-v6-14-381f3edb0045@gmail.com>
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
 linux-modules@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783477102; l=8855;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=RzrIxar2pUCMOS3uvTB/QLvw+jvQ/WW5WK4QNk+y9is=;
 b=4pdYgovF1y3kKIJY82j0T/no333FMDF5fzRY2h/fx9JHNadGa2pvTJOqoUfZuFklQ55qGYPf1
 Tar3TCfcnkUDklwUc2pomUMYzZVTNDPTSxfOp9++JLHtY0kEWMLy2AE
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Historically dynamic-debug gets its module names from KBUILD_MODNAME.
This works well for loadable modules, as the module loader has always
required them to have unique names, but for builtins it is basically
kbasename(srcfile), which sadly gives us many modules named "main".

IOW, it makes this ambiguous:
  bash-5.3# echo module main +m > /proc/dynamic_debug/control

since it would affect all 4 independent modules named main:
  bash-5.3# ddgrep =m
  init/main.c:1265 [main]initcall_blacklist =m "blacklisting initcall %s\n"
  kernel/power/main.c:49 [main]pm_restore_gfp_mask =m "GFP mask restored\n"
  kernel/module/main.c:2862 [main]move_module =m "\t0x%lx 0x%.8lx %s\n"
  drivers/base/power/main.c:149 [main]device_pm_add =m "Adding info for %s:%s\n"

We can improve this by using KBUILD_MODFILE for dyndbg's modname in
builtins (which is unique), and KBUILD_MODNAME for loadables (which is
already required/guaranteed to be unique by module-loader):

The above control-file entries then become:
  init/main.c:1265 [init/main]initcall_blacklist ...
  kernel/power/main.c:49 [kernel/power/main]pm_restore_gfp_mask ...
  kernel/module/main.c:2862 [kernel/module/main]move_module ...
  drivers/base/power/main.c:149 [drivers/base/power/main]device_pm_add ...

While this is a user visible change; [params] becomes [kernel/params]
etc, it is not a behavior change; we now match the query-module
against the subsystem/module name or its kbasename (the
simple-modname), which as before, matches all 4 modules.

This allows queries to be specific when desired: "module init/main",
while preserving the existing meaning of "module main"

The deeper reason for this change is not obvious.  If any builtin
"main" module were to add a classmap, it would attach to all "main"
modules.  If 2 "main" modules defined separate classmaps, both modules
would inadvertently share both classmaps.  Since classmaps map
classnames to 0..62, and independently defined classmaps are most
likely to start at 0 (unless author is planning to share the 0..62
range with other classmaps), we have a setup for later reserved range
conflicts.  Having unique names prevents future conflicts.

This solution isn't perfect:
1. it changes displayed [params] to [kernel/params] etc
2. its mostly redundant with "filename */main.*"
3. Ideally, queries like "module power", "module module", "module
   base/power" might be better but would break old queries.

Adding classmaps to the builtins named "[main]" is unlikely, so this
change isn't absolutely necessary, but it seemed proper to at least
address the latent problem.

Adjust Documentation with "simple modname" and "subsystem modname".

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
v5: move ahead of array-slice patch to silence sashiko complaint about it
v4: call match_wildcard_hyphen() to allow dash vs underscore modname equivalence
v3: use KBUILD_MODFILE to give unique modnames for builtins
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 42 +++++++++++++----------
 include/linux/dynamic_debug.h                     | 15 ++++++--
 lib/dynamic_debug.c                               |  3 +-
 3 files changed, 38 insertions(+), 22 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 9c2f096ed1d8..99bbae37d34e 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -38,12 +38,12 @@ You can view the currently configured behaviour in the *prdbg* catalog::
 
   :#> head -n7 /proc/dynamic_debug/control
   # filename:lineno [module]function flags format
-  init/main.c:1179 [main]initcall_blacklist =_ "blacklisting initcall %s\n"
-  init/main.c:1218 [main]initcall_blacklisted =_ "initcall %s blacklisted\n"
-  init/main.c:1424 [main]run_init_process =_ "  with arguments:\n"
-  init/main.c:1426 [main]run_init_process =_ "    %s\n"
-  init/main.c:1427 [main]run_init_process =_ "  with environment:\n"
-  init/main.c:1429 [main]run_init_process =_ "    %s\n"
+  init/main.c:1179 [init/main]initcall_blacklist =_ "blacklisting initcall %s\n"
+  init/main.c:1218 [init/main]initcall_blacklisted =_ "initcall %s blacklisted\n"
+  init/main.c:1424 [init/main]run_init_process =_ "  with arguments:\n"
+  init/main.c:1426 [init/main]run_init_process =_ "    %s\n"
+  init/main.c:1427 [init/main]run_init_process =_ "  with environment:\n"
+  init/main.c:1429 [init/main]run_init_process =_ "    %s\n"
 
 The 3rd space-delimited column shows the current flags, preceded by
 a ``=`` for easy use with grep/cut. ``=p`` shows enabled callsites.
@@ -59,10 +59,10 @@ query/commands to the control file.  Example::
 
   :#> ddcmd '-p; module main func run* +p'
   :#> grep =p /proc/dynamic_debug/control
-  init/main.c:1424 [main]run_init_process =p "  with arguments:\n"
-  init/main.c:1426 [main]run_init_process =p "    %s\n"
-  init/main.c:1427 [main]run_init_process =p "  with environment:\n"
-  init/main.c:1429 [main]run_init_process =p "    %s\n"
+  init/main.c:1424 [init/main]run_init_process =p "  with arguments:\n"
+  init/main.c:1426 [init/main]run_init_process =p "    %s\n"
+  init/main.c:1427 [init/main]run_init_process =p "  with environment:\n"
+  init/main.c:1429 [init/main]run_init_process =p "    %s\n"
 
 Error messages go to console/syslog::
 
@@ -161,17 +161,21 @@ file
 	file kernel/freezer.c	# ie column 1 of control file
 	file drivers/usb/*	# all callsites under it
 	file inode.c:start_*	# parse :tail as a func (above)
-	file inode.c:1-100	# parse :tail as a line-range (above)
+	file inode.c:1-100	# parse :tail as a line-range (below)
 
 module
-    The given string is compared against the module name
-    of each callsite.  The module name is the string as
-    seen in ``lsmod``, i.e. without the directory or the ``.ko``
-    suffix and with ``-`` changed to ``_``.  Examples::
-
-	module sunrpc
-	module nfsd
-	module drm*	# both drm, drm_kms_helper
+    The query string is compared against the subsystem module name of
+    each callsite, as shown in the control file, or its simple name.
+    The simple module name is the string as seen in ``lsmod``,
+    i.e. without the directory or the ``.ko`` suffix and with ``-``
+    changed to ``_``.
+    Examples::
+
+        module nfsd        # simple modname (as from lsmod)
+	module init/main   # subsystem modname (as in control file)
+	module */main	   # any subsystem ending in main
+        module main	   # simple modname, selects same as above
+	module drm*	   # both drm, drm_kms_helper
 
 format
     The given string is searched for in the dynamic debug format
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 9ae1accb9bf6..da9e5c35bc43 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -10,6 +10,17 @@
 
 #define __DDEBUG_ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
+/*
+ * Pick the best name for the module:
+ * KBUILD_MODFILE includes the path (e.g., drivers/usb/core/usbcore) for built-ins.
+ * Fall back to KBUILD_MODNAME for modules (loader requires unique names).
+ */
+#ifdef KBUILD_MODFILE
+# define DDEBUG_MODNAME KBUILD_MODFILE
+#else
+# define DDEBUG_MODNAME KBUILD_MODNAME
+#endif
+
 /*
  * An instance of this structure is created in a special
  * ELF section at every dynamic debug callsite.  At runtime,
@@ -121,7 +132,7 @@ struct ddebug_class_param {
 	static struct ddebug_class_map __aligned(8) __used		\
 		__section("__dyndbg_classes") _var = {			\
 		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
+		.mod_name = DDEBUG_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
 		.length = (sizeof(_var##_classnames) / sizeof(_var##_classnames[0])), \
@@ -160,7 +171,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg") name = {				\
-		.modname = KBUILD_MODNAME,			\
+		.modname = DDEBUG_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
 		.format = (fmt),				\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 2e321b7eb957..ce42e03f1600 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -239,7 +239,8 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard(query->module, dt->mod_name))
+		    !match_wildcard_hyphen(query->module, dt->mod_name) &&
+		    !match_wildcard_hyphen(query->module, kbasename(dt->mod_name)))
 			continue;
 
 		if (query->class_string) {

-- 
2.55.0

