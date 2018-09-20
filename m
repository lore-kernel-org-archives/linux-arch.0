Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46045 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387845AbeITWIH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 18:08:07 -0400
Received: by mail-pf1-f194.google.com with SMTP id i26-v6so4600791pfo.12
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 09:23:52 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 08/26] LSM: Record LSM name in struct lsm_info
Date: Thu, 20 Sep 2018 09:23:20 -0700
Message-ID: <20180920162338.21060-9-keescook@chromium.org>
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180920162320.eTGx1lbYuwvsAl8zzVtS5PiFduVScCFSWrsOP8W6meU@z>

In preparation for making LSM selections outside of the LSMs, include
the name of LSMs in struct lsm_info.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/lsm_hooks.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index 02ec717189f9..543636f18152 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -2040,16 +2040,20 @@ extern void security_add_hooks(struct security_hook_list *hooks, int count,
 				char *lsm);
 
 struct lsm_info {
+	const char *name;	/* Populated automatically. */
 	int (*init)(void);
 };
 
 extern struct lsm_info __start_lsm_info[], __end_lsm_info[];
 
 #define DEFINE_LSM(lsm)							\
+	static const char __lsm_name_##lsm[] __initconst		\
+		__aligned(1) = #lsm;					\
 	static struct lsm_info __lsm_##lsm				\
 		__used __section(.lsm_info.init)			\
 		__aligned(sizeof(unsigned long))			\
 		= {							\
+			.name = __lsm_name_##lsm,			\
 
 #define END_LSM	  }
 
-- 
2.17.1
