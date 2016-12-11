From: Yury Norov <ynorov@caviumnetworks.com>
Subject: [PATCH 3/3] mm: make pagoff_t type 64-bit
Date: Sun, 11 Dec 2016 18:26:42 +0530
Message-ID: <1481461003-14361-4-git-send-email-ynorov@caviumnetworks.com>
References: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481461003-14361-1-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Yury Norov <ynorov@caviumnetworks.com>, Arnd Bergmann <arnd@arndb.de>, "Dr. Philipp Tomsich" <philipp.tomsich@theobroma-systems.com>, Catalin Marinas <catalin.marinas@arm.com>, libc-alpha@sourceware.org, linux-arch@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, szabolcs.nagy@arm.com, heiko.carstens@de.ibm.com, cmetcalf@ezchip.com, "Joseph S. Myers" <joseph@codesourcery.com>, zhouchengming1@huawei.com, "Kapoor, Prasun" <Prasun.Kapoor@caviumnetworks.com>, Alexander Graf <agraf@suse.de>, geert@linux-m68k.org, kilobyte@angband.pl, manuel.montezelo@gmail.com, Andrew Pinski <pinskia@gmail.com>, linyongting@huawei.com, Alexey Klimov <klimov.linux@gmail.com>, broonie@kernel.org, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>, linux-arm-kerne
List-Id: linux-arch.vger.kernel.org

Also fix related interfaces

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 fs/btrfs/extent_io.c       | 2 +-
 fs/ext2/dir.c              | 4 ++--
 include/linux/mm.h         | 9 +++++----
 include/linux/radix-tree.h | 8 ++++----
 include/linux/types.h      | 2 +-
 lib/radix-tree.c           | 8 ++++----
 mm/debug.c                 | 2 +-
 mm/internal.h              | 2 +-
 mm/memory.c                | 4 ++--
 mm/mmap.c                  | 7 ++++---
 mm/readahead.c             | 4 ++--
 mm/util.c                  | 3 ++-
 12 files changed, 29 insertions(+), 26 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 8ed05d9..f4c9318 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3436,7 +3436,7 @@ static noinline_for_stack int __extent_writepage_io(struct inode *inode,
 		set_range_writeback(tree, cur, cur + iosize - 1);
 		if (!PageWriteback(page)) {
 			btrfs_err(BTRFS_I(inode)->root->fs_info,
-				   "page %lu not writeback, cur %llu end %llu",
+				   "page %llu not writeback, cur %llu end %llu",
 			       page->index, cur, end);
 		}
 
diff --git a/fs/ext2/dir.c b/fs/ext2/dir.c
index d9650c9..c01b76e 100644
--- a/fs/ext2/dir.c
+++ b/fs/ext2/dir.c
@@ -174,7 +174,7 @@ static bool ext2_check_page(struct page *page, int quiet)
 	error = "inode out of bounds";
 bad_entry:
 	if (!quiet)
-		ext2_error(sb, __func__, "bad entry in directory #%lu: : %s - "
+		ext2_error(sb, __func__, "bad entry in directory #%llu: : %s - "
 			"offset=%lu, inode=%lu, rec_len=%d, name_len=%d",
 			dir->i_ino, error, (page->index<<PAGE_SHIFT)+offs,
 			(unsigned long) le32_to_cpu(p->inode),
@@ -184,7 +184,7 @@ static bool ext2_check_page(struct page *page, int quiet)
 	if (!quiet) {
 		p = (ext2_dirent *)(kaddr + offs);
 		ext2_error(sb, "ext2_check_page",
-			"entry in directory #%lu spans the page boundary"
+			"entry in directory #%llu spans the page boundary"
 			"offset=%lu, inode=%lu",
 			dir->i_ino, (page->index<<PAGE_SHIFT)+offs,
 			(unsigned long) le32_to_cpu(p->inode));
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a92c8d7..33d9150 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2022,19 +2022,20 @@ extern int install_special_mapping(struct mm_struct *mm,
 				   unsigned long addr, unsigned long len,
 				   unsigned long flags, struct page **pages);
 
-extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
+extern unsigned long get_unmapped_area(struct file *, unsigned long,
+		unsigned long, pgoff_t, unsigned long);
 
 extern unsigned long mmap_region(struct file *file, unsigned long addr,
-	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff);
+	unsigned long len, vm_flags_t vm_flags, pgoff_t pgoff);
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
-	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate);
+	vm_flags_t vm_flags, pgoff_t pgoff, unsigned long *populate);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t);
 
 static inline unsigned long
 do_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
