From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 05/22] signal: Clear si_sys_private before copying siginfo to userspace
Date: Mon, 15 Jan 2018 18:39:52 -0600
Message-ID: <20180116004009.31036-5-ebiederm@xmission.com>
References: <87k1wimybi.fsf_-_@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:37971 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeAPAli (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 19:41:38 -0500
In-Reply-To: <87k1wimybi.fsf_-_@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

In preparation for unconditionally copying the whole of siginfo
to userspace clear si_sys_private.  So this kernel internal
value is guaranteed not to make it to userspace.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index b9e5d825ee46..18aa55c1bb4f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -643,6 +643,9 @@ int dequeue_signal(struct task_struct *tsk, sigset_t *mask, siginfo_t *info)
 		spin_unlock(&tsk->sighand->siglock);
 		posixtimer_rearm(info);
 		spin_lock(&tsk->sighand->siglock);
+
+		/* Don't expose the si_sys_private value to userspace */
+		info->si_sys_private = 0;
 	}
 #endif
 	return signr;
-- 
2.14.1
