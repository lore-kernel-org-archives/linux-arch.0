From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v3 24/29] LoadPin: Initialize as ordered LSM
Date: Mon, 24 Sep 2018 17:18:27 -0700
Message-ID: <20180925001832.18322-25-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This converts LoadPin from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h  | 5 -----
 security/Kconfig           | 2 +-
 security/loadpin/loadpin.c | 7 ++++++-
 security/security.c        | 1 -
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index ab23f1bc6d77..9df08955f684 100644
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
index 7ec86dbdb6b8..e20c2a3143e7 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -293,7 +293,7 @@ config LSM_ENABLE
 
 config LSM_ORDER
 	string "Default initialization order of builtin LSMs"
-	default "integrity"
+	default "loadpin,integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be link-order initialized
diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index d8a68a6f6fef..7abdf4619b46 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -184,13 +184,18 @@ static struct security_hook_list loadpin_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(kernel_load_data, loadpin_load_data),
 };
 
-void __init loadpin_add_hooks(void)
+static int __init loadpin_init(void)
 {
 	pr_info("ready to pin (currently %senforcing)\n",
 		enforcing ? "" : "not ");
 	security_add_hooks(loadpin_hooks, ARRAY_SIZE(loadpin_hooks), "loadpin");
+	return 0;
 }
 
+DEFINE_LSM(loadpin)
+	.init = loadpin_init,
+END_LSM;
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforcing, int, 0);
 MODULE_PARM_DESC(enforcing, "Enforce module/firmware pinning");
diff --git a/security/security.c b/security/security.c
index f1c3581d870f..cb25f321e044 100644
--- a/security/security.c
+++ b/security/security.c
@@ -305,7 +305,6 @@ int __init security_init(void)
 	 */
 	capability_add_hooks();
 	yama_add_hooks();
-	loadpin_add_hooks();
 
 	/* Load LSMs in specified order. */
 	prepare_lsm_order();
-- 
2.17.1
