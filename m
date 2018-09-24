Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:37390 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726241AbeIXPRS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 11:17:18 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Sep 2018 11:10:12 +0200
Message-ID: <20180924091015.4458-12-ebiederm@xmission.com>
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Subject: [REVIEW][PATCH 12/15] signal/arm64: Remove arm64_force_sig_info
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180924091012.HJadYVZnFxq_VzWOgG6i7KRSm_TXzqgP5vTANWdlt54@z>

The function has no more callers so remove it.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/include/asm/traps.h | 1 -
 arch/arm64/kernel/traps.c      | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/arch/arm64/include/asm/traps.h b/arch/arm64/include/asm/traps.h
index 193f0b0e8ee3..d32b8bd440af 100644
--- a/arch/arm64/include/asm/traps.h
+++ b/arch/arm64/include/asm/traps.h
@@ -39,7 +39,6 @@ void force_signal_inject(int signal, int code, unsigned long address);
 void arm64_notify_segfault(unsigned long addr);
 void arm64_force_sig_fault(int signo, int code, void __user *addr, const char *str);
 void arm64_force_sig_mceerr(int code, void __user *addr, short lsb, const char *str);
-void arm64_force_sig_info(struct siginfo *info, const char *str);
 
 /*
  * Move regs->pc to next instruction and do necessary setup before it
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index baa96dfffeec..de67818258cd 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -262,12 +262,6 @@ void arm64_force_sig_mceerr(int code, void __user *addr, short lsb,
 	force_sig_mceerr(code, addr, lsb, current);
 }
 
-void arm64_force_sig_info(struct siginfo *info, const char *str)
-{
-	arm64_show_signal(info->si_signo, str);
-	force_sig_info(info->si_signo, info, current);
-}
-
 void arm64_notify_die(const char *str, struct pt_regs *regs,
 		      int signo, int sicode, void __user *addr,
 		      int err)
-- 
2.17.1
