Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f193.google.com ([209.85.215.193]:34604 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731713AbeITWNx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 18:13:53 -0400
Received: by mail-pg1-f193.google.com with SMTP id d19-v6so4694682pgv.1
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 09:29:36 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 21/26] LoadPin: Initialize as ordered LSM
Date: Thu, 20 Sep 2018 09:23:33 -0700
Message-ID: <20180920162338.21060-22-keescook@chromium.org>
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180920162333.1jO97_ogPwCMtQtaxiJinr_W15Kj1qAXvblcZ2nYrrs@z>

This converts LoadPin from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h  |  5 -----
 security/Kconfig           |  2 +-
 security/loadpin/loadpin.c | 10 ++++++++--
 security/security.c        |  1 -
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ec1c0a97dfe3..7a38ffdd690f 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2097,10 +2097,5 @@ extern void __init yama_add_hooks(void);
 #else
 static inline void __init yama_add_hooks(void) { }
 #endif
-#ifdef CONFIG_SECURITY_LOADPIN
-void __init loadpin_add_hooks(void);
-#else
-static inline void loadpin_add_hooks(void) { };
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index de8202886c1d..f2003bd03ef6 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -278,7 +278,7 @@ config DEFAULT_SECURITY
 
 config LSM_ORDER
 	string "Default initialization order of builtin LSMs"
-	default "integrity"
+	default "loadpin,integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be link-order initialized
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index 0716af28808a..e638fba7363d 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -184,12 +184,18 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
-void __init loadpin_add_hooks(void)
+static int __init loadpin_init(void)
 {
-	pr_info("ready to pin (currently %sabled)", enabled ? "en" : "dis");
+	pr_info("ready to pin\n");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	return 0;
 }
 
+DEFINE_LSM(loadpin)
+	.enabled = &enabled,
+	.init = loadpin_init,
+END_LSM;
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enabled, int, 0);
 MODULE_PARM_DESC(enabled, "Pin module/firmware loading (default: true)");
diff --git a/security/security.c b/security/security.c
index 4db194f81419..9ffb76b7655b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -246,7 +246,6 @@ int __init security_init(void)
 	 */
 	capability_add_hooks();
 	yama_add_hooks();
-	loadpin_add_hooks();
 
 	/* Load LSMs in specified order. */
 	prepare_lsm_order();
-- 
2.17.1
