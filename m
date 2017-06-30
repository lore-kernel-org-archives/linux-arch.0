Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:35272 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdF3Mrl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jun 2017 08:47:41 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Fri, 30 Jun 2017 07:39:04 -0500
Message-ID: <20170630123906.8865-6-ebiederm@xmission.com>
In-Reply-To: <87efu22set.fsf@xmission.com>
References: <87efu22set.fsf@xmission.com>
Subject: [PATCH 6/8] signal/x86: Fix SIGSYS handling in copy_siginfo_to_user32
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andy Lutomirski <luto@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Oleg Nesterov <oleg@redhat.com>, Andrei Vagin <avagin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Greg KH <greg@kroah.com>, Andrey Vagin <avagin@openvz.org>, Serge Hallyn <serge@hallyn.com>, Pavel Emelyanov <xemul@virtuozzo.com>, Cyrill Gorcunov <gorcunov@openvz.org>, Peter Zijlstra <peterz@infradead.org>, Willy Tarreau <w@1wt.eu>, linux-arch@vger.kernel.org, linux-api@vger.kernel.org, Linux Containers <containers@lists.linux-foundation.org>, Michael Kerrisk <mtk.manpages@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Will Drewry <wad@chromium.org>, "H . Peter Anvin" <hpa@zytor.com>, Eric Paris <eparis@redhat.com>, James Morris <james.l.morris@oracle.com>
Message-ID: <20170630123904.pXVNtbk5axKvkXOaYcemBxkij2eVnnz92SvnmrhS_K4@z>

While examining the code I realized that we don't copy si_call_addr to
32bit callers.  Fix it.

It looks like no one has used this code path in the last 5 years.

Cc: Will Drewry <wad@chromium.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: Serge Hallyn <serge@hallyn.com>
Cc: James Morris <james.l.morris@oracle.com>
Fixes: a0727e8ce513 ("signal, x86: add SIGSYS info and make it synchronous.")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/kernel/signal_compat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 71beb28600d4..59e1029bb3d0 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -161,6 +161,7 @@ int __copy_siginfo_to_user32(compat_siginfo_t __user *to, const siginfo_t *from,
 				}
 				break;
 			case __SI_SYS >> 16:
+				put_user_ex(ptr_to_compat(from->si_call_addr), &to->si_call_addr);
 				put_user_ex(from->si_syscall, &to->si_syscall);
 				put_user_ex(from->si_arch, &to->si_arch);
 				break;
-- 
2.10.1
