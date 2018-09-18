Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out02.mta.xmission.com ([166.70.13.232]:53133 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbeIRFm3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 01:42:29 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 02:05:38 +0200
Message-ID: <20180918000546.12552-12-ebiederm@xmission.com>
In-Reply-To: <87y3bzk6yv.fsf@xmission.com>
References: <87y3bzk6yv.fsf@xmission.com>
Subject: [REVIEW][PATCH 12/20] signal/x86: Remove pkey parameter from bad_area_nosemaphore
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180918000538.Hsh5wCB2_ikNF--YqZKFtNHu48U3CT961cvSTnytoaE@z>

The function bad_area_nosemaphore always sets si_code to SEGV_MAPERR
and as such can never return a pkey parameter.  Therefore remove the
unusable pkey parameter from bad_area_nosemaphore.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/x86/mm/fault.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 4112b05d0dec..cfc88920716f 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -897,9 +897,9 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 
 static noinline void
 bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
-		     unsigned long address, u32 *pkey)
+		     unsigned long address)
 {
-	__bad_area_nosemaphore(regs, error_code, address, pkey, SEGV_MAPERR);
+	__bad_area_nosemaphore(regs, error_code, address, NULL, SEGV_MAPERR);
 }
 
 static void
@@ -1025,7 +1025,7 @@ mm_fault_error(struct pt_regs *regs, unsigned long error_code,
 			     VM_FAULT_HWPOISON_LARGE))
 			do_sigbus(regs, error_code, address, pkey, fault);
 		else if (fault & VM_FAULT_SIGSEGV)
-			bad_area_nosemaphore(regs, error_code, address, pkey);
+			bad_area_nosemaphore(regs, error_code, address);
 		else
 			BUG();
 	}
@@ -1255,7 +1255,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		 * Don't take the mm semaphore here. If we fixup a prefetch
 		 * fault we could otherwise deadlock:
 		 */
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+		bad_area_nosemaphore(regs, error_code, address);
 
 		return;
 	}
@@ -1268,7 +1268,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 		pgtable_bad(regs, error_code, address);
 
 	if (unlikely(smap_violation(error_code, regs))) {
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1277,7 +1277,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	 * in a region with pagefaults disabled then we must not take the fault
 	 */
 	if (unlikely(faulthandler_disabled() || !mm)) {
-		bad_area_nosemaphore(regs, error_code, address, NULL);
+		bad_area_nosemaphore(regs, error_code, address);
 		return;
 	}
 
@@ -1323,7 +1323,7 @@ __do_page_fault(struct pt_regs *regs, unsigned long error_code,
 	if (unlikely(!down_read_trylock(&mm->mmap_sem))) {
 		if (!(error_code & X86_PF_USER) &&
 		    !search_exception_tables(regs->ip)) {
-			bad_area_nosemaphore(regs, error_code, address, NULL);
+			bad_area_nosemaphore(regs, error_code, address);
 			return;
 		}
 retry:
-- 
2.17.1
