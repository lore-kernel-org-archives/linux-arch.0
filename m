Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34741 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730856AbeITWIB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Sep 2018 18:08:01 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so4623336pfi.1
        for <linux-arch@vger.kernel.org>; Thu, 20 Sep 2018 09:23:45 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v2 01/26] LSM: Correctly announce start of LSM initialization
Date: Thu, 20 Sep 2018 09:23:13 -0700
Message-ID: <20180920162338.21060-2-keescook@chromium.org>
In-Reply-To: <20180920162338.21060-1-keescook@chromium.org>
References: <20180920162338.21060-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20180920162313.9o9zZguhLdK5fXub2bJc9qyPZvnRXkZOscC4b3AscI4@z>

For a while now, the LSM core has said it was "initializED", rather than
"initializING". This adjust the report to be more accurate (i.e. before
this was reported before any LSMs had been initialized.)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/security.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 736e78da1ab9..4cbcf244a965 100644
--- a/security/security.c
+++ b/security/security.c
@@ -72,10 +72,11 @@ int __init security_init(void)
 	int i;
 	struct hlist_head *list = (struct hlist_head *) &security_hook_heads;
 
+	pr_info("Security Framework initializing\n");
+
 	for (i = 0; i < sizeof(security_hook_heads) / sizeof(struct hlist_head);
 	     i++)
 		INIT_HLIST_HEAD(&list[i]);
-	pr_info("Security Framework initialized\n");
 
 	/*
 	 * Load minor LSMs, with the capability module always first.
-- 
2.17.1
