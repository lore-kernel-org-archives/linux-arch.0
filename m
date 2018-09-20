Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35350 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732555AbeITWNz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 18:13:55 -0400
Received: by mail-pf1-f196.google.com with SMTP id p12-v6so4626701pfh.2
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 09:29:38 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 18/26] LSM: Build ordered list of ordered LSMs for init
Date: Thu, 20 Sep 2018 09:23:30 -0700
Message-ID: <20180920162338.21060-19-keescook@chromium.org>
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180920162330.9LqkjyPhN414ZAfIZ-7mVTrj4gZBGelvliwDK7jPkNk@z>

This constructs a list of ordered LSMs to initialize, using a hard-coded
list of only "integrity": minor LSMs continue to have direct hook calls,
and major LSMs continue to initialize separately.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 59 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/security/security.c b/security/security.c
index 25a019cc4a2b..2541a512a0f7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -34,6 +34,9 @@
 
 #define MAX_LSM_EVM_XATTR	2
 
+/* How many LSMs were built into the kernel? */
+#define LSM_COUNT (__end_lsm_info - __start_lsm_info)
+
 struct security_hook_heads security_hook_heads __lsm_ro_after_init;
 static ATOMIC_NOTIFIER_HEAD(lsm_notifier_chain);
 
@@ -41,6 +44,9 @@ char *lsm_names;
 /* Boot-time LSM user choice */
 static __initdata const char *chosen_major_lsm;
 
+/* Ordered list of LSMs to initialize. */
+static __initdata struct lsm_info **ordered_lsms;
+
 static bool debug __initdata;
 #define init_debug(...)						\
 	do {							\
@@ -74,6 +80,45 @@ static void __init set_enabled(struct lsm_info *lsm, bool enabled)
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
+		   (!lsm->enabled || *lsm->enabled) ? "en" : "dis");
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
 /* Is an LSM allowed to be enabled? */
 static bool __init lsm_allowed(struct lsm_info *lsm)
 {
@@ -104,14 +149,10 @@ static void __init maybe_initialize_lsm(struct lsm_info *lsm)
 
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
@@ -141,6 +182,8 @@ int __init security_init(void)
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
+	ordered_lsms = kcalloc(LSM_COUNT + 1, sizeof(*ordered_lsms),
+				GFP_KERNEL);
 
 	/* Process "security=", if given. */
 	if (!chosen_major_lsm)
@@ -169,6 +212,7 @@ int __init security_init(void)
 	loadpin_add_hooks();
 
 	/* Load LSMs in specified order. */
+	prepare_lsm_order();
 	ordered_lsm_init();
 
 	/*
@@ -176,6 +220,7 @@ int __init security_init(void)
 	 */
 	major_lsm_init();
 
+	kfree(ordered_lsms);
 	return 0;
 }
 
-- 
2.17.1
