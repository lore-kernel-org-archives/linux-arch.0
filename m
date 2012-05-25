From: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
Subject: [PATCH 14/20] blackfin: Do not call
	try_to_freeze() in do_signal()
Date: Sat, 26 May 2012 00:04:30 +0200
Message-ID: <1337983476-22081-14-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <1337983476-22081-1-git-send-email-richard-/L3Ra7n9ekc@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-arch.vger.kernel.org

get_signal_to_deliver() already calls try_to_freeze(), there is no
need to call it directly.

Cc: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Signed-off-by: Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>
---
 arch/blackfin/kernel/signal.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/blackfin/kernel/signal.c b/arch/blackfin/kernel/signal.c
index e5bbc1a..cea3873 100644
--- a/arch/blackfin/kernel/signal.c
+++ b/arch/blackfin/kernel/signal.c
@@ -10,7 +10,6 @@
 #include <linux/tty.h>
 #include <linux/personality.h>
 #include <linux/binfmts.h>
-#include <linux/freezer.h>
 #include <linux/uaccess.h>
 #include <linux/tracehook.h>
 
@@ -285,9 +284,6 @@ asmlinkage void do_signal(struct pt_regs *regs)
 
 	current->thread.esp0 = (unsigned long)regs;
 
-	if (try_to_freeze())
-		goto no_signal;
-
 	if (test_thread_flag(TIF_RESTORE_SIGMASK))
 		oldset = &current->saved_sigmask;
 	else
@@ -311,7 +307,6 @@ asmlinkage void do_signal(struct pt_regs *regs)
 		return;
 	}
 
- no_signal:
 	/* Did we come from a system call? */
 	if (regs->orig_p0 >= 0)
 		/* Restart the system call - no handlers present */
-- 
1.7.7.3
