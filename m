Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44340 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387522AbeITWIF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 18:08:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id k21-v6so4602713pff.11
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 09:23:49 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 05/26] LSM: Convert from initcall to struct lsm_info
Date: Thu, 20 Sep 2018 09:23:17 -0700
Message-ID: <20180920162338.21060-6-keescook@chromium.org>
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180920162317.zOHClwHEt8gkdSLD6IKkneI32hrSRCFzx8rt9Mvqyow@z>

In preparation for doing more interesting LSM init probing, this converts
the existing initcall system into an explicit call into a function pointer
from a section-collected struct lsm_info array.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/init.h      |  2 --
 include/linux/lsm_hooks.h | 12 ++++++++++++
 include/linux/module.h    |  1 -
 security/integrity/iint.c |  1 +
 security/security.c       | 14 +++++---------
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index 77636539e77c..9c2aba1dbabf 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -133,7 +133,6 @@ static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
 #endif
 
 extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
-extern initcall_entry_t __start_lsm_info[], __end_lsm_info[];
 
 /* Used for contructor calls. */
 typedef void (*ctor_fn_t)(void);
@@ -236,7 +235,6 @@ extern bool initcall_debug;
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
 #define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
-#define security_initcall(fn)	___define_initcall(fn,, .lsm_info)
 
 struct obs_kernel_param {
 	const char *str;
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 97a020c616ad..ad04761e5587 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2039,6 +2039,18 @@ extern char *lsm_names;
 extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
+struct lsm_info {
+	int (*init)(void);
+};
+
+extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
+
+#define security_initcall(lsm)						\
+	static struct lsm_info __lsm_##lsm				\
+		__used __section(.lsm_info.init)			\
+		__aligned(sizeof(unsigned long))			\
+		= { .init = lsm, }
+
 #ifdef CONFIG_SECURITY_SELINUX_DISABLE
 /*
  * Assuring the safety of deleting a security module is up to
diff --git a/include/linux/module.h b/include/linux/module.h
index f807f15bebbe..264979283756 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -123,7 +123,6 @@ extern void cleanup_module(void);
 #define late_initcall_sync(fn)		module_init(fn)
 
 #define console_initcall(fn)		module_init(fn)
-#define security_initcall(fn)		module_init(fn)
 
 /* Each module must use one module_init(). */
 #define module_init(initfn)					\
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 5a6810041e5c..70d21b566955 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -22,6 +22,7 @@
 #include <linux/file.h>
 #include <linux/uaccess.h>
 #include <linux/security.h>
+#include <linux/lsm_hooks.h>
 #include "integrity.h"
 
 static struct rb_root integrity_iint_tree = RB_ROOT;
diff --git a/security/security.c b/security/security.c
index 41a5da2c7faf..e74f46fba591 100644
--- a/security/security.c
+++ b/security/security.c
@@ -43,16 +43,12 @@ char *lsm_names;
 static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 	CONFIG_DEFAULT_SECURITY;
 
-static void __init do_security_initcalls(void)
+static void __init major_lsm_init(void)
 {
-	initcall_t call;
-	initcall_entry_t *ce;
+	struct lsm_info *lsm;
 
-	ce = __start_lsm_info;
-	while (ce < __end_lsm_info) {
-		call = initcall_from_entry(ce);
-		call();
-		ce++;
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		lsm->init();
 	}
 }
 
@@ -82,7 +78,7 @@ int __init security_init(void)
 	/*
 	 * Load all the remaining security modules.
 	 */
-	do_security_initcalls();
+	major_lsm_init();
 
 	return 0;
 }
-- 
2.17.1
