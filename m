Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:39260 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbeIXPNn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Sep 2018 11:13:43 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Mon, 24 Sep 2018 11:10:09 +0200
Message-ID: <20180924091015.4458-9-ebiederm@xmission.com>
In-Reply-To: <871s9j462u.fsf@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Subject: [REVIEW][PATCH 09/15] signal/arm64: Only call set_thread_esr once in do_page_fault
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180924091009.h-_sBR5wLCwwsLR8_KPZhkKsXUPJAZ90iK_P12ozgCs@z>

This code is truly common between the signal sending cases so share it.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/arm64/mm/fault.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ab85533e2255..959c4a565c8e 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -564,6 +564,7 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 	}
 
 	inf = esr_to_fault_info(esr);
+	set_thread_esr(addr, esr);
 	if (fault & VM_FAULT_SIGBUS) {
 		/*
 		 * We had some memory, but were unable to successfully fix up
@@ -573,7 +574,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_signo	= SIGBUS;
 		si.si_code	= BUS_ADRERR;
 		si.si_addr = (void __user *)addr;
-		set_thread_esr(addr, esr);
 		arm64_force_sig_info(&si, inf->name);
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
@@ -587,7 +587,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_code	= BUS_MCEERR_AR;
 		si.si_addr = (void __user *)addr;
 		si.si_addr_lsb	= lsb;
-		set_thread_esr(addr, esr);
 		arm64_force_sig_info(&si, inf->name);
 	} else {
 		/*
@@ -599,7 +598,6 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		si.si_code	= fault == VM_FAULT_BADACCESS ?
 				  SEGV_ACCERR : SEGV_MAPERR;
 		si.si_addr = (void __user *)addr;
-		set_thread_esr(addr, esr);
 		arm64_force_sig_info(&si, inf->name);
 	}
 
-- 
2.17.1
