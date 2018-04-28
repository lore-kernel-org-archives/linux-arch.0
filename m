From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 3/5] signal: Remove unncessary #ifdef SEGV_PKUERR in 32bit compat code
Date: Sat, 28 Apr 2018 09:07:00 -0500
Message-ID: <20180428140702.3925-3-ebiederm@xmission.com>
References: <87zi1nctut.fsf_-_@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87zi1nctut.fsf_-_@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-Arch <linux-arch@vger.kernel.org>
Cc: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, =?UTF-8?q?Martin=20P=C3=A4rtel?= <martin.partel@gmail.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

The only architecture that does not support SEGV_PKUERR is ia64 and
ia64 has not had 32bit support since some time in 2008.  Therefore
copy_siginfo_to_user32 and copy_siginfo_from_user32 do not need to
include support for a missing SEGV_PKUERR.

Compile test on ia64.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 kernel/signal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index b87a9c21f698..376b42f26e6d 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2888,12 +2888,9 @@ int __copy_siginfo_to_user32(struct compat_siginfo __user *to,
 			new.si_lower = ptr_to_compat(from->si_lower);
 			new.si_upper = ptr_to_compat(from->si_upper);
 		}
-#ifdef SEGV_PKUERR
 		if ((from->si_signo == SIGSEGV) &&
 		    (from->si_code == SEGV_PKUERR))
 			new.si_pkey = from->si_pkey;
-#endif
-
 		break;
 	case SIL_CHLD:
 		new.si_pid    = from->si_pid;
@@ -2968,10 +2965,8 @@ int copy_siginfo_from_user32(struct siginfo *to,
 			to->si_lower = compat_ptr(from.si_lower);
 			to->si_upper = compat_ptr(from.si_upper);
 		}
-#ifdef SEGV_PKUERR
 		if ((from.si_signo == SIGSEGV) && (from.si_code == SEGV_PKUERR))
 			to->si_pkey = from.si_pkey;
-#endif
 		break;
 	case SIL_CHLD:
 		to->si_pid    = from.si_pid;
-- 
2.14.1