-	unsigned long pgoff, unsigned long *populate)
+	pgoff_t pgoff, unsigned long *populate)
 {
 	return do_mmap(file, addr, len, prot, flags, 0, pgoff, populate);
 }
diff --git a/include/linux/radix-tree.h b/include/linux/radix-tree.h
index af3581b..1781bb7 100644
--- a/include/linux/radix-tree.h
+++ b/include/linux/radix-tree.h
@@ -287,7 +287,7 @@ unsigned int radix_tree_gang_lookup(struct radix_tree_root *root,
 			void **results, unsigned long first_index,
 			unsigned int max_items);
 unsigned int radix_tree_gang_lookup_slot(struct radix_tree_root *root,
-			void ***results, unsigned long *indices,
+			void ***results, unsigned long long *indices,
 			unsigned long first_index, unsigned int max_items);
 int radix_tree_preload(gfp_t gfp_mask);
 int radix_tree_maybe_preload(gfp_t gfp_mask);
@@ -308,7 +308,7 @@ radix_tree_gang_lookup_tag_slot(struct radix_tree_root *root, void ***results,
 		unsigned long first_index, unsigned int max_items,
 		unsigned int tag);
 unsigned long radix_tree_range_tag_if_tagged(struct radix_tree_root *root,
-		unsigned long *first_indexp, unsigned long last_index,
+		unsigned long long *first_indexp, unsigned long last_index,
 		unsigned long nr_to_tag,
 		unsigned int fromtag, unsigned int totag);
 int radix_tree_tagged(struct radix_tree_root *root, unsigned int tag);
