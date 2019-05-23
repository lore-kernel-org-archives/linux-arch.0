Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:59223 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfEWBLF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 May 2019 21:11:05 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 22 May 2019 19:39:02 -0500
Message-ID: <20190523003916.20726-13-ebiederm@xmission.com>
In-Reply-To: <20190523003916.20726-1-ebiederm@xmission.com>
References: <20190523003916.20726-1-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [REVIEW][PATCH 12/26] signal/um: Remove task parameter from send_sigtrap
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Linux Containers <containers@lists.linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, linux-arch@vger.kernel.org
Message-ID: <20190523003902.WFbxAbs3CeRwDpfkTDftMLLfoD6AVWVcebXYlwcGDcU@z>

The send_sigtrap function is always called with task == current.  Make
that explicit by removing the task parameter.

This also makes it clear that the uml send_sigtrap passes current
into force_sig_fault.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/um/kernel/ptrace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 5f47422401e1..1797dfe9ce6d 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -112,13 +112,13 @@ long arch_ptrace(struct task_struct *child, long request,
 	return ret;
 }
 
-static void send_sigtrap(struct task_struct *tsk, struct uml_pt_regs *regs,
-		  int error_code)
+static void send_sigtrap(struct uml_pt_regs *regs, int error_code)
 {
 	/* Send us the fake SIGTRAP */
 	force_sig_fault(SIGTRAP, TRAP_BRKPT,
 			/* User-mode eip? */
-			UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL, tsk);
+			UPT_IS_USER(regs) ? (void __user *) UPT_IP(regs) : NULL,
+			current);
 }
 
 /*
@@ -147,7 +147,7 @@ void syscall_trace_leave(struct pt_regs *regs)
 
 	/* Fake a debug trap */
 	if (ptraced & PT_DTRACE)
-		send_sigtrap(current, &regs->regs, 0);
+		send_sigtrap(&regs->regs, 0);
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
 		return;
-- 
2.21.0
