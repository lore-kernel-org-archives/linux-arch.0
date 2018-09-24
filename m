From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 05/15] signal/arm64: Consolidate the two hwpoison cases in do_page_fault
Date: Mon, 24 Sep 2018 11:10:05 +0200
Message-ID: <20180924091015.4458-5-ebiederm@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871s9j462u.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

These two cases are practically the same and use siginfo differently
from the other signals sent from do_page_fault.  So consolidate them
to make future changes easier.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/mm/fault.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 654a861c4bd0..0ddc8c6ba53b 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -577,16 +577,16 @@ static int __kprobes do_page_fault(unsigned long addr, unsigned int esr,
 		 */
 		si.si_signo	= SIGBUS;
 		si.si_code	= BUS_ADRERR;
-	} else if (fault & VM_FAULT_HWPOISON_LARGE) {
-		unsigned int hindex = VM_FAULT_GET_HINDEX(fault);
+	} else if (fault & (VM_FAULT_HWPOISON_LARGE | VM_FAULT_HWPOISON)) {
+		unsigned int lsb;
+
+		lsb = PAGE_SHIFT;
+		if (fault & VM_FAULT_HWPOISON_LARGE)
+			lsb = hstate_index_to_shift(VM_FAULT_GET_HINDEX(fault));
 
 		si.si_signo	= SIGBUS;
 		si.si_code	= BUS_MCEERR_AR;
-		si.si_addr_lsb	= hstate_index_to_shift(hindex);
-	} else if (fault & VM_FAULT_HWPOISON) {
-		si.si_signo	= SIGBUS;
-		si.si_code	= BUS_MCEERR_AR;
-		si.si_addr_lsb	= PAGE_SHIFT;
+		si.si_addr_lsb	= lsb;
 	} else {
 		/*
 		 * Something tried to access memory that isn't in our memory
-- 
2.17.1
