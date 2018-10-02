From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 21/32] LSM: Finalize centralized LSM enabling logic
Date: Mon,  1 Oct 2018 17:54:54 -0700
Message-ID: <20181002005505.6112-22-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Prior to this patch, default "enable" behavior was unchanged: SELinux
and AppArmor were controlled separately from the centralized control
defined by CONFIG_LSM_ENABLE and "lsm.enable=...". This changes the
logic to give all control over to the central logic.

Instead of allowing SELinux and AppArmor to override the central LSM
enabling logic, by having separate CONFIG and boot parameters, this
forces all "enable" variables to disabled, then enables any listed in
the CONFIG_LSM_ENABLE and "lsm.enable=..." settings, and finally disables
any listed in "lsm.disable=...".

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../admin-guide/kernel-parameters.txt         |  6 ++--
 include/linux/lsm_hooks.h                     |  2 +-
 security/security.c                           | 32 +++++++------------
 3 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 67c90985d2b8..f646cfab5613 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2279,14 +2279,12 @@
 	lsm.disable=lsm1,...,lsmN
 			[SECURITY] Comma-separated list of LSMs to disable
 			at boot time. This overrides "lsm.enable=",
-			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and boot
-			parameters.
+			CONFIG_LSM_ENABLE.
 
 	lsm.enable=lsm1,...,lsmN
 			[SECURITY] Comma-separated list of LSMs to enable
 			at boot time. This overrides any omissions from
-			CONFIG_LSM_ENABLE, and any per-LSM CONFIGs and
-			boot parameters.
+			CONFIG_LSM_ENABLE.
 
 	machvec=	[IA-64] Force the use of a particular machine-vector
 			(machvec) in a generic kernel.
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index fd85637a1931..b026ea93ff01 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2044,7 +2044,7 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 struct lsm_info {
 	const char *name;	/* Required. */
 	unsigned long flags;	/* Optional: flags describing LSM */
-	int *enabled;		/* Optional: NULL checks CONFIG_LSM_ENABLE */
+	int *enabled;		/* Optional: set based on CONFIG_LSM_ENABLE */
 	int (*init)(void);	/* Required. */
 };
 
diff --git a/security/security.c b/security/security.c
index d7132c181ea6..40b9f508b856 100644
--- a/security/security.c
+++ b/security/security.c
@@ -63,27 +63,19 @@ static bool __init is_enabled(struct lsm_info *lsm)
 /* Mark an LSM's enabled flag, if it exists. */
 static int lsm_enabled_true __initdata = 1;
 static int lsm_enabled_false __initdata = 0;
-
-static void __init default_enabled(struct lsm_info *lsm, bool enabled)
+static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 {
-	/* If storage location already set, skip this one. */
-	if (lsm->enabled)
-		return;
-
 	/*
 	 * When an LSM hasn't configured an enable variable, we can use
 	 * a hard-coded location for storing the default enabled state.
 	 */
-	if (enabled)
-		lsm->enabled = &lsm_enabled_true;
-	else
-		lsm->enabled = &lsm_enabled_false;
-}
-
-static void __init set_enabled(struct lsm_info *lsm, bool enabled)
-{
-	if (WARN_ON(!lsm->enabled))
+	if (!lsm->enabled) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+		else
+			lsm->enabled = &lsm_enabled_false;
 		return;
+	}
 
 	if (lsm->enabled == &lsm_enabled_true) {
 		if (!enabled)
@@ -149,7 +141,6 @@ static void __init major_lsm_init(void)
 }
 
 static void __init parse_lsm_enable(const char *str,
-				    void (*set)(struct lsm_info *, bool),
 				    bool enabled)
 {
 	char *sep, *name, *next;
@@ -165,7 +156,7 @@ static void __init parse_lsm_enable(const char *str,
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 			if (strcmp(name, "all") == 0 ||
 			    strcmp(name, lsm->name) == 0)
-				set(lsm, enabled);
+				set_enabled(lsm, enabled);
 		}
 	}
 	kfree(sep);
@@ -174,11 +165,12 @@ static void __init parse_lsm_enable(const char *str,
 static void __init prepare_lsm_enable(void)
 {
 	/* Prepare defaults. */
-	parse_lsm_enable(builtin_lsm_enable, default_enabled, true);
+	parse_lsm_enable("all", false);
+	parse_lsm_enable(builtin_lsm_enable, true);
 
 	/* Process "lsm.enable=" and "lsm.disable=", if given. */
-	parse_lsm_enable(chosen_lsm_enable, set_enabled, true);
-	parse_lsm_enable(chosen_lsm_disable, set_enabled, false);
+	parse_lsm_enable(chosen_lsm_enable, true);
+	parse_lsm_enable(chosen_lsm_disable, false);
 
 	/* Process "security=", if given. */
 	if (!chosen_major_lsm)
-- 
2.17.1
