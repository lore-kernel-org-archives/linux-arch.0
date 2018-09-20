Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40718 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732594AbeITWN4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 18:13:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17-v6so4590117plp.7
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 09:29:39 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 23/26] LSM: Introduce enum lsm_order
Date: Thu, 20 Sep 2018 09:23:35 -0700
Message-ID: <20180920162338.21060-24-keescook@chromium.org>
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180920162335.O_JIdM-noGV6HUC2Cztq9hi3wYmvgCPLoe6LQd3oDnE@z>

In preparation for distinguishing the "capability" LSM from other LSMs,
it must be ordered first. This introduces LSM_ORDER_MUTABLE for the
general LSMs, LSM_ORDER_FIRST for capabilities, and LSM_ORDER_LAST for
anything that must run last (e.g. Landlock may use this in the future).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h |  7 +++++++
 security/security.c       | 22 ++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index d75a42eb3ddd..bf29851baf47 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2041,8 +2041,15 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 
 #define LSM_FLAG_LEGACY_MAJOR	(1 << 0)
 
+enum lsm_order {
+	LSM_ORDER_FIRST = -1,	/* This is only for capabilities. */
+	LSM_ORDER_MUTABLE = 0,
+	LSM_ORDER_LAST,
+};
+
 struct lsm_info {
 	const char *name;	/* Populated automatically. */
+	enum lsm_order order;	/* Optional: default is LSM_ORDER_MUTABLE */
 	unsigned long flags;	/* Optional: flags describing LSM */
 	int *enabled;		/* Optional: NULL means enabled. */
 	int (*init)(void);
diff --git a/security/security.c b/security/security.c
index 3fba28de789b..d649e7dea4c4 100644
--- a/security/security.c
+++ b/security/security.c
@@ -62,6 +62,10 @@ static int lsm_enabled_true __initdata = 1;
 static int lsm_enabled_false __initdata = 0;
 static void __init set_enabled(struct lsm_info *lsm, bool enabled)
 {
+	/* First LSM cannot have enablement changed. */
+	if (lsm->order == LSM_ORDER_FIRST)
+		return;
+
 	if (!lsm->enabled) {
 		/*
 		 * If the LSM hasn't configured an enable flag, we
@@ -124,7 +128,8 @@ static void __init parse_lsm_order(const char *order, const char *origin)
 		bool found = false;
 
 		for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
+			if (lsm->order == LSM_ORDER_MUTABLE &&
+			    (lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0 &&
 			    strcmp(lsm->name, name) == 0) {
 				append_ordered_lsm(lsm, origin);
 				found = true;
@@ -142,6 +147,12 @@ static void __init prepare_lsm_order(void)
 {
 	struct lsm_info *lsm;
 
+	/* LSM_ORDER_FIRST is always first. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			append_ordered_lsm(lsm, "first");
+	}
+
 	/* Parse order from commandline, if present. */
 	if (chosen_lsm_order)
 		parse_lsm_order(chosen_lsm_order, "cmdline");
@@ -151,9 +162,16 @@ static void __init prepare_lsm_order(void)
 
 	/* Add any missing LSMs, in link order. */
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
-		if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
+		if (lsm->order == LSM_ORDER_MUTABLE &&
+		    (lsm->flags & LSM_FLAG_LEGACY_MAJOR) == 0)
 			append_ordered_lsm(lsm, "link-time");
 	}
+
+	/* LSM_ORDER_LAST is always last. */
+	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
+		if (lsm->order == LSM_ORDER_LAST)
+			append_ordered_lsm(lsm, "last");
+	}
 }
 
 /* Is an LSM allowed to be enabled? */
-- 
2.17.1
