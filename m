Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out03.mta.xmission.com ([166.70.13.233]:45474 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeIRXcu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Sep 2018 19:32:50 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Tue, 18 Sep 2018 19:58:42 +0200
Message-ID: <20180918175850.4437-1-ebiederm@xmission.com>
In-Reply-To: <878t3yitze.fsf@xmission.com>
References: <878t3yitze.fsf@xmission.com>
Subject: [REVIEW][PATCH 1/9] signal/powerpc: Use force_sig_mceerr as appropriate
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, "Eric W. Biederman" <ebiederm@xmission.com>
Message-ID: <20180918175842.906byzZE6PUEcNXfZGs8A-BsQl9pVzhA5rVDlkU0OTo@z>

In do_sigbus isolate the mceerr signaling code and call
force_sig_mceerr instead of falling through to the force_sig_info that
works for all of the other signals.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/powerpc/mm/fault.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index d51cf5f4e45e..22d7f8748cd7 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -158,7 +158,6 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 		     vm_fault_t fault)
 {
 	siginfo_t info;
-	unsigned int lsb = 0;
 
 	if (!user_mode(regs))
 		return SIGBUS;
@@ -171,17 +170,22 @@ static int do_sigbus(struct pt_regs *regs, unsigned long address,
 	info.si_addr = (void __user *)address;
 #ifdef CONFIG_MEMORY_FAILURE
 	if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+		unsigned int lsb = 0; /* shutup gcc */
+
 		pr_err("MCE: Killing %s:%d due to hardware memory corruption fault at %lx\n",
 			current->comm, current->pid, address);
-		info.si_code = BUS_MCEERR_AR;
+
+		if (fault & VM_FAULT_HWPOISON_LARGE)
+			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+		if (fault & VM_FAULT_HWPOISON)
+			lsb = PAGE_SHIFT;
+
+		force_sig_mceerr(BUS_MCEERR_AR, (void __user *)address, lsb,
+				 current);
+		return 0;
 	}
 
-	if (fault & VM_FAULT_HWPOISON_LARGE)
-		lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
-	if (fault & VM_FAULT_HWPOISON)
-		lsb = PAGE_SHIFT;
 #endif
-	info.si_addr_lsb = lsb;
 	force_sig_info(SIGBUS, &info, current);
 	return 0;
 }
-- 
2.17.1
