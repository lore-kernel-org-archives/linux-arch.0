Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39837 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387823AbeITWOA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 18:14:00 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85-v6so1608825pge.6
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 09:29:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 16/26] LSM: Prepare for reorganizing "security=" logic
Date: Thu, 20 Sep 2018 09:23:28 -0700
Message-ID: <20180920162338.21060-17-keescook@chromium.org>
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180920162328.hLAlQ-BNx99GboNGFP-l0aPfOr-BZIBymgaofRXCmcI@z>

This moves the string handling for "security=" boot parameter into
a stored pointer instead of a string duplicate. This will allow
easier handling of the string when switching logic to use the coming
enable/disable infrastructure.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/security/security.c b/security/security.c
index 72d1ef2fc4cc..5cacbcefbc32 100644
--- a/security/security.c
+++ b/security/security.c
@@ -34,16 +34,12 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
-/* Maximum number of letters for an LSM name string */
-#define SECURITY_NAME_MAX	10
-
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
 char *lsm_names;
 /* Boot-time LSM user choice */
-static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
-	CONFIG_DEFAULT_SECURITY;
+static __initdata const char *chosen_major_lsm;
 
 static bool debug __initdata;
 #define init_debug(...)						\
@@ -90,7 +86,7 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 		return true;
 
 	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_lsm) != 0)
+	if (strcmp(lsm->name, chosen_major_lsm) != 0)
 		return false;
 
 	return true;
@@ -154,6 +150,9 @@ int __init security_init(void)
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
 
+	if (!chosen_major_lsm)
+		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+
 	/*
 	 * Load minor LSMs, with the capability module always first.
 	 */
@@ -173,12 +172,12 @@ int __init security_init(void)
 }
 
 /* Save user chosen LSM */
-static int __init choose_lsm(char *str)
+static int __init choose_major_lsm(char *str)
 {
-	strncpy(chosen_lsm, str, SECURITY_NAME_MAX);
+	chosen_major_lsm = str;
 	return 1;
 }
-__setup("security=", choose_lsm);
+__setup("security=", choose_major_lsm);
 
 /* Enable LSM order debugging. */
 static int __init enable_debug(char *str)
-- 
2.17.1
