From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 24/32] LSM: Build ordered list of ordered LSMs for init
Date: Mon,  1 Oct 2018 17:54:57 -0700
Message-ID: <20181002005505.6112-25-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This constructs a list of ordered LSMs to initialize, using a hard-coded
list of only "integrity": minor LSMs continue to have direct hook calls,
and major LSMs continue to initialize separately.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 59 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/security/security.c b/security/security.c
index 40b9f508b856..8706b42b4d44 100644
--- a/security/security.c
+++ b/security/security.c
@@ -34,6 +34,9 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
+/* How many LSMs were built into the kernel? */
+#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
+
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
@@ -45,6 +48,9 @@ static __initdata const char *chosen_major_lsm;
 
 static __initconst const char * const builtin_lsm_enable = CONFIG_LSM_ENABLE;
 
+/* Ordered list of LSMs to initialize. */
+static __initdata struct lsm_info **ordered_lsms;
+
 static __initdata bool debug;
 #define init_debug(...)						\
 	do {							\
@@ -88,6 +94,45 @@ static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 	}
 }
 
+/* Is an LSM already listed in the ordered LSMs list? */
+static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+{
+	struct lsm_info **check;
+
+	for (check = ordered_lsms; *check; check++)
+		if (*check == lsm)
+			return true;
+
+	return false;
+}
+
+/* Append an LSM to the list of ordered LSMs to initialize. */
+static int last_lsm __initdata;
+static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+{
+	/* Ignore duplicate selections. */
+	if (exists_ordered_lsm(lsm))
+		return;
+
+	if (WARN(last_lsm == LSM_COUNT, "%s: out of LSM slots!?\n", from))
+		return;
+
+	ordered_lsms[last_lsm++] = lsm;
+	init_debug("%s ordering: %s (%sabled)\n", from, lsm->name,
+		   is_enabled(lsm) ? "en" : "dis");
+}
+
+/* Populate ordered LSMs list from hard-coded list of LSMs. */
+static void __init prepare_lsm_order(void)
+{
+	struct lsm_info *lsm;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (strcmp(lsm->name, "integrity") == 0)
+			append_ordered_lsm(lsm, "builtin");
+	}
+}
+
 /* Is an LSM allowed to be initialized? */
 static bool __init lsm_allowed(struct lsm_info *lsm)
 {
@@ -118,14 +163,10 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 
 static void __init ordered_lsm_init(void)
 {
-	struct lsm_info *lsm;
-
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
-			continue;
+	struct lsm_info **lsm;
 
-		maybe_initialize_lsm(lsm);
-	}
+	for (lsm = ordered_lsms; *lsm; lsm++)
+		maybe_initialize_lsm(*lsm);
 }
 
 static void __init major_lsm_init(void)
@@ -207,6 +248,8 @@ int __init security_init(void)
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
+	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
+				GFP_KERNEL);
 
 	/* Figure out which LSMs are enabled and disabled. */
 	prepare_lsm_enable();
@@ -219,6 +262,7 @@ int __init security_init(void)
 	loadpin_add_hooks();
 
 	/* Load LSMs in specified order. */
+	prepare_lsm_order();
 	ordered_lsm_init();
 
 	/*
@@ -226,6 +270,7 @@ int __init security_init(void)
 	 */
 	major_lsm_init();
 
+	kfree(ordered_lsms);
 	return 0;
 }
 
-- 
2.17.1
