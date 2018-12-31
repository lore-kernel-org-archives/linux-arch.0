From: guoren@kernel.org
Subject: [PATCH 04/14] csky: remove syscall_exit_work
Date: Mon, 31 Dec 2018 23:32:56 +0800
Message-ID: <1546270384-4590-4-git-send-email-guoren@kernel.org>
References: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546270384-4590-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: guoren@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, oleg@redhat.com, linux-arch@vger.kernel.org, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Remove syscall_exit_work and union all to ret_from_exception.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/kernel/entry.S | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 79f92b8..2b4a851 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -183,18 +183,10 @@ ENTRY(csky_systemcall)
 #endif
 	stw	a0, (sp, LSAVE_A0)	/* Save return value */
 
-	movi	a0, 1			/* leave system call */
-	mov	a1, sp			/* sp = pt_regs pointer */
-	jbsr	syscall_trace
-
-syscall_exit_work:
-	ld	syscallid, (sp, LSAVE_PSR)
-	btsti	syscallid, 31
-	bt	2f
-
-	jmpi	resume_userspace
-
-2:      RESTORE_ALL
+	movi    a0, 1                   /* leave system call */
+	mov     a1, sp                  /* right now, sp --> pt_regs */
+	jbsr    syscall_trace
+	br	ret_from_exception
 
 ENTRY(ret_from_kernel_thread)
 	jbsr	schedule_tail
-- 
2.7.4
