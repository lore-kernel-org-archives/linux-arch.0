From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 22/26] Yama: Initialize as ordered LSM
Date: Thu, 20 Sep 2018 09:23:34 -0700
Message-ID: <20180920162338.21060-23-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This converts Yama from being a direct "minor" LSM into an ordered LSM.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 5 -----
 security/Kconfig          | 2 +-
 security/security.c       | 1 -
 security/yama/yama_lsm.c  | 7 ++++++-
 4 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 7a38ffdd690f..d75a42eb3ddd 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2092,10 +2092,5 @@ static inline void security_delete_hooks(struct security_hook_list *hooks,
 #endif /* CONFIG_SECURITY_WRITABLE_HOOKS */
 
 extern void __init capability_add_hooks(void);
-#ifdef CONFIG_SECURITY_YAMA
-extern void __init yama_add_hooks(void);
-#else
-static inline void __init yama_add_hooks(void) { }
-#endif
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/security/Kconfig b/security/Kconfig
index f2003bd03ef6..33c9ac3cb759 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -278,7 +278,7 @@ config DEFAULT_SECURITY
 
 config LSM_ORDER
 	string "Default initialization order of builtin LSMs"
-	default "loadpin,integrity"
+	default "yama,loadpin,integrity"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be link-order initialized
diff --git a/security/security.c b/security/security.c
index 9ffb76b7655b..3fba28de789b 100644
--- a/security/security.c
+++ b/security/security.c
@@ -245,7 +245,6 @@ int __init security_init(void)
 	 * Load minor LSMs, with the capability module always first.
 	 */
 	capability_add_hooks();
-	yama_add_hooks();
 
 	/* Load LSMs in specified order. */
 	prepare_lsm_order();
diff --git a/security/yama/yama_lsm.c b/security/yama/yama_lsm.c
index ffda91a4a1aa..f2b1f47f98e8 100644
--- a/security/yama/yama_lsm.c
+++ b/security/yama/yama_lsm.c
@@ -477,9 +477,14 @@ static void __init yama_init_sysctl(void)
 static inline void yama_init_sysctl(void) { }
 #endif /* CONFIG_SYSCTL */
 
-void __init yama_add_hooks(void)
+static int __init yama_init(void)
 {
 	pr_info("Yama: becoming mindful.\n");
 	security_add_hooks(yama_hooks, ARRAY_SIZE(yama_hooks), "yama");
 	yama_init_sysctl();
+	return 0;
 }
+
+DEFINE_LSM(yama)
+	.init = yama_init,
+END_LSM;
-- 
2.17.1
