Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:56471 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728426AbeIXPNh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 11:13:37 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Sep 2018 11:10:08 +0200
Message-ID: <20180924091015.4458-8-ebiederm@xmission.com>
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Subject: [REVIEW][PATCH 08/15] signal/arm64: Only perform one esr_to_fault_info call in do_page_fault
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180924091008.m6pyie-Llm7g92t6m_m5tfKVp5Iu97qfMBpX5uk2rvY@z>

As this work is truly common between all of the signal sending cases
there is no need to repeat it between the different cases.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/arm64/mm/fault.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 7df3d8b561c2..ab85533e2255 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -424,6 +424,7 @@ static bool is_el0_instruction_abort(unsigned int esr)
 static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 				   struct pt_regs *regs)
 {
+	const struct fault_info *inf;
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct siginfo si;
@@ -562,6 +563,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		return 0;
 	}
 
+	inf = esr_to_fault_info(esr);
 	if (fault & VM_FAULT_SIGBUS) {
 		/*
 		 * We had some memory, but were unable to successfully fix up
@@ -572,7 +574,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_code	= BUS_ADRERR;
 		si.si_addr = (void __user *)addr;
 		set_thread_esr(addr, esr);
-		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
+		arm64_force_sig_info(&si, inf->name);
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
 
@@ -586,7 +588,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_addr = (void __user *)addr;
 		si.si_addr_lsb	= lsb;
 		set_thread_esr(addr, esr);
-		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
+		arm64_force_sig_info(&si, inf->name);
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
@@ -598,7 +600,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 				  SEGV_ACCERR : SEGV_MAPERR;
 		si.si_addr = (void __user *)addr;
 		set_thread_esr(addr, esr);
-		arm64_force_sig_info(&si, esr_to_fault_info(esr)->name);
+		arm64_force_sig_info(&si, inf->name);
 	}
 
 	return 0;
-- 
2.17.1
