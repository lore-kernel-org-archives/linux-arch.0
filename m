From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv8 02/10] ARM: dma-mapping: use pr_* instread of printk
Date: Tue, 10 Apr 2012 13:04:04 +0200
Message-ID: <1334055852-19500-3-git-send-email-m.szyprowski@samsung.com>
References: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Return-path: <owner-linux-mm@kvack.org>
In-reply-to: <1334055852-19500-1-git-send-email-m.szyprowski@samsung.com>
Sender: owner-linux-mm@kvack.org
To: linux-arm-kernel@lists.infradead.org, linaro-mm-sig@lists.linaro.org, linux-mm@kvack.org, linux-arch@vger.kernel.org, iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Chunsang Jeong <chunsang.jeong@linaro.org>, Krishna Reddy <vdumpa@nvidia.com>, KyongHo Cho <pullip.cho@samsung.com>, Andrzej Pietrasiewicz <andrzej.p@samsung.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Hiroshi Doyu <hdoyu@nvidia.com>, Subash Patel <subashrp@gmail.com>
List-Id: linux-arch.vger.kernel.org

Replace all calls to printk with pr_* functions family.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mm/dma-mapping.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index db23ae4..366f3a2 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -184,14 +184,14 @@ static int __init consistent_init(void)
 
 		pud = pud_alloc(&init_mm, pgd, base);
 		if (!pud) {
-			printk(KERN_ERR "%s: no pud tables\n", __func__);
+			pr_err("%s: no pud tables\n", __func__);
 			ret = -ENOMEM;
 			break;
 		}
 
 		pmd = pmd_alloc(&init_mm, pud, base);
 		if (!pmd) {
-			printk(KERN_ERR "%s: no pmd tables\n", __func__);
+			pr_err("%s: no pmd tables\n", __func__);
 			ret = -ENOMEM;
 			break;
 		}
@@ -199,7 +199,7 @@ static int __init consistent_init(void)
 
 		pte = pte_alloc_kernel(pmd, base);
 		if (!pte) {
-			printk(KERN_ERR "%s: no pte tables\n", __func__);
+			pr_err("%s: no pte tables\n", __func__);
 			ret = -ENOMEM;
 			break;
 		}
@@ -222,7 +222,7 @@ __dma_alloc_remap(struct page *page, size_t size, gfp_t gfp, pgprot_t prot,
 	int bit;
 
 	if (!consistent_pte) {
-		printk(KERN_ERR "%s: not initialised\n", __func__);
+		pr_err("%s: not initialised\n", __func__);
 		dump_stack();
 		return NULL;
 	}
@@ -281,14 +281,14 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 
 	c = arm_vmregion_find_remove(&consistent_head, (unsigned long)cpu_addr);
 	if (!c) {
-		printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
+		pr_err("%s: trying to free invalid coherent area: %p\n",
 		       __func__, cpu_addr);
 		dump_stack();
 		return;
 	}
 
 	if ((c->vm_end - c->vm_start) != size) {
-		printk(KERN_ERR "%s: freeing wrong coherent size (%ld != %d)\n",
+		pr_err("%s: freeing wrong coherent size (%ld != %d)\n",
 		       __func__, c->vm_end - c->vm_start, size);
 		dump_stack();
 		size = c->vm_end - c->vm_start;
@@ -310,8 +310,8 @@ static void __dma_free_remap(void *cpu_addr, size_t size)
 		}
 
 		if (pte_none(pte) || !pte_present(pte))
-			printk(KERN_CRIT "%s: bad page in kernel page table\n",
-			       __func__);
+			pr_crit("%s: bad page in kernel page table\n",
+				__func__);
 	} while (size -= PAGE_SIZE);
 
 	flush_tlb_kernel_range(c->vm_start, c->vm_end);
-- 
1.7.1.569.g6f426

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Fight unfair telecom internet charges in Canada: sign http://stopthemeter.ca/
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
