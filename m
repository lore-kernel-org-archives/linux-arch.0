From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 04/15] signal/arm64: Factor set_thread_esr out of __do_user_fault
Date: Mon, 24 Sep 2018 11:10:04 +0200
Message-ID: <20180924091015.4458-4-ebiederm@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871s9j462u.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

This pepares for sending signals with something other than
arm64_force_sig_info.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/mm/fault.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index f42aff0e90ad..654a861c4bd0 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -297,9 +297,9 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
 	die_kernel_fault(msg, addr, esr, regs);
 }
 
-static void __do_user_fault(struct siginfo *info, unsigned int esr)
+static void set_thread_esr(unsigned long address, unsigned int esr)
 {
-	current->thread.fault_address = (unsigned long)info->si_addr;
+	current->thread.fault_address = address;
 
 	/*
 	 * If the faulting address is in the kernel, we must sanitize the ESR.
@@ -352,6 +352,11 @@ static void __do_user_fault(struct siginfo *info, unsigned int esr)
 	}
 
 	current->thread.fault_code = esr;
+}
+
+static void __do_user_fault(struct siginfo *info, unsigned int esr)
+{
+	set_thread_esr((unsigned long)info->si_addr, esr);
 	arm64_force_sig_info(info, esr_to_fault_info(esr)->name);
 }
 
-- 
2.17.1
