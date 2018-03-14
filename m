From: Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v1 2/4] ioremap: Invalidate TLB after huge mappings
Date: Wed, 14 Mar 2018 14:18:23 +0530
Message-ID: <1521017305-28518-3-git-send-email-cpandya@codeaurora.org>
References: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521017305-28518-1-git-send-email-cpandya@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de
Cc: mark.rutland@arm.com, ard.biesheuvel@linaro.org, marc.zyngier@arm.com, james.morse@arm.com, kristina.martsenko@arm.com, takahiro.akashi@linaro.org, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org, toshi.kani@hpe.com, Chintan Pandya <cpandya@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

If huge mappings are enabled, they can override
valid intermediate previous mappings. Some MMU
can speculatively pre-fetch these intermediate
entries even after unmap. That's because unmap
will clear only last level entries in page table
keeping intermediate (pud/pmd) entries still valid.

This can potentially lead to stale TLB entries
which needs invalidation after map.

Some more info: https://lkml.org/lkml/2017/12/23/3

There is one noted case for ARM64 where such stale
TLB entries causes 3rd level translation fault even
after correct (huge) mapping is available.

See the case below (reproduced locally with tests),

[17505.330123] Unable to handle kernel paging request at virtual address ffffff801ae00000
[17505.338100] pgd = ffffff800a761000
[17505.341566] [ffffff801ae00000] *pgd=000000017e1be003, *pud=000000017e1be003, *pmd=00e8000098000f05
[17505.350704] ------------[ cut here ]------------
[17505.355362] Kernel BUG at ffffff8008238c30 [verbose debug info unavailable]
[17505.362375] Internal error: Oops: 96000007 [#1] PREEMPT SMP
[17505.367996] Modules linked in:
[17505.371114] CPU: 6 PID: 488 Comm: chintan-ioremap Not tainted 4.9.81+ #160
[17505.378039] Hardware name: Qualcomm Technologies, Inc. SDM845 v1 MTP (DT)
[17505.384885] task: ffffffc0e3e61180 task.stack: ffffffc0e3e70000
[17505.390868] PC is at io_remap_test+0x2e0/0x444
[17505.395352] LR is at io_remap_test+0x2d0/0x444
[17505.399835] pc : [<ffffff8008238c30>] lr : [<ffffff8008238c20>] pstate: 60c00005
[17505.407282] sp : ffffffc0e3e73d70
[17505.410624] x29: ffffffc0e3e73d70 x28: ffffff801ae00008
[17505.416031] x27: ffffff801ae00010 x26: ffffff801ae00018
[17505.421436] x25: ffffff801ae00020 x24: ffffff801adfffe0
[17505.426840] x23: ffffff801adfffe8 x22: ffffff801adffff0
[17505.432244] x21: ffffff801adffff8 x20: ffffff801ae00000
[17505.437648] x19: 0000000000000005 x18: 0000000000000000
[17505.443052] x17: 00000000b3409452 x16: 00000000923da470
[17505.448456] x15: 0000000071c9763c x14: 00000000a15658fa
[17505.453860] x13: 000000005cae96bf x12: 00000000e6d5c44a
[17505.459264] x11: 0140000000000000 x10: ffffff80099a1000
[17505.464668] x9 : 0000000000000000 x8 : ffffffc0e3e73d68
[17505.470072] x7 : ffffff80099d3220 x6 : 0000000000000015
[17505.475476] x5 : 00000c00004ad32a x4 : 000000000000000a
[17505.480880] x3 : 000000000682aaab x2 : 0000001345c2ad2e
[17505.486284] x1 : 7d78d61de56639ba x0 : 0000000000000001

Hence, invalidate once we override pmd/pud with huge
mappings.

Signed-off-by: Chintan Pandya <cpandya@codeaurora.org>
---
 lib/ioremap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/ioremap.c b/lib/ioremap.c
index b808a39..c1e1341 100644
--- a/lib/ioremap.c
+++ b/lib/ioremap.c
@@ -13,6 +13,7 @@
 #include <linux/export.h>
 #include <asm/cacheflush.h>
 #include <asm/pgtable.h>
+#include <asm-generic/tlb.h>
 
 #ifdef CONFIG_HAVE_ARCH_HUGE_VMAP
 static int __read_mostly ioremap_p4d_capable;
@@ -92,8 +93,10 @@ static inline int ioremap_pmd_range(pud_t *pud, unsigned long addr,
 		if (ioremap_pmd_enabled() &&
 		    ((next - addr) == PMD_SIZE) &&
 		    IS_ALIGNED(phys_addr + addr, PMD_SIZE)) {
-			if (pmd_set_huge(pmd, phys_addr + addr, prot))
+			if (pmd_set_huge(pmd, phys_addr + addr, prot)) {
+				flush_tlb_pgtable(&init_mm, addr);
 				continue;
+			}
 		}
 
 		if (ioremap_pte_range(pmd, addr, next, phys_addr + addr, prot))
@@ -118,8 +121,10 @@ static inline int ioremap_pud_range(p4d_t *p4d, unsigned long addr,
 		if (ioremap_pud_enabled() &&
 		    ((next - addr) == PUD_SIZE) &&
 		    IS_ALIGNED(phys_addr + addr, PUD_SIZE)) {
-			if (pud_set_huge(pud, phys_addr + addr, prot))
+			if (pud_set_huge(pud, phys_addr + addr, prot)) {
+				flush_tlb_pgtable(&init_mm, addr);
 				continue;
+			}
 		}
 
 		if (ioremap_pmd_range(pud, addr, next, phys_addr + addr, prot))
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project
