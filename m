From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v3 7/9] asm-generic/tlb: Rename HAVE_MMU_GATHER_PAGE_SIZE
Date: Tue, 14 Jan 2020 15:31:43 +0530
Message-ID: <20200114100145.365527-8-aneesh.kumar@linux.ibm.com>
References: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20200114100145.365527-1-aneesh.kumar@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Towards a more consistent naming scheme.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/Kconfig              | 2 +-
 arch/powerpc/Kconfig      | 2 +-
 include/asm-generic/tlb.h | 9 ++++++---
 mm/mmu_gather.c           | 4 ++--
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 501d565690b5..e8548211b6a9 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -396,7 +396,7 @@ config HAVE_ARCH_JUMP_LABEL_RELATIVE
 config MMU_GATHER_RCU_TABLE_FREE
 	bool
=20
-config HAVE_MMU_GATHER_PAGE_SIZE
+config MMU_GATHER_PAGE_SIZE
 	bool
=20
 config MMU_GATHER_NO_RANGE
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 955759234776..cefacb9c8f48 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -223,7 +223,7 @@ config PPC
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select MMU_GATHER_RCU_TABLE_FREE
-	select HAVE_MMU_GATHER_PAGE_SIZE
+	select MMU_GATHER_PAGE_SIZE
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE		if PPC_BOOK3S_64 && CPU_LITTLE_ENDIAN
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 04a1b8f08eea..53befa5acb27 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -121,11 +121,14 @@
  *
  * Additionally there are a few opt-in features:
  *
- *  HAVE_MMU_GATHER_PAGE_SIZE
+ *  MMU_GATHER_PAGE_SIZE
  *
  *  This ensures we call tlb_flush() every time tlb_change_page_size() a=
ctually
  *  changes the size and provides mmu_gather::page_size to tlb_flush().
  *
+ *  This might be useful if your architecture has size specific TLB
+ *  invalidation instructions.
+ *
  *  MMU_GATHER_RCU_TABLE_FREE
  *
  *  This provides tlb_remove_table(), to be used instead of tlb_remove_p=
age()
@@ -279,7 +282,7 @@ struct mmu_gather {
 	struct mmu_gather_batch	local;
 	struct page		*__pages[MMU_GATHER_BUNDLE];
=20
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	unsigned int page_size;
 #endif
 #endif
@@ -435,7 +438,7 @@ static inline void tlb_remove_page(struct mmu_gather =
*tlb, struct page *page)
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	if (tlb->page_size && tlb->page_size !=3D page_size) {
 		if (!tlb->fullmm && !tlb->need_flush_all)
 			tlb_flush_mmu(tlb);
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 86bb2176e173..297c70307367 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -69,7 +69,7 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, str=
uct page *page, int page_
=20
 	VM_BUG_ON(!tlb->end);
=20
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	VM_WARN_ON(tlb->page_size !=3D page_size);
 #endif
=20
@@ -223,7 +223,7 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm=
_struct *mm,
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb->batch =3D NULL;
 #endif
-#ifdef CONFIG_HAVE_MMU_GATHER_PAGE_SIZE
+#ifdef CONFIG_MMU_GATHER_PAGE_SIZE
 	tlb->page_size =3D 0;
 #endif
=20
--=20
2.24.1
