Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f194.google.com ([209.85.166.194]:35252 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbeJBHfj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 03:35:39 -0400
Received: by mail-it1-f194.google.com with SMTP id p64-v6so1096696itp.0
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 17:55:10 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 04/32] LSM: Remove initcall tracing
Date: Mon,  1 Oct 2018 17:54:37 -0700
Message-ID: <20181002005505.6112-5-keescook@chromium.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181002005437.NjKO9mB8H0Je5IozzKq--OhxGEN2ramJ7Bardi9MqSk@z>

This partially reverts commit 58eacfffc417 ("init, tracing: instrument
security and console initcall trace events") since security init calls
are about to no longer resemble regular init calls.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
---
 security/security.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/security/security.c b/security/security.c
index 892fe6b691cf..41a5da2c7faf 100644
--- a/security/security.c
+++ b/security/security.c
@@ -30,8 +30,6 @@
 #include <linux/string.h>
 #include <net/flow.h>
 
-#include <trace/events/initcall.h>
-
 #define MAX_LSM_EVM_XATTR	2
 
 /* Maximum number of letters for an LSM name string */
@@ -47,17 +45,13 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1] =
 
 static void __init do_security_initcalls(void)
 {
-	int ret;
 	initcall_t call;
 	initcall_entry_t *ce;
 
 	ce = __start_lsm_info;
-	trace_initcall_level("security");
 	while (ce < __end_lsm_info) {
 		call = initcall_from_entry(ce);
-		trace_initcall_start(call);
-		ret = call();
-		trace_initcall_finish(call, ret);
+		call();
 		ce++;
 	}
 }
-- 
2.17.1
