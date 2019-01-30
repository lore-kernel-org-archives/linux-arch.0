From: guoren@kernel.org
Subject: [PATCH] csky: Fixup io-range page attribute for mmap("/dev/mem")
Date: Wed, 30 Jan 2019 20:33:49 +0800
Message-ID: <1548851629-9408-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, guoren@kernel.org, linux-arch@vger.kernel.org, xiaodong.fan@boyahualu.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

Some user space drivers need accessing IO address and IO remap need
SO(strong order) page-attribute to make IO operation correct. So we
need add SO-page-attr for all non-memory address.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Reported-by: Fan Xiaodong <xiaodong.fan@boyahualu.com>
---
 arch/csky/include/asm/pgtable.h |  5 +++++
 arch/csky/mm/ioremap.c          | 14 ++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index af7a7fa..dcea277 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -241,6 +241,11 @@ static inline pte_t pte_mkyoung(pte_t pte)
 
 #define pgd_index(address)	((address) >> PGDIR_SHIFT)
 
+#define __HAVE_PHYS_MEM_ACCESS_PROT
+struct file;
+extern pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+				     unsigned long size, pgprot_t vma_prot);
+
 /*
  * Macro to make mark a page protection value as "uncacheable".  Note
  * that "protection" is really a misnomer here as the protection value
diff --git a/arch/csky/mm/ioremap.c b/arch/csky/mm/ioremap.c
index cb7c03e..8473b6b 100644
--- a/arch/csky/mm/ioremap.c
+++ b/arch/csky/mm/ioremap.c
@@ -46,3 +46,17 @@ void iounmap(void __iomem *addr)
 	vunmap((void *)((unsigned long)addr & PAGE_MASK));
 }
 EXPORT_SYMBOL(iounmap);
+
+pgprot_t phys_mem_access_prot(struct file *file, unsigned long pfn,
+			      unsigned long size, pgprot_t vma_prot)
+{
+	if (!pfn_valid(pfn)) {
+		vma_prot.pgprot |= _PAGE_SO;
+		return pgprot_noncached(vma_prot);
+	} else if (file->f_flags & O_SYNC) {
+		return pgprot_noncached(vma_prot);
+	}
+
+	return vma_prot;
+}
+EXPORT_SYMBOL(phys_mem_access_prot);
-- 
2.7.4
