Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0F3DA7D1
	for <linux-arch@vger.kernel.org>; Tue,  2 Jun 2026 22:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780440566; cv=none; b=R0kD8O4WHKEt1lAoZ+D+LvUY213IdveN4qVMeMiKkiC1Qh0Wjflq371cOTV9IAlBy/RAewHvgr6dH3cjy2eT8/ZqsHNpnDiqQA6atcsXbV2bVSw+2R/BpWn1baeLQIS8QA5rUYakwdZH2EuLE50sApW2m17GKTUR0TrS9txmDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780440566; c=relaxed/simple;
	bh=lthlKNyUq5gUtWvLVtrD/SKctmL38wo7iVjBwbNR+uY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HIfyDKHaL+1WXhOfc1B95hXKmxo5QAEOkPLX/OtqKMKabUhXREyvd3bEExMA+BXHv64NTZ9FOdx+VPyLEahVqZELcCT9M2z++MZitANS8eiv5FDk2O3B6Gpt3A8vU4IMzzW7wp0XpT0aIo7LiQxxzEKAM/WZgBZZTtZkjg/HyP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D2TNV4nb; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D2TNV4nb"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ef1629ff4so3688307f8f.0
        for <linux-arch@vger.kernel.org>; Tue, 02 Jun 2026 15:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780440563; x=1781045363; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QCgszUrgNi7grQDH6VE2VsdkLUzjuVRFv4kl/ONnNts=;
        b=D2TNV4nbX1LlPxC3y8ziQylITCeLqO6irzPn1Y3v3tIZ9dZIiuy1AxNs7P+XCO/Da8
         fmKavKlccct4BkfkUwrpLIHZKCLQcCQ91zYhQk0IX+kjH+HZyDjAW8RkV7fakM3OPKnw
         Cc61u3wWQPxiQwzL/93MiAY9IT7PT8EfojQINc0RISz4I59N5uPLbiuyP5d4PhWSBgJz
         LZlVgcgMGRa+ZuzyHbucaD4wmsefVM02MtrmhVVdbclQsIwR2NdVFHJUOAfmQyezmlH9
         yN7J6uNRaz7hVO0A3LvB9+EgoU2gfp/qMCfp0eP0Bo0Mku7CnxxfANv860FdYgV9BfyL
         GPWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780440563; x=1781045363;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QCgszUrgNi7grQDH6VE2VsdkLUzjuVRFv4kl/ONnNts=;
        b=ixOz3PFwnk8PcpyWxWSmu0JCINyGA0/xWrSdETGCm+FKny2H9LJSdGma6Rs52ihwIi
         HEKLxIolX0z8/VUuNVPDdRGj3AAqs7l8MLoUXTd+ZTJNFQp3UyXmMYyhObzYNy3rg4Ru
         XJG1hfPvaRnVg7X/SuWH0FGVZNZp0CiMgIZop9ud4xCnRfAmjtdqaznw71cUHL5cxkLT
         3isHFX/3FtIMIvZzPmJpSlUkoZzxBnAoSDv+g+VvwFv7OY8Ujncfz7KpyuNhpiHmgYuE
         I71A+m954emsOEXQdNhIq+MDnFtE/yrv/qHOEzDqoNlb0Y+bAI8g8d74EAEBY84glU04
         uadw==
X-Forwarded-Encrypted: i=1; AFNElJ85SiKuGYAuRUeGBHzjDyrmiQlhwBYIQfV0hlRrMzZAKsEhH2V/vgKlTy6gFtT4aga3WZZQqmJxZXwh@vger.kernel.org
X-Gm-Message-State: AOJu0YyZI4R/AQ0tF6HnYt/RY56bM6fkO0on21zJfCoOlclQeppOtKSI
	ldXcJxpzO2KZpBmKmBZhLMviArT81EEnmQs9qjY0bBFV547fI1PEjJrd
