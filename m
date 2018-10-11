From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v5 25/30] LSM: Add all exclusive LSMs to ordered initialization
Date: Wed, 10 Oct 2018 17:18:41 -0700
Message-ID: <20181011001846.30964-26-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This removes CONFIG_DEFAULT_SECURITY in favor of the explicit ordering
offered by CONFIG_LSM and adds all the exclusive LSMs to the ordered
LSM initialization. The old meaning of CONFIG_DEFAULT_SECURITY is now
captured by which exclusive LSM is listed first in the LSM order. All
LSMs not added to the ordered list are explicitly disabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/Kconfig    | 39 +--------------------------------------
 security/security.c | 35 ++++++++++-------------------------
 2 files changed, 11 insertions(+), 63 deletions(-)

diff --git a/security/Kconfig b/security/Kconfig
index 0aa82c1c928e..2f8dc1f59cae 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -239,46 +239,9 @@ source security/yama/Kconfig
 
 source security/integrity/Kconfig
 
-choice
-	prompt "Default security module"
-	default DEFAULT_SECURITY_SELINUX if SECURITY_SELINUX
-	default DEFAULT_SECURITY_SMACK if SECURITY_SMACK
-	default DEFAULT_SECURITY_TOMOYO if SECURITY_TOMOYO
-	default DEFAULT_SECURITY_APPARMOR if SECURITY_APPARMOR
-	default DEFAULT_SECURITY_DAC
-
-	help
-	  Select the security module that will be used by default if the
-	  kernel parameter security= is not specified.
-
-	config DEFAULT_SECURITY_SELINUX
-		bool "SELinux" if SECURITY_SELINUX=y
-
-	config DEFAULT_SECURITY_SMACK
-		bool "Simplified Mandatory Access Control" if SECURITY_SMACK=y
-
-	config DEFAULT_SECURITY_TOMOYO
-		bool "TOMOYO" if SECURITY_TOMOYO=y
-
-	config DEFAULT_SECURITY_APPARMOR
-		bool "AppArmor" if SECURITY_APPARMOR=y
-
-	config DEFAULT_SECURITY_DAC
-		bool "Unix Discretionary Access Controls"
-
-endchoice
-
-config DEFAULT_SECURITY
-	string
-	default "selinux" if DEFAULT_SECURITY_SELINUX
-	default "smack" if DEFAULT_SECURITY_SMACK
-	default "tomoyo" if DEFAULT_SECURITY_TOMOYO
-	default "apparmor" if DEFAULT_SECURITY_APPARMOR
-	default "" if DEFAULT_SECURITY_DAC
-
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "integrity"
+	default "integrity,selinux,smack,tomoyo,apparmor"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/security.c b/security/security.c
index 65f1fa733e4b..4f52bd06705f 100644
--- a/security/security.c
+++ b/security/security.c
@@ -175,8 +175,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
-			    strcmp(lsm->name, name) == 0) {
+			if (strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
 			}
@@ -185,6 +184,15 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		if (!found)
 			init_debug("%s ignored: %s\n", origin, name);
 	}
+
+	/* Disable all LSMs not in the ordered list. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (exists_ordered_lsm(lsm))
+			continue;
+		set_enabled(lsm, false);
+		init_debug("%s disabled: %s\n", origin, lsm->name);
+	}
+
 	kfree(sep);
 }
 
@@ -196,8 +204,6 @@ static void __init ordered_lsm_init(void)
 				GFP_KERNEL);
 
 	/* Process "security=", if given. */
-	if (!chosen_major_lsm)
-		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
 	if (chosen_major_lsm) {
 		struct lsm_info *major;
 
@@ -229,22 +235,6 @@ static void __init ordered_lsm_init(void)
 	kfree(ordered_lsms);
 }
 
-static void __init major_lsm_init(void)
-{
-	struct lsm_info *lsm;
-
-	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
-			continue;
-
-		/* Enable this LSM, if it is not already set. */
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
-
-		maybe_initialize_lsm(lsm);
-	}
-}
-
 /**
  * security_init - initializes the security framework
  *
@@ -271,11 +261,6 @@ int __init security_init(void)
 	/* Load LSMs in specified order. */
 	ordered_lsm_init();
 
-	/*
-	 * Load all the remaining security modules.
-	 */
-	major_lsm_init();
-
 	return 0;
 }
 
-- 
2.17.1
