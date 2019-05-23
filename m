Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:59216 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfEWBLE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:11:04 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:14 -0500
Message-ID: <20190523003916.20726-25-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 24/26] signal: Generate the siginfo in force_sig
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003914.NR9pE9bHljtrXfWxF3JzLJmGk-ZHtETakuryj1ESjG4@z>

In preparation for removing the special case in force_sig_info for
only having a signal number generate an appropriate siginfo in
force_sig the last caller of force_sig_info that does not
pass a filled out siginfo.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 0da35880261e..d5f9ed5da9c5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1605,7 +1605,15 @@ EXPORT_SYMBOL(send_sig);
 
 void force_sig(int sig)
 {
-	force_sig_info(sig, SEND_SIG_PRIV, current);
+	struct kernel_siginfo info;
+
+	clear_siginfo(&info);
+	info.si_signo = sig;
+	info.si_errno = 0;
+	info.si_code = SI_KERNEL;
+	info.si_pid = 0;
+	info.si_uid = 0;
+	force_sig_info(info.si_signo, &info, current);
 }
 EXPORT_SYMBOL(force_sig);
 
-- 
2.21.0
