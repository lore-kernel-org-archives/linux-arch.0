From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 09/11] signal: Reduce copy_siginfo to just a memcpy
Date: Thu, 11 Jan 2018 18:59:38 -0600
Message-ID: <20180112005940.23279-9-ebiederm@xmission.com>
References: <87373b6ghs.fsf@xmission.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:35564 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933784AbeALBBk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 11 Jan 2018 20:01:40 -0500
In-Reply-To: <87373b6ghs.fsf@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>

The savings for copying just part of struct siginfo appears to be in the
noise on modern machines.  So remove this ``optimization'' and simplify the code.

At the same time mark the second parameter as constant so there is no confusion
as to which direction the copy will go.

This ensures that a fully initialized siginfo that is sent ends up as
a fully initialized siginfo on the signal queue.  This full initialization
ensures even confused code won't copy unitialized data to userspace, and
it prepares for turning copy_siginfo_to_user into a simple copy_to_user.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 include/linux/signal.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/signal.h b/include/linux/signal.h
index 042968dd98f0..8037b503ce91 100644
--- a/include/linux/signal.h
+++ b/include/linux/signal.h
@@ -11,13 +11,9 @@ struct task_struct;
 /* for sysctl */
 extern int print_fatal_signals;
 
-static inline void copy_siginfo(struct siginfo *to, struct siginfo *from)
+static inline void copy_siginfo(struct siginfo *to, const struct siginfo *from)
 {
-	if (from->si_code < 0)
-		memcpy(to, from, sizeof(*to));
-	else
-		/* _sigchld is currently the largest know union member */
-		memcpy(to, from, __ARCH_SI_PREAMBLE_SIZE + sizeof(from->_sifields._sigchld));
+	memcpy(to, from, sizeof(*to));
 }
 
 int copy_siginfo_to_user(struct siginfo __user *to, const struct siginfo *from);
-- 
2.14.1