@@ -335,8 +335,8 @@ static inline void radix_tree_preload_end(void)
  * radix tree tag.
  */
 struct radix_tree_iter {
-	unsigned long	index;
-	unsigned long	next_index;
+	unsigned long long	index;
+	unsigned long long	next_index;
 	unsigned long	tags;
 #ifdef CONFIG_RADIX_TREE_MULTIORDER
 	unsigned int	shift;
diff --git a/include/linux/types.h b/include/linux/types.h
index baf7183..1e711c1 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -137,7 +137,7 @@ typedef unsigned long blkcnt_t;
 /*
  * The type of an index into the pagecache.
  */
-#define pgoff_t unsigned long
+#define pgoff_t unsigned long long
 
 /*
  * A dma_addr_t can hold any valid DMA address, i.e., any address returned
diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 0d1d23e..afb49381 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -97,7 +97,7 @@ static inline unsigned long get_slot_offset(struct radix_tree_node *parent,
 }
 
 static unsigned int radix_tree_descend(struct radix_tree_node *parent,
-			struct radix_tree_node **nodep, unsigned long index)
+			struct radix_tree_node **nodep, unsigned long long index)
 {
 	unsigned int offset = (index >> parent->shift) & RADIX_TREE_MAP_MASK;
 	void **entry = rcu_dereference_raw(parent->slots[offset]);
@@ -1040,14 +1040,14 @@ EXPORT_SYMBOL(radix_tree_next_chunk);
  * be prepared to handle that.
  */
 unsigned long radix_tree_range_tag_if_tagged(struct radix_tree_root *root,
-		unsigned long *first_indexp, unsigned long last_index,
+		unsigned long long *first_indexp, unsigned long last_index,
 		unsigned long nr_to_tag,
 		unsigned int iftag, unsigned int settag)
 {
 	struct radix_tree_node *parent, *node, *child;
 	unsigned long maxindex;
 	unsigned long tagged = 0;
-	unsigned long index = *first_indexp;
+	unsigned long long index = *first_indexp;
 
 	radix_tree_load_root(root, &child, &maxindex);
 	last_index = min(last_index, maxindex);
@@ -1195,7 +1195,7 @@ EXPORT_SYMBOL(radix_tree_gang_lookup);
  */
 unsigned int
 radix_tree_gang_lookup_slot(struct radix_tree_root *root,
-			void ***results, unsigned long *indices,
+			void ***results, unsigned long long *indices,
 			unsigned long first_index, unsigned int max_items)
 {
 	struct radix_tree_iter iter;
diff --git a/mm/debug.c b/mm/debug.c
index 9feb699..a568fc8 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -49,7 +49,7 @@ void __dump_page(struct page *page, const char *reason)
 	 */
 	int mapcount = PageSlab(page) ? 0 : page_mapcount(page);
 
-	pr_emerg("page:%p count:%d mapcount:%d mapping:%p index:%#lx",
+	pr_emerg("page:%p count:%d mapcount:%d mapping:%p index:%#llx",
 		  page, page_ref_count(page), mapcount,
 		  page->mapping, page_to_pgoff(page));
 	if (PageCompound(page))
diff --git a/mm/internal.h b/mm/internal.h
index 537ac99..8027eac 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -447,7 +447,7 @@ extern u32 hwpoison_filter_enable;
 
 extern unsigned long  __must_check vm_mmap_pgoff(struct file *, unsigned long,
         unsigned long, unsigned long,
-        unsigned long, unsigned long);
+        unsigned long, pgoff_t);
 
 extern void set_pageblock_order(void);
 unsigned long reclaim_clean_pages_from_list(struct zone *zone,
diff --git a/mm/memory.c b/mm/memory.c
index e18c57b..c05d534 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -688,7 +688,7 @@ static void print_bad_pte(struct vm_area_struct *vma, unsigned long addr,
 		 (long long)pte_val(pte), (long long)pmd_val(*pmd));
 	if (page)
 		dump_page(page, "bad pte");
-	pr_alert("addr:%p vm_flags:%08lx anon_vma:%p mapping:%p index:%lx\n",
+	pr_alert("addr:%p vm_flags:%08lx anon_vma:%p mapping:%p index:%llx\n",
 		 (void *)addr, vma->vm_flags, vma->anon_vma, mapping, index);
 	/*
 	 * Choose text because data symbols depend on CONFIG_KALLSYMS_ALL=y
@@ -3133,7 +3133,7 @@ static int do_fault_around(struct fault_env *fe, pgoff_t start_pgoff)
 	end_pgoff = start_pgoff -
 		((fe->address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1)) +
 		PTRS_PER_PTE - 1;
-	end_pgoff = min3(end_pgoff, vma_pages(fe->vma) + fe->vma->vm_pgoff - 1,
+	end_pgoff = min3(end_pgoff, (pgoff_t) vma_pages(fe->vma) + fe->vma->vm_pgoff - 1,
 			start_pgoff + nr_pages - 1);
 
 	if (pmd_none(*fe->pmd)) {
diff --git a/mm/mmap.c b/mm/mmap.c
index 6c6b95a..cf50232 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -9,6 +9,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/kernel.h>
+#include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
@@ -1304,7 +1305,7 @@ static inline int mlock_future_check(struct mm_struct *mm,
 unsigned long do_mmap(struct file *file, unsigned long addr,
 			unsigned long len, unsigned long prot,
 			unsigned long flags, vm_flags_t vm_flags,
-			unsigned long pgoff, unsigned long *populate)
+			pgoff_t pgoff, unsigned long *populate)
 {
 	struct mm_struct *mm = current->mm;
 	int pkey = 0;
@@ -1624,7 +1625,7 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
 }
 
 unsigned long mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff)
+		unsigned long len, vm_flags_t vm_flags, pgoff_t pgoff)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
@@ -2088,7 +2089,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 
 unsigned long
 get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
-		unsigned long pgoff, unsigned long flags)
+		pgoff_t pgoff, unsigned long flags)
 {
 	unsigned long (*get_area)(struct file *, unsigned long,
 				  unsigned long, unsigned long, unsigned long);
diff --git a/mm/readahead.c b/mm/readahead.c
index c8a955b..902bad8 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -332,8 +332,8 @@ static pgoff_t count_history_pages(struct address_space *mapping,
 static int try_context_readahead(struct address_space *mapping,
 				 struct file_ra_state *ra,
 				 pgoff_t offset,
-				 unsigned long req_size,
-				 unsigned long max)
+				 unsigned long long req_size,
+				 unsigned long long max)
 {
 	pgoff_t size;
 
diff --git a/mm/util.c b/mm/util.c
index 1a41553..51fae99 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -2,6 +2,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/compiler.h>
+#include <linux/types.h>
 #include <linux/export.h>
 #include <linux/err.h>
 #include <linux/sched.h>
@@ -292,7 +293,7 @@ EXPORT_SYMBOL_GPL(get_user_pages_fast);
 
 unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot,
-	unsigned long flag, unsigned long pgoff)
+	unsigned long flag, pgoff_t pgoff)
 {
 	unsigned long ret;
 	struct mm_struct *mm = current->mm;
-- 
2.7.4
