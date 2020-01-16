From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH v4 8/9] asm-generic/tlb: Rename HAVE_MMU_GATHER_NO_GATHER
Date: Thu, 16 Jan 2020 12:15:30 +0530
Message-ID: <20200116064531.483522-9-aneesh.kumar@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
Sender: owner-linux-mm@kvack.org
To: akpm@linux-foundation.org, peterz@infradead.org, will@kernel.org, mpe@ellerman.id.au
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Towards a more consistent naming scheme.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/Kconfig              |  2 +-
 arch/s390/Kconfig         |  2 +-
 include/asm-generic/tlb.h | 14 ++++++++++++--
 mm/mmu_gather.c           | 10 +++++-----
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index e8548211b6a9..c35668fbf4d4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -402,7 +402,7 @@ config MMU_GATHER_PAGE_SIZE
 config MMU_GATHER_NO_RANGE
 	bool
=20
-config HAVE_MMU_GATHER_NO_GATHER
+config MMU_GATHER_NO_GATHER
 	bool
=20
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index e2cde82a1a3c..de39c2e92435 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -163,7 +163,7 @@ config S390
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MEMBLOCK_PHYS_MAP
-	select HAVE_MMU_GATHER_NO_GATHER
+	select MMU_GATHER_NO_GATHER
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NOP_MCOUNT
 	select HAVE_OPROFILE
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 53befa5acb27..ca0fe75b5355 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -143,6 +143,16 @@
  *  MMU_GATHER_NO_RANGE
  *
  *  Use this if your architecture lacks an efficient flush_tlb_range().
+ *
+ *  MMU_GATHER_NO_GATHER
+ *
+ *  If the option is set the mmu_gather will not track individual pages =
for
+ *  delayed page free anymore. A platform that enables the option needs =
to
+ *  provide its own implementation of the __tlb_remove_page_size() funct=
ion to
+ *  free pages.
+ *
+ *  This is useful if your architecture already flushes TLB entries in t=
he
+ *  various ptep_get_and_clear() functions.
  */
=20
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
@@ -202,7 +212,7 @@ extern void tlb_remove_table(struct mmu_gather *tlb, =
void *table);
 #endif /* CONFIG_MMU_GATHER_RCU_TABLE_FREE */
=20
=20
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 /*
  * If we can't allocate a page to make a big batch of page pointers
  * to work on, then just handle a few from the on-stack structure.
@@ -277,7 +287,7 @@ struct mmu_gather {
=20
 	unsigned int		batch_count;
=20
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	struct mmu_gather_batch *active;
 	struct mmu_gather_batch	local;
 	struct page		*__pages[MMU_GATHER_BUNDLE];
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 297c70307367..a28c74328085 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -11,7 +11,7 @@
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
=20
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
=20
 static bool tlb_next_batch(struct mmu_gather *tlb)
 {
@@ -89,7 +89,7 @@ bool __tlb_remove_page_size(struct mmu_gather *tlb, str=
uct page *page, int page_
 	return false;
 }
=20
-#endif /* HAVE_MMU_GATHER_NO_GATHER */
+#endif /* MMU_GATHER_NO_GATHER */
=20
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
=20
@@ -180,7 +180,7 @@ static void tlb_flush_mmu_free(struct mmu_gather *tlb=
)
 #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
 	tlb_table_flush(tlb);
 #endif
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb_batch_pages_flush(tlb);
 #endif
 }
@@ -211,7 +211,7 @@ void tlb_gather_mmu(struct mmu_gather *tlb, struct mm=
_struct *mm,
 	/* Is it from 0 to ~0? */
 	tlb->fullmm     =3D !(start | (end+1));
=20
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb->need_flush_all =3D 0;
 	tlb->local.next =3D NULL;
 	tlb->local.nr   =3D 0;
@@ -271,7 +271,7 @@ void tlb_finish_mmu(struct mmu_gather *tlb,
=20
 	tlb_flush_mmu(tlb);
=20
-#ifndef CONFIG_HAVE_MMU_GATHER_NO_GATHER
+#ifndef CONFIG_MMU_GATHER_NO_GATHER
 	tlb_batch_list_free(tlb);
 #endif
 	dec_tlb_flush_pending(tlb->mm);
--=20
2.24.1
