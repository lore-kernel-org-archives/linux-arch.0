Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:56609 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbeIXPRS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 11:17:18 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Sep 2018 11:10:14 +0200
Message-ID: <20180924091015.4458-14-ebiederm@xmission.com>
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Subject: [REVIEW][PATCH 14/15] signal/arm64: Add and use arm64_force_sig_ptrace_errno_trap
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180924091014.ymq2G6oPErCWEg8cNbJkoaGJlh7eB0Tyk2oMEXCzqDI@z>

Add arm64_force_sig_ptrace_errno_trap for consistency with
arm64_force_sig_fault and use it where appropriate.

This adds the show_signal logic to the force_sig_errno_trap case,
where it was apparently overlooked earlier.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/include/asm/traps.h | 1 +
 arch/arm64/kernel/ptrace.c     | 4 +++-
 arch/arm64/kernel/traps.c      | 7 +++++++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index d32b8bd440af..f9c1aa6167d2 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -39,6 +39,7 @@ void force_signal_inject(int signal, int code, unsigned long address);
 void arm64_notify_segfault(unsigned long addr);
 void arm64_force_sig_fault(int signo, int code, void __user *addr, const char *str);
 void arm64_force_sig_mceerr(int code, void __user *addr, short lsb, const char *str);
+void arm64_force_sig_ptrace_errno_trap(int errno, void __user *addr, const char *str);
 
 /*
  * Move regs->pc to next instruction and do necessary setup before it
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 921267f59d0d..1710a2d01669 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -202,7 +202,9 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 				break;
 			}
 		}
-		force_sig_ptrace_errno_trap(si_errno, (void __user *)bkpt->trigger);
+		arm64_force_sig_ptrace_errno_trap(si_errno,
+						  (void __user *)bkpt->trigger,
+						  desc);
 	}
 #endif
 	arm64_force_sig_fault(SIGTRAP, TRAP_HWBKPT,
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index de67818258cd..856b32aa03d8 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -262,6 +262,13 @@ void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
 	force_sig_mceerr(code, addr, lsb, current);
 }
 
+void arm64_force_sig_ptrace_errno_trap(int errno, void __user *addr,
+				       const char *str)
+{
+	arm64_show_signal(SIGTRAP, str);
+	force_sig_ptrace_errno_trap(errno, addr);
+}
+
 void arm64_notify_die(const char *str, struct pt_regs *regs,
 		      int signo, int sicode, void __user *addr,
 		      int err)
-- 
2.17.1
