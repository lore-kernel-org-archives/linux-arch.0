From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 21/22] signal/xtensa: Consistenly use SIGBUS in do_unaligned_user
Date: Fri, 20 Apr 2018 09:38:10 -0500
Message-ID: <20180420143811.9994-21-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org, stable@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

While working on changing this code to use force_sig_fault I
discovered that do_unaliged_user is sets si_signo to SIGBUS and passes
SIGSEGV to force_sig_info.  Which is just b0rked.

The code is reporting a SIGBUS error so replace the SIGSEGV with SIGBUS.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: linux-xtensa@linux-xtensa.org
Cc: stable@vger.kernel.org
Fixes: 5a0015d62668 ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 3")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/xtensa/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 51771929f341..90b509f65b6f 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -339,7 +339,7 @@ do_unaligned_user (struct pt_regs *regs)
 	info.si_errno = 0;
 	info.si_code = BUS_ADRALN;
 	info.si_addr = (void *) regs->excvaddr;
-	force_sig_info(SIGSEGV, &info, current);
+	force_sig_info(SIGBUS, &info, current);
 
 }
 #endif
-- 
2.14.1
