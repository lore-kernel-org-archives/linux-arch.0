From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 15/20] frv: Do not call try_to_freeze() in do_signal()
Date: Sat, 26 May 2012 00:04:31 +0200
Message-ID: <1337983476-22081-15-git-send-email-richard@nod.at>
References: <1337983476-22081-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1337983476-22081-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Richard Weinberger <richard@nod.at>, David Howells <dhowells@redhat.com>
List-Id: linux-arch.vger.kernel.org

get_signal_to_deliver() already calls try_to_freeze(), there is no
need to call it directly.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/frv/kernel/signal.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/frv/kernel/signal.c b/arch/frv/kernel/signal.c
index 8cf5dca..c85c088 100644
--- a/arch/frv/kernel/signal.c
+++ b/arch/frv/kernel/signal.c
@@ -20,7 +20,6 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/personality.h>
-#include <linux/freezer.h>
 #include <linux/tracehook.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
@@ -489,9 +488,6 @@ static void do_signal(void)
 	if (!user_mode(__frame))
 		return;
 
-	if (try_to_freeze())
-		goto no_signal;
-
 	if (test_thread_flag(TIF_RESTORE_SIGMASK))
 		oldset = &current->saved_sigmask;
 	else
@@ -514,7 +510,6 @@ static void do_signal(void)
 		return;
 	}
 
-no_signal:
 	/* Did we come from a system call? */
 	if (__frame->syscallno != -1) {
 		/* Restart the system call - no handlers present */
-- 
1.7.7.3
