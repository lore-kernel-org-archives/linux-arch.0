Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42112 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbeIYGaK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 25 Sep 2018 02:30:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id y4-v6so10117669pgp.9
        for <linux-arch@vger.kernel.org>; Mon, 24 Sep 2018 17:25:22 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v3 20/29] LSM: Refactor "security=" in terms of enable/disable
Date: Mon, 24 Sep 2018 17:18:23 -0700
Message-ID: <20180925001832.18322-21-keescook@chromium.org>
In-Reply-To: <20180925001832.18322-1-keescook@chromium.org>
References: <20180925001832.18322-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180925001823.WgwJQNFbMfJUvcVgB5pvP78OqJAHFvTaIDNI2ohPq64@z>

For what are marked as the Legacy Major LSMs, make them effectively
exclusive when selected on the "security=" boot parameter, to handle
the future case of when a previously major LSMs become non-exclusive
(e.g. when TOMOYO starts blob-sharing).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/security/security.c b/security/security.c
index e325fcc41f00..a98549b334af 100644
--- a/security/security.c
+++ b/security/security.c
@@ -103,14 +103,6 @@ static bool __init lsm_allowed(struct lsm_info *lsm)
 	if (!is_enabled(lsm))
 		return false;
 
-	/* Skip major-specific checks if not a major LSM. */
-	if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
-		return true;
-
-	/* Disabled if this LSM isn't the chosen one. */
-	if (strcmp(lsm->name, chosen_major_lsm) != 0)
-		return false;
-
 	return true;
 }
 
@@ -188,8 +180,24 @@ static void __init prepare_lsm_enable(void)
 	parse_lsm_enable(chosen_lsm_enable, set_enabled, true);
 	parse_lsm_enable(chosen_lsm_disable, set_enabled, false);
 
+	/* Process "security=", if given. */
 	if (!chosen_major_lsm)
 		chosen_major_lsm = CONFIG_DEFAULT_SECURITY;
+	if (chosen_major_lsm) {
+		struct lsm_info *lsm;
+
+		/*
+		 * To match the original "security=" behavior, this
+		 * explicitly does NOT fallback to another Legacy Major
+		 * if the selected one was separately disabled: disable
+		 * all non-matching Legacy Major LSMs.
+		 */
+		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			    strcmp(lsm->name, chosen_major_lsm) != 0)
+				set_enabled(lsm, false);
+		}
+	}
 }
 
 /**
-- 
2.17.1
