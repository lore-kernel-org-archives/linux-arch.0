From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH 07/12] x86/mm: simplify init_trampoline() and surrounding logic
Date: Tue, 12 May 2020 21:44:17 +0300
Message-ID: <20200512184422.12418-8-rppt@kernel.org>
References: <20200512184422.12418-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200512184422.12418-1-rppt@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-snps-arc/>
List-Post: <mailto:linux-snps-arc@lists.infradead.org>
List-Help: <mailto:linux-snps-arc-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-snps-arc>,
 <mailto:linux-snps-arc-request@lists.infradead.org?subject=subscribe>
Sender: "linux-snps-arc" <linux-snps-arc-bounces@lists.infradead.org>
Errors-To: linux-snps-arc-bounces+gla-linux-snps-arc=m.gmane-mx.org@lists.infradead.org
To: linux-kernel@vger.kernel.org
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, Brian Cain <bcain@codeaurora.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Mike Rapoport <rppt@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-parisc@vger.kernel.orgM
List-Id: linux-arch.vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

There are three cases for the trampoline initialization:
* 32-bit does nothing
* 64-bit with kaslr disabled simply copies a PGD entry from the direct map
  to the trampoline PGD
* 64-bit with kaslr enabled maps the real mode trampoline at PUD level

These cases are currently differentiated by a bunch of ifdefs inside
asm/include/pgtable.h and the case of 64-bits with kaslr on uses
pgd_index() helper.

Replacing the ifdefs with a static function in arch/x86/mm/init.c gives
clearer code and allows moving pgd_index() to the generic implementation in
include/linux/pgtable.h

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/x86/include/asm/kaslr.h   |  2 ++
 arch/x86/include/asm/pgtable.h | 15 +--------------
 arch/x86/include/asm/setup.h   |  9 +++++++++
 arch/x86/mm/init.c             | 22 ++++++++++++++++++++++
 arch/x86/mm/kaslr.c            | 33 +--------------------------------
 5 files changed, 35 insertions(+), 46 deletions(-)

diff --git a/arch/x86/include/asm/kaslr.h b/arch/x86/include/asm/kaslr.h
index db7ba2feb947..0648190467ba 100644
--- a/arch/x86/include/asm/kaslr.h
+++ b/arch/x86/include/asm/kaslr.h
@@ -6,8 +6,10 @@ unsigned long kaslr_get_random_long(const char *purpose);
 
 #ifdef CONFIG_RANDOMIZE_MEMORY
 void kernel_randomize_memory(void);
+void init_trampoline_kaslr(void);
 #else
 static inline void kernel_randomize_memory(void) { }
+static inline void init_trampoline_kaslr(void) {}
 #endif /* CONFIG_RANDOMIZE_MEMORY */
 
 #endif
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index d24f8e1f7250..6366136b0e46 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1070,27 +1070,14 @@ void init_mem_mapping(void);
 void early_alloc_pgt_buf(void);
 extern void memblock_find_dma_reserve(void);
 
+
 #ifdef CONFIG_X86_64
-/* Realmode trampoline initialization. */
 extern pgd_t trampoline_pgd_entry;
-static inline void __meminit init_trampoline_default(void)
-{
-	/* Default trampoline pgd value */
-	trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
-}
 
 void __init poking_init(void);
 
 unsigned long init_memory_mapping(unsigned long start,
 				  unsigned long end, pgprot_t prot);
-
-# ifdef CONFIG_RANDOMIZE_MEMORY
-void __meminit init_trampoline(void);
-# else
-#  define init_trampoline init_trampoline_default
-# endif
-#else
-static inline void init_trampoline(void) { }
 #endif
 
 /* local pte updates need not use xchg for locking */
diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index ed8ec011a9fd..d95cacf210bb 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -78,6 +78,15 @@ static inline bool kaslr_enabled(void)
 	return !!(boot_params.hdr.loadflags & KASLR_FLAG);
 }
 
+/*
+ * Apply no randomization if KASLR was disabled at boot or if KASAN
+ * is enabled. KASAN shadow mappings rely on regions being PGD aligned.
+ */
+static inline bool kaslr_memory_enabled(void)
+{
+	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
+}
+
 static inline unsigned long kaslr_offset(void)
 {
 	return (unsigned long)&_text - __START_KERNEL;
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 235dd0e35741..e225ebb25197 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -682,6 +682,28 @@ static void __init memory_map_bottom_up(unsigned long map_start,
 	}
 }
 
+/*
+ * The real mode trampoline, which is required for bootstrapping CPUs
+ * occupies only a small area under the low 1MB.  See reserve_real_mode()
+ * for details.
+ *
+ * If KASLR is disabled the first PGD entry of the direct mapping is copied
+ * to map the real mode trampoline.
+ *
+ * If KASLR is enabled, copy only the PUD which covers the low 1MB
+ * area. This limits the randomization granularity to 1GB for both 4-level
+ * and 5-level paging.
+ */
+static void __init init_trampoline(void)
+{
+#ifdef CONFIG_X86_64
+	if (!kaslr_memory_enabled())
+		trampoline_pgd_entry = init_top_pgt[pgd_index(__PAGE_OFFSET)];
+	else
+		init_trampoline_kaslr();
+#endif
+}
+
 void __init init_mem_mapping(void)
 {
 	unsigned long end;
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index faf02e1e1517..fb620fd9dae9 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -61,15 +61,6 @@ static inline unsigned long get_padding(struct kaslr_memory_region *region)
 	return (region->size_tb << TB_SHIFT);
 }
 
-/*
- * Apply no randomization if KASLR was disabled at boot or if KASAN
- * is enabled. KASAN shadow mappings rely on regions being PGD aligned.
- */
-static inline bool kaslr_memory_enabled(void)
-{
-	return kaslr_enabled() && !IS_ENABLED(CONFIG_KASAN);
-}
-
 /* Initialize base and padding for each memory region randomized with KASLR */
 void __init kernel_randomize_memory(void)
 {
@@ -148,7 +139,7 @@ void __init kernel_randomize_memory(void)
 	}
 }
 
-static void __meminit init_trampoline_pud(void)
+void __meminit init_trampoline_kaslr(void)
 {
 	pud_t *pud_page_tramp, *pud, *pud_tramp;
 	p4d_t *p4d_page_tramp, *p4d, *p4d_tramp;
@@ -189,25 +180,3 @@ static void __meminit init_trampoline_pud(void)
 			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
 	}
 }
-
-/*
- * The real mode trampoline, which is required for bootstrapping CPUs
- * occupies only a small area under the low 1MB.  See reserve_real_mode()
- * for details.
- *
- * If KASLR is disabled the first PGD entry of the direct mapping is copied
- * to map the real mode trampoline.
- *
- * If KASLR is enabled, copy only the PUD which covers the low 1MB
- * area. This limits the randomization granularity to 1GB for both 4-level
- * and 5-level paging.
- */
-void __meminit init_trampoline(void)
-{
-	if (!kaslr_memory_enabled()) {
-		init_trampoline_default();
-		return;
-	}
-
-	init_trampoline_pud();
-}
-- 
2.26.1
