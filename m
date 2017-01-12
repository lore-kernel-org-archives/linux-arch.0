Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:43250 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751213AbdALL1y (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Jan 2017 06:27:54 -0500
From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 04/10] arm64/sve: Factor out clearing of tasks' SVE regs
Date: Thu, 12 Jan 2017 11:26:03 +0000
Message-ID: <1484220369-23970-5-git-send-email-Dave.Martin@arm.com>
In-Reply-To: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
References: <1484220369-23970-1-git-send-email-Dave.Martin@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Alan Hayward <alan.hayward@arm.com>, Christoffer Dall <christoffer.dall@linaro.org>, linux-arch@vger.kernel.org, libc-alpha@sourceware.org, Florian Weimer <fweimer@redhat.com>, Joseph Myers <joseph@codesourcery.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Torvald Riegel <triegel@redhat.com>, gdb@sourceware.org, Yao Qi <qiyaoltc@gmail.com>
Message-ID: <20170112112603.7-6rQk4UNFdT9amLNQWaRgnxjAs1XBqpygoILCpINjo@z>

The patch factors out the code that clears a task's SVE regs on
exec(), so that we can reuse it in subsequent patches.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kernel/fpsimd.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ab2bb62..54d7ed0 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -260,6 +260,19 @@ void fpsimd_thread_switch(struct task_struct *next)
 	}
 }
 
+static void clear_sve_regs(struct task_struct *task)
+{
+	BUG_ON(task == current && preemptible());
+
+	BUG_ON((char *)__task_sve_state(task) < (char *)task);
+	BUG_ON(arch_task_struct_size <
+	       ((char *)__task_sve_state(task) - (char *)task));
+
+	memset(__task_sve_state(task), 0,
+	       arch_task_struct_size -
+	       ((char *)__task_sve_state(task) - (char *)task));
+}
+
 void fpsimd_flush_thread(void)
 {
 	if (!system_supports_fpsimd())
@@ -272,13 +285,7 @@ void fpsimd_flush_thread(void)
 	memset(&current->thread.fpsimd_state, 0, sizeof(struct fpsimd_state));
 
 	if (IS_ENABLED(CONFIG_ARM64_SVE) && (elf_hwcap & HWCAP_SVE)) {
-		BUG_ON((char *)__task_sve_state(current) < (char *)current);
-		BUG_ON(arch_task_struct_size <
-		       ((char *)__task_sve_state(current) - (char *)current));
-
-		memset(__task_sve_state(current), 0,
-		       arch_task_struct_size -
-		       ((char *)__task_sve_state(current) - (char *)current));
+		clear_sve_regs(current);
 
 		/*
 		 * User tasks must have a valid vector length set, but tasks
-- 
2.1.4