X-Gm-Gg: Acq92OHtoGs133TizZgqQ/+fCqAHQSYpjb5csM3WtmxAD71DKcT08+LAwkBlHijqjZT
	ZKtvr3HOoRQPOvo+a6KrtOA+5ep0wl7MuCOI4I20tHukXRD0ePMBem7G3/Eg6NtJQc30BgYQuNN
	fIcY2WXIrjhmnYV+PSUo/oPBlEVm0fHJzzz9N4wMTjUyqBaD9PSXFJFy9NIvvoSp/TGBAcU7Wly
	gNwByeuIJ3r+Ph5HbJnnmzZk0PmQ6eANmI1PoHeC37XZDsS/4CG5yLQMXsWUBrNmeJ0KhCipqmN
	hOyOVrxalOk9N7lf+1L8lUiNvzafYliNLPvYlgF4dYDXdhaAPlsAAn7FfC6PGUu+m+Hvyq1CCbw
	PyGrzIU8cAzuZyC2AEO+CXWjJCWrfYxMQaZICoT7PnGV5AENPGuFysak+vdEE4HhnXd+n4kXLox
	oJ201E43hHbuNmoUtqih0jEz2VdtsD51tPrXLzPrtu6Q==
X-Received: by 2002:adf:e00e:0:10b0:45e:93b2:37bb with SMTP id ffacd0b85a97d-46021781c20mr451609f8f.6.1780440562462;
        Tue, 02 Jun 2026 15:49:22 -0700 (PDT)
Received: from [172.16.188.153] ([213.181.114.83])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4601f2f2710sm1999791f8f.14.2026.06.02.15.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 15:49:21 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 02 Jun 2026 22:48:22 +0000
Subject: [PATCH v4 25/25] dynamic_debug: use KBUILD_MODFILE for unique
 builtin module names
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dd-maint-2-v4-25-19a1445585a8@gmail.com>
References: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
In-Reply-To: <20260602-dd-maint-2-v4-0-19a1445585a8@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 Jason Baron <jbaron@akamai.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Jim Cromie <jim.cromie@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780440488; l=13699;
 i=jim.cromie@gmail.com; s=20260203; h=from:subject:message-id;
 bh=lthlKNyUq5gUtWvLVtrD/SKctmL38wo7iVjBwbNR+uY=;
 b=ZR2ERRpc7QxcWHTdurm0228LMQX3bNexpUtw/VCDnnM06DWx133ipZnZNguxNUs9x4RBoiZn0
 6P6N2XWxty+BxCnjt8MUHPdzE82vXQAACHjyiLkEthIPu1kXpPKwwVo
X-Developer-Key: i=jim.cromie@gmail.com; a=ed25519;
 pk=C6E5ODlPQo7ZBynATXH9wg7K6HxP0pIXyf4s38Qw0XE=

Historically dynamic-debug gets its module names from KBUILD_MODNAME.
This works well for loadable modules, as the module loader has always
required them to have unique names, but for builtins it is basically
kbasename(srcfile), which sadly gives us many modules named "main".

This makes the following ambiguous:
  bash-5.3# echo module main +m > /proc/dynamic_debug/control

since it would affect 4 independent modules named main:
  bash-5.3# ddgrep =m
  init/main.c:1265 [main]initcall_blacklist =m "blacklisting initcall %s\n"
  kernel/power/main.c:49 [main]pm_restore_gfp_mask =m "GFP mask restored\n"
  kernel/module/main.c:2862 [main]move_module =m "\t0x%lx 0x%.8lx %s\n"
  drivers/base/power/main.c:149 [main]device_pm_add =m "Adding info for %s:%s\n"

We can improve this by using KBUILD_MODFILE for dyndbg's modname in
builtins, and KBUILD_MODNAME for loadables.

The above control-file entries then become:
  init/main.c:1265 [init/main]initcall_blacklist ...
  kernel/power/main.c:49 [kernel/power/main]pm_restore_gfp_mask ...
  kernel/module/main.c:2862 [kernel/module/main]move_module ...
  drivers/base/power/main.c:149 [drivers/base/power/main]device_pm_add ...

While this is a user visible change; [params] becomes [kernel/params],
it is not a behavior change; we now match the query-module against the
subsystem/module name or its kbasename (the simple-modname), which as
before, matches all 4 modules.

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
3. "module power", "module module", "module base/power" might be better
   but would break old queries.

Adapt dynamic-debug selftest:
1- Add 'test_subsystem_module_queries' to verify path-based module matching.
2- Use dynamic counting with precise regexes to determine expectations.
3- Reorder tests to run slash-query verification immediately after
   basic tests.
