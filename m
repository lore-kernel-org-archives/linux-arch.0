From: guoren@kernel.org
Subject: [PATCH 03/13] csky: Add cpu feature register hint for smp
Date: Sat,  1 Aug 2020 01:14:03 +0000
Message-ID: <1596244453-98575-4-git-send-email-guoren@kernel.org>
References: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1596244453-98575-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

CPU features registers are setup by customers' bootloader, but
Linux must help transfer them from the primary to secondary cores.
This patch add hint2 CPU feature register supported.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index b5c5bc3..1945fb2 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -156,6 +156,7 @@ void __init setup_smp(void)
 extern void _start_smp_secondary(void);
 
 volatile unsigned int secondary_hint;
+volatile unsigned int secondary_hint2;
 volatile unsigned int secondary_ccr;
 volatile unsigned int secondary_stack;
 
@@ -168,6 +169,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	secondary_stack =
 		(unsigned int) task_stack_page(tidle) + THREAD_SIZE - 8;
 	secondary_hint = mfcr("cr31");
+	secondary_hint2 = mfcr("cr<21, 1>");
 	secondary_ccr  = mfcr("cr18");
 	secondary_msa1 = read_mmu_msa1();
 
@@ -209,6 +211,7 @@ void csky_start_secondary(void)
 	unsigned int cpu = smp_processor_id();
 
 	mtcr("cr31", secondary_hint);
+	mtcr("cr<21, 1>", secondary_hint2);
 	mtcr("cr18", secondary_ccr);
 
 	mtcr("vbr", vec_base);
-- 
2.7.4
