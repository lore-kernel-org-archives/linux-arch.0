From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/10] CRIS: Change DEFINE_PER_CPU of current_pgd to be non volatile.
Date: Wed, 24 Jun 2009 15:45:17 +0900
Message-ID: <1245825924-30412-4-git-send-email-tj@kernel.org>
References: <1245825924-30412-1-git-send-email-tj@kernel.org>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57012 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752905AbZFXGqE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Jun 2009 02:46:04 -0400
In-Reply-To: <1245825924-30412-1-git-send-email-tj@kernel.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, cl@linux-foundation.org, Jesper.Nilsson@axis.com, benh@kernel.crashing.org
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, Tejun Heo <tj@kernel.org>

From: Jesper Nilsson <jesper.nilsson@axis.com>

The DEFINE_PER_CPU of current_pgd was on CRIS defined using volatile,
which is not needed. Remove volatile.

Tested on an ARTPEC-3 (CRISv32) board.

tj: extern DEFINE_PER_CPU() replaced with DECLARE_PER_CPU()

[ Impact: code cleanup ]

Signed-off-by: Jesper Nilsson <jesper.nilsson@axis.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 arch/cris/include/asm/mmu_context.h |    3 ++-
 arch/cris/mm/fault.c                |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/cris/include/asm/mmu_context.h b/arch/cris/include/asm/mmu_context.h
index 72ba08d..1d45fd6 100644
--- a/arch/cris/include/asm/mmu_context.h
+++ b/arch/cris/include/asm/mmu_context.h
@@ -17,7 +17,8 @@ extern void switch_mm(struct mm_struct *prev, struct mm_struct *next,
  * registers like cr3 on the i386
  */
 
-extern volatile DEFINE_PER_CPU(pgd_t *,current_pgd); /* defined in arch/cris/mm/fault.c */
+/* defined in arch/cris/mm/fault.c */
+DECLARE_PER_CPU(pgd_t *, current_pgd);
 
 static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 {
diff --git a/arch/cris/mm/fault.c b/arch/cris/mm/fault.c
index f925115..4a7cdd9 100644
--- a/arch/cris/mm/fault.c
+++ b/arch/cris/mm/fault.c
@@ -29,7 +29,7 @@ extern void die_if_kernel(const char *, struct pt_regs *, long);
 
 /* current active page directory */
 
-volatile DEFINE_PER_CPU(pgd_t *,current_pgd);
+DEFINE_PER_CPU(pgd_t *, current_pgd);
 unsigned long cris_signal_return_page;
 
 /*
-- 
1.6.0.2
