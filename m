Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33692 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731507AbeITWIO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 18:08:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id y18-v6so1370137pge.0
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 09:23:59 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 15/26] LSM: Introduce lsm.enable= and lsm.disable=
Date: Thu, 20 Sep 2018 09:23:27 -0700
Message-ID: <20180920162338.21060-16-keescook@chromium.org>
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180920162327.UNtDEHYXXj3aGqMKYU85NzP4al7BQNyYr6EFObJYa_o@z>

This has identical functionality to the existing per-LSM enable handling,
but provides a centralized place to perform it. If multiple instances
of a parameter (either with the custom LSM-specific parameter or the
"lsm.{enable,disable}" parameter) for a specific LSM are on the boot
command line, the last one takes precedent.

Disabling an LSM means it will not be considered when performing
initializations. Enabling an LSM means either undoing a previous disabling
or a undoing a default-disabled CONFIG setting.

For example: "lsm.disable=apparmor apparmor.enabled=1" will leave
AppArmor enabled. "selinux.enabled=0 lsm.enable=selinux" will leave
SELinux enabled.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 47 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 85533d4e534a..72d1ef2fc4cc 100644
--- a/security/security.c
+++ b/security/security.c
@@ -53,10 +53,29 @@ static bool debug __initdata;
 	} while (0)
 
 /* Mark an LSM's enabled flag, if it exists. */
+static int lsm_enabled_true __initdata = 1;
+static int lsm_enabled_false __initdata = 0;
 static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 {
-	if (lsm->enabled)
+	if (!lsm->enabled) {
+		/*
+		 * If the LSM hasn't configured an enable flag, we
+		 * can use a hard-coded setting for storing the
+		 * state ourselves.
+		 */
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+		else
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_true) {
+		if (!enabled)
+			lsm->enabled = &lsm_enabled_false;
+	} else if (lsm->enabled == &lsm_enabled_false) {
+		if (enabled)
+			lsm->enabled = &lsm_enabled_true;
+	} else {
 		*lsm->enabled = enabled;
+	}
 }
 
 /* Is an LSM allowed to be enabled? */
@@ -169,6 +188,32 @@ static int __init enable_debug(char *str)
 }
 __setup("lsm.debug", enable_debug);
 
+/* Explicitly enable an LSM */
+static int __init enable_lsm(char *str)
+{
+	struct lsm_info *lsm;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (strcmp(str, lsm->name) == 0)
+			set_enabled(lsm, true);
+	}
+	return 1;
+}
+__setup("lsm.enable=", enable_lsm);
+
+/* Explicitly disable an LSM */
+static int __init disable_lsm(char *str)
+{
+	struct lsm_info *lsm;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (strcmp(str, lsm->name) == 0)
+			set_enabled(lsm, false);
+	}
+	return 1;
+}
+__setup("lsm.disable=", disable_lsm);
+
 static bool match_last_lsm(const char *list, const char *lsm)
 {
 	const char *last;
-- 
2.17.1
