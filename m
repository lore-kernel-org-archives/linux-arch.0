From: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [REVIEW][PATCH 13/15] signal/arm64: In ptrace_hbptriggered name the signal description string
Date: Mon, 24 Sep 2018 11:10:13 +0200
Message-ID: <20180924091015.4458-13-ebiederm@xmission.com>
References: <871s9j462u.fsf@xmission.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871s9j462u.fsf@xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: linux-arch.vger.kernel.org

This will let the description be reused shortly.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 arch/arm64/kernel/ptrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 7ab75e78aa08..921267f59d0d 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -182,6 +182,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 				struct pt_regs *regs)
 {
 	struct arch_hw_breakpoint *bkpt = counter_arch_bp(bp);
+	const char *desc = "Hardware breakpoint trap (ptrace)";
 
 #ifdef CONFIG_COMPAT
 	if (is_compat_task()) {
@@ -206,7 +207,7 @@ static void ptrace_hbptriggered(struct perf_event *bp,
 #endif
 	arm64_force_sig_fault(SIGTRAP, TRAP_HWBKPT,
 			      (void __user *)(bkpt->trigger),
-			      "Hardware breakpoint trap (ptrace)");
+			      desc);
 }
 
 /*
-- 
2.17.1
