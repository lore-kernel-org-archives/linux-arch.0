From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 12/22] signal/parisc: Use force_sig_mceerr where appropriate
Date: Fri, 20 Apr 2018 09:38:01 -0500
Message-ID: <20180420143811.9994-12-ebiederm@xmission.com>
References: <87604mhrnb.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87604mhrnb.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, James Bottomley <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

In do_page_fault where an mceerr is generated stop and call force_sig_mceerr.
Keeping the mcerr handling logic out of the force_sig_info call below.

This ensures that only and always in the mcerr case is lsb interesting.

This ensures setting set si_lsb in the future won't accidentally
stomp another siginfo field in the non mcerr case.

Cc: James Bottomley <jejb@parisc-linux.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/parisc/mm/fault.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
index 657b35096bd8..51215b0048ef 100644
--- a/arch/parisc/mm/fault.c
+++ b/arch/parisc/mm/fault.c
@@ -354,7 +354,6 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 
 	if (user_mode(regs)) {
 		struct siginfo si;
-		unsigned int lsb = 0;
 
 		clear_siginfo(&si);
 		switch (code) {
@@ -391,26 +390,27 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
 
 #ifdef CONFIG_MEMORY_FAILURE
 		if (fault & (VM_FAULT_HWPOISON|VM_FAULT_HWPOISON_LARGE)) {
+			unsigned int lsb = 0;
 			printk(KERN_ERR
 	"MCE: Killing %s:%d due to hardware memory corruption fault at %08lx\n",
 			tsk->comm, tsk->pid, address);
-			si.si_signo = SIGBUS;
-			si.si_code = BUS_MCEERR_AR;
+			/*
+			 * Either small page or large page may be poisoned.
+			 * In other words, VM_FAULT_HWPOISON_LARGE and
+			 * VM_FAULT_HWPOISON are mutually exclusive.
+			 */
+			if (fault & VM_FAULT_HWPOISON_LARGE)
+				lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
+			else if (fault & VM_FAULT_HWPOISON)
+				lsb = PAGE_SHIFT;
+
+			force_sig_mceerr(BUS_MCEERR_AR, (void __user *) address,
+					 lsb, current);
+			return;
 		}
 #endif
 
-		/*
-		 * Either small page or large page may be poisoned.
-		 * In other words, VM_FAULT_HWPOISON_LARGE and
-		 * VM_FAULT_HWPOISON are mutually exclusive.
-		 */
-		if (fault & VM_FAULT_HWPOISON_LARGE)
-			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
-		else if (fault & VM_FAULT_HWPOISON)
-			lsb = PAGE_SHIFT;
-		else
-			show_signal_msg(regs, code, address, tsk, vma);
-		si.si_addr_lsb = lsb;
+		show_signal_msg(regs, code, address, tsk, vma);
 
 		si.si_errno = 0;
 		si.si_addr = (void __user *) address;
-- 
2.14.1