4- Update basic_tests and comma_terminator_tests to use 'kernel/params'
   instead of 'params' to match new path-based names for built-ins.

And adjust Documentation

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---

v4: use new match_wildcard_hyphen() to allow dash vs underscore
equivalence in query-modname vs KBUILD_MODFILE string, noted by sashiko.

v3: new patch in rev-3
use KBUILD_MODFILE to provide modname for builtin modules, giving
unnique values that KBUILD_MODANME does not provide.
---
 Documentation/admin-guide/dynamic-debug-howto.rst  | 40 +++++-----
 include/linux/dynamic_debug.h                      | 17 +++-
 lib/dynamic_debug.c                                |  3 +-
 .../selftests/dynamic_debug/dyndbg_selftest.sh     | 93 +++++++++++++++++++++-
 4 files changed, 126 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 9c2f096ed1d8..8befb69575b7 100644
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
 
@@ -161,17 +161,19 @@ file
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
+    each callsite, as shown in the control file.  The simple module
+    name is the string as seen in ``lsmod``, i.e. without the
+    directory or the ``.ko`` suffix and with ``-`` changed to ``_``.
+
+    Examples::
+
+	module nfsd        # simple modname (as from lsmod)
+	module init/main   # subsystem modname (as in control file)
+	module drm*	   # both drm, drm_kms_helper
 
 format
     The given string is searched for in the dynamic debug format
diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 2d6983186f37..aee6f3d0916f 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -8,6 +8,17 @@
 
 #include <linux/build_bug.h>
 
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
@@ -128,9 +139,9 @@ struct _ddebug_class_param {
 #define DECLARE_DYNDBG_CLASSMAP(_var, _maptype, _base, ...)		\
 	static const char *_var##_classnames[] = { __VA_ARGS__ };	\
 	static struct _ddebug_class_map __aligned(8) __used		\
-		__section("__dyndbg_class_maps") _var = {			\
+	__section("__dyndbg_class_maps") _var = {			\
 		.mod = THIS_MODULE,					\
-		.mod_name = KBUILD_MODNAME,				\
+		.mod_name = DDEBUG_MODNAME,				\
 		.base = _base,						\
 		.map_type = _maptype,					\
 		.length = ARRAY_SIZE(_var##_classnames),		\
@@ -169,7 +180,7 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 #define DEFINE_DYNAMIC_DEBUG_METADATA_CLS(name, cls, fmt)	\
 	static struct _ddebug  __aligned(8)			\
 	__section("__dyndbg_descs") name = {			\
-		.modname = KBUILD_MODNAME,			\
+		.modname = DDEBUG_MODNAME,			\
 		.function = __func__,				\
 		.filename = __FILE__,				\
 		.format = (fmt),				\
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 996daf0a05b5..b6c5634096fa 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -248,7 +248,8 @@ static int ddebug_change(const struct ddebug_query *query,
 
 		/* match against the module name */
 		if (query->module &&
-		    !match_wildcard(query->module, di->mod_name))
+		    !match_wildcard_hyphen(query->module, di->mod_name) &&
+		    !match_wildcard_hyphen(query->module, kbasename(di->mod_name)))
 			continue;
 
 		if (query->class_string) {
diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 1239f1e10591..26cca9f24799 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -76,9 +76,9 @@ function handle_exit_code() {
 # $1 - pattern to match, pattern in $1 is enclosed by spaces for a match ""\s$1\s"
 # $2 - number of times the pattern passed in $1 is expected to match
 # $3 - optional can be set either to "-r" or "-v"
-#       "-r" means relaxed matching in this case pattern provided in $1 is passed
-#       as is without enclosing it with spaces
-#       "-v" prints matching lines
+#       "-r" means relaxed matching in this case pattern provided in
+#       $1 is passed as is without enclosing it with spaces "-v"
+#       prints matching lines
 # $4 - optional when $3 is set to "-r" then $4 can be used to pass "-v"
 function check_match_ct {
     pattern="\s$1\s"
@@ -223,7 +223,7 @@ function basic_tests {
     check_match_ct =p 0
 
     # module params are builtin to handle boot args
-    check_match_ct '\[params\]' 4 -r
+    check_match_ct '\[kernel/params\]' 4 -r
     ddcmd module params +mpf
     check_match_ct =pmf 4
 
@@ -238,8 +238,93 @@ EOF
     ddcmd =_
 }
 
+function test_subsystem_module_queries {
+    echo -e "${GREEN}# TEST_SUBSYTEM_MODULE_QUERIES ${NC}"
+    ddcmd =_
+
+    # Find how many 'main' modules we have in total (by basename)
+    # Use a more precise regex to avoid false positives like [irqdomain]
+    local total_main=$(grep -c "\[\([^]]*/\)\?main\]" /proc/dynamic_debug/control)
+    echo "# found $total_main total 'main' modules"
+
+    if [ $total_main -eq 0 ]; then
+        echo "SKIP - no 'main' modules found to test slashes"
+        return
+    fi
+
+    echo "# testing 'module */main'"
+    ddcmd module "*/main" +p
+    # This should match modules that HAVE a slash and end in /main
+    local slash_main=$(grep -c "\[[^]]*/main\]" /proc/dynamic_debug/control)
+    check_match_ct =p $slash_main -r
+
+    echo "# testing 'module init/main' (specific path)"
+    ddcmd =_
+    ddcmd module "init/main" +p
+    local init_main=$(grep -c "\[init/main\]" /proc/dynamic_debug/control)
+    check_match_ct =p $init_main
+
+    echo "# testing 'module main' (basename match)"
+    ddcmd =_
+    ddcmd module main +p
+    # This should match ALL $total_main entries due to kbasename matching
+    check_match_ct =p $total_main
+
+    ddcmd =_
+}
+
+function test_hyphen_underscore {
+    echo -e "${GREEN}# TEST_HYPHEN_UNDERSCORE ${NC}"
+    ddcmd =_
+
+    # Find a module with a hyphen in its name (e.g., from the control file)
+    local mod_with_hyphen=$(grep -m1 "\[[^]]*-[^]]*\]" /proc/dynamic_debug/control | sed -n 's/.*\[\(.*\)\].*/\1/p')
+
+    if [ -z "$mod_with_hyphen" ]; then
+        echo "SKIP - no module with hyphen found in /proc/dynamic_debug/control"
+        return
+    fi
+
+    echo "# testing hyphen/underscore equivalence for module: $mod_with_hyphen"
+    local mod_with_underscore=$(echo "$mod_with_hyphen" | tr '-' '_')
+
+    # 1. Enable using literal hyphen name
+    echo "#   trying hyphen name: $mod_with_hyphen"
+    ddcmd module "$mod_with_hyphen" +p
+    local count_hyphen=$(grep -c "\[$mod_with_hyphen\]" /proc/dynamic_debug/control)
+    check_match_ct =p $count_hyphen -r
+
+    # 2. Disable and then enable using underscore name
+    ddcmd =_
+    echo "#   trying underscore name: $mod_with_underscore"
+    ddcmd module "$mod_with_underscore" +p
+    check_match_ct =p $count_hyphen -r
+
+    # 3. Try kbasename with hyphen (if it has a path)
+    local base_hyphen=$(basename "$mod_with_hyphen")
+    if [ "$base_hyphen" != "$mod_with_hyphen" ]; then
+        ddcmd =_
+        echo "#   trying hyphen kbasename: $base_hyphen"
+        ddcmd module "$base_hyphen" +p
+        local count_base=$(grep -c "\[\([^]]*/\)\?$base_hyphen\]" /proc/dynamic_debug/control)
+        check_match_ct =p $count_base -r
+    fi
+
+    # 4. Try kbasename with underscore
+    local base_underscore=$(echo "$base_hyphen" | tr '-' '_')
+    ddcmd =_
+    echo "#   trying underscore kbasename: $base_underscore"
+    ddcmd module "$base_underscore" +p
+    local count_base=$(grep -c "\[\([^]]*/\)\?$base_hyphen\]" /proc/dynamic_debug/control)
+    check_match_ct =p $count_base -r
+
+    ddcmd =_
+}
+
 tests_list=(
     basic_tests
+    test_subsystem_module_queries
+    test_hyphen_underscore
 )
 
 # Run tests

-- 
2.54.0

