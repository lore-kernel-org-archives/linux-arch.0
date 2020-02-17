Return-Path: <SRS0=n14h=4F=kvack.org=owner-linux-mm@kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [PATCH 3/5] mm/vma: Replace all remaining open encodings with is_vm_hugetlb_page()
Date: Mon, 17 Feb 2020 10:33:51 +0530
Message-ID: <1581915833-21984-4-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
References: <1581915833-21984-1-git-send-email-anshuman.khandual@arm.com>
Sender: owner-linux-mm@kvack.org
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Paul Mackerras <paulus@ozlabs.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>, Alexander Viro <viro@zeniv.linux.org.uk>, Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200217050351.mzI4HQyHBnNKMK7YpBGI-efATmUv8LLzB5oFGTWX1ak@z>

This replaces all remaining open encodings with is_vm_hugetlb_page().

Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Will Deacon <will@kernel.org>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Nick Piggin <npiggin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: kvm-ppc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/powerpc/kvm/e500_mmu_host.c | 2 +-
 fs/binfmt_elf.c                  | 2 +-
 include/asm-generic/tlb.h        | 2 +-
 kernel/events/core.c             | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/e500_mmu_host.c b/arch/powerpc/kvm/e500_mmu_host.c
index 425d13806645..3922575a1c31 100644
--- a/arch/powerpc/kvm/e500_mmu_host.c
+++ b/arch/powerpc/kvm/e500_mmu_host.c
@@ -422,7 +422,7 @@ static inline int kvmppc_e500_shadow_map(struct kvmppc_vcpu_e500 *vcpu_e500,
 				break;
 			}
 		} else if (vma && hva >= vma->vm_start &&
-			   (vma->vm_flags & VM_HUGETLB)) {
+			   (is_vm_hugetlb_page(vma))) {
 			unsigned long psize = vma_kernel_pagesize(vma);
 
 			tsize = (gtlbe->mas1 & MAS1_TSIZE_MASK) >>
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index f4713ea76e82..6bc97ede10ba 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1317,7 +1317,7 @@ static unsigned long vma_dump_size(struct vm_area_struct *vma,
 	}
 
 	/* Hugetlb memory check */
-	if (vma->vm_flags & VM_HUGETLB) {
+	if (is_vm_hugetlb_page(vma)) {
 		if ((vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_SHARED))
 			goto whole;
 		if (!(vma->vm_flags & VM_SHARED) && FILTER(HUGETLB_PRIVATE))
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index f391f6b500b4..d42c236d4965 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -398,7 +398,7 @@ tlb_update_vma_flags(struct mmu_gather *tlb, struct vm_area_struct *vma)
 	 * We rely on tlb_end_vma() to issue a flush, such that when we reset
 	 * these values the batch is empty.
 	 */
-	tlb->vma_huge = !!(vma->vm_flags & VM_HUGETLB);
+	tlb->vma_huge = is_vm_hugetlb_page(vma);
 	tlb->vma_exec = !!(vma->vm_flags & VM_EXEC);
 }
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e453589da97c..eb0ee3c5f322 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -28,6 +28,7 @@
 #include <linux/export.h>
 #include <linux/vmalloc.h>
 #include <linux/hardirq.h>
+#include <linux/hugetlb_inline.h>
 #include <linux/rculist.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
@@ -7693,7 +7694,7 @@ static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
 		flags |= MAP_EXECUTABLE;
 	if (vma->vm_flags & VM_LOCKED)
 		flags |= MAP_LOCKED;
-	if (vma->vm_flags & VM_HUGETLB)
+	if (is_vm_hugetlb_page(vma))
 		flags |= MAP_HUGETLB;
 
 	if (file) {
-- 
2.20.1
