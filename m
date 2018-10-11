Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43235 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727233AbeJKHnl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Oct 2018 03:43:41 -0400
Received: by mail-pg1-f194.google.com with SMTP id 80-v6so3263761pgh.10
        for <linux-arch@vger.kernel.org>; Wed, 10 Oct 2018 17:19:06 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v5 12/30] LSM: Provide separate ordered initialization
Date: Wed, 10 Oct 2018 17:18:28 -0700
Message-ID: <20181011001846.30964-13-keescook@chromium.org>
In-Reply-To: <20181011001846.30964-1-keescook@chromium.org>
References: <20181011001846.30964-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Stephen Smalley <sds@tycho.nsa.gov>, Paul Moore <paul@paul-moore.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Jordan Glover <Golden_Miller83@protonmail.ch>, LSM <linux-security-module@vger.kernel.org>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181011001828.31wzfmP7VDbPYPpctWlgJ83XHiSWo3vylOfxhC0K3Pc@z>

This provides a place for ordered LSMs to be initialized, separate from
the "major" LSMs. This is mainly a copy/paste from major_lsm_init() to
ordered_lsm_init(), but it will change drastically in later patches.

What is not obvious in the patch is that this change moves the integrity
LSM from major_lsm_init() into ordered_lsm_init(), since it is not marked
with the LSM_FLAG_LEGACY_MAJOR. As it is the only LSM in the "ordered"
list, there is no reordering yet created.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/security/security.c b/security/security.c
index 2055af907eba..ebbbb672ced5 100644
--- a/security/security.c
+++ b/security/security.c
@@ -52,12 +52,30 @@ static __initdata bool debug;
 			pr_info(__VA_ARGS__);			\
 	} while (0)
 
+static void __init ordered_lsm_init(void)
+{
+	struct lsm_info *lsm;
+	int ret;
+
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) != 0)
+			continue;
+
+		init_debug("initializing %s\n", lsm->name);
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
+	}
+}
+
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
 	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+			continue;
+
 		init_debug("initializing %s\n", lsm->name);
 		ret = lsm->init();
 		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
@@ -87,6 +105,9 @@ int __init security_init(void)
 	yama_add_hooks();
 	loadpin_add_hooks();
 
+	/* Load LSMs in specified order. */
+	ordered_lsm_init();
+
 	/*
 	 * Load all the remaining security modules.
 	 */
-- 
2.17.1
