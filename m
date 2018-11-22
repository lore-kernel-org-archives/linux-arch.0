From: Guo Ren <ren_guo@c-sky.com>
Subject: [PATCH 1/2] csky: bugfix tlb_get_pgd error.
Date: Thu, 22 Nov 2018 13:44:39 +0800
Message-ID: <1542865479-5796-1-git-send-email-ren_guo@c-sky.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

It's wrong to mask/unmask highest bit in addr to translate the vaddr
to paddr. We should use PAGE_OFFSET and PHYS_OFFSET.

Wrong implement:
  return ((get_pgd()|(1<<31)) - PHYS_OFFSET) & ~1;

When PHYS_OFFSET=0xc0000000 and get_pgd() return 0xe0000000, it'll
return 0x60000000. It's wrong and should be 0xa0000000.

Now correct it to:
  return ((get_pgd() - PHYS_OFFSET) & ~1) + PAGE_OFFSET;

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
---
 arch/csky/include/asm/mmu_context.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/mmu_context.h b/arch/csky/include/asm/mmu_context.h
index c410aa4..b2905c0 100644
--- a/arch/csky/include/asm/mmu_context.h
+++ b/arch/csky/include/asm/mmu_context.h
@@ -16,7 +16,7 @@
 
 static inline void tlbmiss_handler_setup_pgd(unsigned long pgd, bool kernel)
 {
-	pgd &= ~(1<<31);
+	pgd -= PAGE_OFFSET;
 	pgd += PHYS_OFFSET;
 	pgd |= 1;
 	setup_pgd(pgd, kernel);
@@ -29,7 +29,7 @@ static inline void tlbmiss_handler_setup_pgd(unsigned long pgd, bool kernel)
 
 static inline unsigned long tlb_get_pgd(void)
 {
-	return ((get_pgd()|(1<<31)) - PHYS_OFFSET) & ~1;
+	return ((get_pgd() - PHYS_OFFSET) & ~1) + PAGE_OFFSET;
 }
 
 #define cpu_context(cpu, mm)	((mm)->context.asid[cpu])
-- 
2.7.4
