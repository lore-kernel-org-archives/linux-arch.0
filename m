From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 06/15] signal/arm64: For clarity separate the 3 signal sending cases in do_page_fault
Date: Mon, 24 Sep 2018 11:10:06 +0200
Message-ID: <20180924091015.4458-6-ebiederm@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871s9j462u.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

It gets easy to confuse what is going on when some code is shared and some not
so stop sharing the trivial bits of signal generation to make future updates
easier to understand.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/mm/fault.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 0ddc8c6ba53b..14d6ff895139 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -567,16 +567,16 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		return 0;
 	}
 
-	clear_siginfo(&si);
-	si.si_addr = (void __user *)addr;
-
 	if (fault & VM_FAULT_SIGBUS) {
 		/*
 		 * We had some memory, but were unable to successfully fix up
 		 * this page fault.
 		 */
+		clear_siginfo(&si);
 		si.si_signo	= SIGBUS;
 		si.si_code	= BUS_ADRERR;
+		si.si_addr = (void __user *)addr;
+		__do_user_fault(&si, esr);
 	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
 		unsigned int lsb;
 
@@ -584,20 +584,25 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		if (fault & VM_FAULT_HWPOISON_LARGE)
 			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 
+		clear_siginfo(&si);
 		si.si_signo	= SIGBUS;
 		si.si_code	= BUS_MCEERR_AR;
+		si.si_addr = (void __user *)addr;
 		si.si_addr_lsb	= lsb;
+		__do_user_fault(&si, esr);
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
 		 * map.
 		 */
+		clear_siginfo(&si);
 		si.si_signo	= SIGSEGV;
 		si.si_code	= fault == VM_FAULT_BADACCESS ?
 				  SEGV_ACCERR : SEGV_MAPERR;
+		si.si_addr = (void __user *)addr;
+		__do_user_fault(&si, esr);
 	}
 
-	__do_user_fault(&si, esr);
 	return 0;
 
 no_context:
-- 
2.17.1
