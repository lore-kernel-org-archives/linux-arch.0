Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it1-f196.google.com ([209.85.166.196]:56131 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbeJBHfq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 2 Oct 2018 03:35:46 -0400
Received: by mail-it1-f196.google.com with SMTP id c23-v6so961101itd.5
        for <linux-arch@vger.kernel.org>; Mon, 01 Oct 2018 17:55:17 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH security-next v4 10/32] LSM: Don't ignore initialization failures
Date: Mon,  1 Oct 2018 17:54:43 -0700
Message-ID: <20181002005505.6112-11-keescook@chromium.org>
In-Reply-To: <20181002005505.6112-1-keescook@chromium.org>
References: <20181002005505.6112-1-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: James Morris <jmorris@namei.org>
Cc: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Paul Moore <paul@paul-moore.com>, Stephen Smalley <sds@tycho.nsa.gov>, "Schaufler, Casey" <casey.schaufler@intel.com>, LSM <linux-security-module@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20181002005443.AK3U7_wvIDS5Cw8ZSQyZgaWNsjpskuSJdHxn5mMZvdU@z>

LSM initialization failures have traditionally been ignored. We should
at least WARN when something goes wrong.

Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johansen@canonical.com>
---
 security/security.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/security.c b/security/security.c
index 395f804f6a91..2055af907eba 100644
--- a/security/security.c
+++ b/security/security.c
@@ -55,10 +55,12 @@ static __initdata bool debug;
 static void __init major_lsm_init(void)
 {
 	struct lsm_info *lsm;
+	int ret;
 
 	for (lsm = __start_lsm_info; lsm < __end_lsm_info; lsm++) {
 		init_debug("initializing %s\n", lsm->name);
-		lsm->init();
+		ret = lsm->init();
+		WARN(ret, "%s failed to initialize: %d\n", lsm->name, ret);
 	}
 }
 
-- 
2.17.1
