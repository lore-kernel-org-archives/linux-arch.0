From: Dave Hansen <dave@sr71.net>
Subject: [PATCH 21/37] mm: add gup flag to indicate "foreign" mm access
Date: Mon, 16 Nov 2015 19:35:40 -0800
Message-ID: <20151117033540.5CB9C67C@viggo.jf.intel.com>
References: <20151117033511.BFFA1440@viggo.jf.intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:44490 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753150AbbKQDfl (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 16 Nov 2015 22:35:41 -0500
In-Reply-To: <20151117033511.BFFA1440@viggo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Dave Hansen <dave@sr71.net>, dave.hansen@linux.intel.com, linux-arch@vger.kernel.org


From: Dave Hansen <dave.hansen@linux.intel.com>

We try to enforce protection keys in software the same way that we
do in hardware.  (See long example below).

But, we only want to do this when accessing our *own* process's
memory.  If GDB set PKRU[6].AD=1 (disable access to PKEY 6), then
tried to PTRACE_POKE a target process which just happened to have
some mprotect_pkey(pkey=6) memory, we do *not* want to deny the
debugger access to that memory.  PKRU is fundamentally a
thread-local structure and we do not want to enforce it on access
to _another_ thread's data.

This gets especially tricky when we have workqueues or other
delayed-work mechanisms that might run in a random process's context.
We can check that we only enforce pkeys when operating on our *own* mm,
but delayed work gets performed when a random user context is active.
We might end up with a situation where a delayed-work gup fails when
running randomly under its "own" task but succeeds when running under
another process.  We want to avoid that.

To avoid that, we add a GUP flag: FOLL_FOREIGN and a fault flag:
FAULT_FLAG_FOREIGN.  They indicate that we are walking an mm
which is not guranteed to be the same as current->mm and should
not be subject to protection key enforcement.

Thanks to Jerome Glisse for pointing out this scenario.

*** Why do we enforce protection keys in software?? ***

Imagine that we disabled access to the memory pointer to by 'buf'.
The, we implemented sys_write() like this:

	sys_read(fd, buf, len...)
	{
		struct page *page = follow_page(buf);
		void *buf_mapped = kmap(page);
		memcpy(buf_mapped, fd_data, len);
		...
	}

This writes to 'buf' via a *kernel* mapping, without a protection
key.  While this implementation does the same thing:

	sys_read(fd, buf, len...)
	{
		copy_to_user(buf, fd_data, len);
		...
	}

but would hit a protection key fault because the userspace 'buf'
mapping has a protection key set.

To provide consistency, and to make key-protected memory work
as much like mprotect()ed memory as possible, we try to enforce
the same protections as the hardware would when the *kernel* walks
the page tables (and other mm structures).

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-arch@vger.kernel.org
---

 b/arch/powerpc/include/asm/mmu_context.h   |    3 ++-
 b/arch/s390/include/asm/mmu_context.h      |    3 ++-
 b/arch/unicore32/include/asm/mmu_context.h |    3 ++-
 b/arch/x86/include/asm/mmu_context.h       |    5 +++--
 b/drivers/iommu/amd_iommu_v2.c             |    8 +++++---
 b/include/asm-generic/mm_hooks.h           |    3 ++-
 b/include/linux/mm.h                       |    2 ++
 b/mm/gup.c                                 |   13 +++++++++----
 b/mm/ksm.c                                 |   10 ++++++++--
 b/mm/memory.c                              |    3 ++-
 10 files changed, 37 insertions(+), 16 deletions(-)

diff -puN arch/powerpc/include/asm/mmu_context.h~pkeys-12-gup-fault-foreign-flag arch/powerpc/include/asm/mmu_context.h
--- a/arch/powerpc/include/asm/mmu_context.h~pkeys-12-gup-fault-foreign-flag	2015-11-16 12:35:44.769599914 -0800
+++ b/arch/powerpc/include/asm/mmu_context.h	2015-11-16 12:35:44.788600776 -0800
@@ -148,7 +148,8 @@ static inline void arch_bprm_mm_init(str
 {
 }
 
-static inline bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write)
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool foreign)
 {
 	/* by default, allow everything */
 	return true;
diff -puN arch/s390/include/asm/mmu_context.h~pkeys-12-gup-fault-foreign-flag arch/s390/include/asm/mmu_context.h
--- a/arch/s390/include/asm/mmu_context.h~pkeys-12-gup-fault-foreign-flag	2015-11-16 12:35:44.771600005 -0800
+++ b/arch/s390/include/asm/mmu_context.h	2015-11-16 12:35:44.789600822 -0800
@@ -130,7 +130,8 @@ static inline void arch_bprm_mm_init(str
 {
 }
 
-static inline bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write)
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool foreign)
 {
 	/* by default, allow everything */
 	return true;
diff -puN arch/unicore32/include/asm/mmu_context.h~pkeys-12-gup-fault-foreign-flag arch/unicore32/include/asm/mmu_context.h
--- a/arch/unicore32/include/asm/mmu_context.h~pkeys-12-gup-fault-foreign-flag	2015-11-16 12:35:44.773600095 -0800
+++ b/arch/unicore32/include/asm/mmu_context.h	2015-11-16 12:35:44.789600822 -0800
@@ -97,7 +97,8 @@ static inline void arch_bprm_mm_init(str
 {
 }
 
-static inline bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write)
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool foreign)
 {
 	/* by default, allow everything */
 	return true;
diff -puN arch/x86/include/asm/mmu_context.h~pkeys-12-gup-fault-foreign-flag arch/x86/include/asm/mmu_context.h
--- a/arch/x86/include/asm/mmu_context.h~pkeys-12-gup-fault-foreign-flag	2015-11-16 12:35:44.774600141 -0800
+++ b/arch/x86/include/asm/mmu_context.h	2015-11-16 12:35:44.789600822 -0800
@@ -299,10 +299,11 @@ static inline bool vma_is_foreign(struct
 	return false;
 }
 
-static inline bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write)
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool foreign)
 {
 	/* allow access if the VMA is not one from this process */
-	if (vma_is_foreign(vma))
+	if (foreign || vma_is_foreign(vma))
 		return true;
 	return __pkru_allows_pkey(vma_pkey(vma), write);
 }
diff -puN drivers/iommu/amd_iommu_v2.c~pkeys-12-gup-fault-foreign-flag drivers/iommu/amd_iommu_v2.c
--- a/drivers/iommu/amd_iommu_v2.c~pkeys-12-gup-fault-foreign-flag	2015-11-16 12:35:44.776600231 -0800
+++ b/drivers/iommu/amd_iommu_v2.c	2015-11-16 12:35:44.790600867 -0800
@@ -500,9 +500,11 @@ static void do_fault(struct work_struct
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	u64 address;
-	int ret, write;
+	int ret, flags;
 
-	write = !!(fault->flags & PPR_FAULT_WRITE);
+	if (fault->flags & PPR_FAULT_WRITE)
+		flags = FAULT_FLAG_WRITE;
+	flags |= FAULT_FLAG_FOREIGN;
 
 	mm = fault->state->mm;
 	address = fault->address;
@@ -523,7 +525,7 @@ static void do_fault(struct work_struct
 		goto out;
 	}
 
-	ret = handle_mm_fault(mm, vma, address, write);
+	ret = handle_mm_fault(mm, vma, address, flags);
 	if (ret & VM_FAULT_ERROR) {
 		/* failed to service fault */
 		up_read(&mm->mmap_sem);
diff -puN include/asm-generic/mm_hooks.h~pkeys-12-gup-fault-foreign-flag include/asm-generic/mm_hooks.h
--- a/include/asm-generic/mm_hooks.h~pkeys-12-gup-fault-foreign-flag	2015-11-16 12:35:44.778600322 -0800
+++ b/include/asm-generic/mm_hooks.h	2015-11-16 12:35:44.790600867 -0800
@@ -26,7 +26,8 @@ static inline void arch_bprm_mm_init(str
 {
 }
 
-static inline bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write)
+static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool foreign)
 {
 	/* by default, allow everything */
 	return true;
diff -puN include/linux/mm.h~pkeys-12-gup-fault-foreign-flag include/linux/mm.h
--- a/include/linux/mm.h~pkeys-12-gup-fault-foreign-flag	2015-11-16 12:35:44.779600368 -0800
+++ b/include/linux/mm.h	2015-11-16 12:35:44.791600912 -0800
@@ -232,6 +232,7 @@ extern pgprot_t protection_map[16];
 #define FAULT_FLAG_KILLABLE	0x10	/* The fault task is in SIGKILL killable region */
 #define FAULT_FLAG_TRIED	0x20	/* Second try */
 #define FAULT_FLAG_USER		0x40	/* The fault originated in userspace */
+#define FAULT_FLAG_FOREIGN	0x80	/* faulting for non current tsk/mm */
 
 /*
  * vm_fault is filled by the the pagefault handler and passed to the vma's
@@ -2139,6 +2140,7 @@ static inline struct page *follow_page(s
 #define FOLL_MIGRATION	0x400	/* wait for page to replace migration entry */
 #define FOLL_TRIED	0x800	/* a retry, previous pass started an IO */
 #define FOLL_MLOCK	0x1000	/* lock present pages */
+#define FOLL_FOREIGN	0x2000	/* we are working on non-current tsk/mm */
 
 typedef int (*pte_fn_t)(pte_t *pte, pgtable_t token, unsigned long addr,
 			void *data);
diff -puN mm/gup.c~pkeys-12-gup-fault-foreign-flag mm/gup.c
--- a/mm/gup.c~pkeys-12-gup-fault-foreign-flag	2015-11-16 12:35:44.781600458 -0800
+++ b/mm/gup.c	2015-11-16 12:35:44.792600958 -0800
@@ -310,6 +310,8 @@ static int faultin_page(struct task_stru
 		return -ENOENT;
 	if (*flags & FOLL_WRITE)
 		fault_flags |= FAULT_FLAG_WRITE;
+	if (*flags & FOLL_FOREIGN)
+		fault_flags |= FAULT_FLAG_FOREIGN;
 	if (nonblocking)
 		fault_flags |= FAULT_FLAG_ALLOW_RETRY;
 	if (*flags & FOLL_NOWAIT)
@@ -360,11 +362,13 @@ static int faultin_page(struct task_stru
 static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 {
 	vm_flags_t vm_flags = vma->vm_flags;
+	int write = (gup_flags & FOLL_WRITE);
+	int foreign = (gup_flags & FOLL_FOREIGN);
 
 	if (vm_flags & (VM_IO | VM_PFNMAP))
 		return -EFAULT;
 
-	if (gup_flags & FOLL_WRITE) {
+	if (write) {
 		if (!(vm_flags & VM_WRITE)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
@@ -392,7 +396,7 @@ static int check_vma_flags(struct vm_are
 		if (!(vm_flags & VM_MAYREAD))
 			return -EFAULT;
 	}
-	if (!arch_vma_access_permitted(vma, (gup_flags & FOLL_WRITE)))
+	if (!arch_vma_access_permitted(vma, write, foreign))
 		return -EFAULT;
 	return 0;
 }
@@ -563,6 +567,7 @@ EXPORT_SYMBOL(__get_user_pages);
 bool vma_permits_fault(struct vm_area_struct *vma, unsigned int fault_flags)
 {
 	int write = (fault_flags & FAULT_FLAG_WRITE);
+	int foreign = (fault_flags & FAULT_FLAG_FOREIGN);
 	vm_flags_t vm_flags = write ? VM_WRITE : VM_READ;
 
 	if (!(vm_flags & vma->vm_flags))
@@ -570,9 +575,9 @@ bool vma_permits_fault(struct vm_area_st
 
 	/*
 	 * The architecture might have a hardware protection
-	 * mechanism other than read/write that can deny access
+	 * mechanism other than read/write that can deny access.
 	 */
-	if (!arch_vma_access_permitted(vma, write))
+	if (!arch_vma_access_permitted(vma, write, foreign))
 		return false;
 
 	return true;
diff -puN mm/ksm.c~pkeys-12-gup-fault-foreign-flag mm/ksm.c
--- a/mm/ksm.c~pkeys-12-gup-fault-foreign-flag	2015-11-16 12:35:44.783600549 -0800
+++ b/mm/ksm.c	2015-11-16 12:35:44.793601003 -0800
@@ -359,6 +359,10 @@ static inline bool ksm_test_exit(struct
  * in case the application has unmapped and remapped mm,addr meanwhile.
  * Could a ksm page appear anywhere else?  Actually yes, in a VM_PFNMAP
  * mmap of /dev/mem or /dev/kmem, where we would not want to touch it.
+ *
+ * FAULT_FLAG/FOLL_FOREIGN are because we do this outside the context
+ * of the process that owns 'vma'.  We also do not want to enforce
+ * protection keys here anyway.
  */
 static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
 {
@@ -367,12 +371,14 @@ static int break_ksm(struct vm_area_stru
 
 	do {
 		cond_resched();
-		page = follow_page(vma, addr, FOLL_GET | FOLL_MIGRATION);
+		page = follow_page(vma, addr,
+				FOLL_GET | FOLL_MIGRATION | FOLL_FOREIGN);
 		if (IS_ERR_OR_NULL(page))
 			break;
 		if (PageKsm(page))
 			ret = handle_mm_fault(vma->vm_mm, vma, addr,
-							FAULT_FLAG_WRITE);
+							FAULT_FLAG_WRITE |
+							FAULT_FLAG_FOREIGN);
 		else
 			ret = VM_FAULT_WRITE;
 		put_page(page);
diff -puN mm/memory.c~pkeys-12-gup-fault-foreign-flag mm/memory.c
--- a/mm/memory.c~pkeys-12-gup-fault-foreign-flag	2015-11-16 12:35:44.785600640 -0800
+++ b/mm/memory.c	2015-11-16 12:35:44.794601049 -0800
@@ -3345,7 +3345,8 @@ static int __handle_mm_fault(struct mm_s
 	pmd_t *pmd;
 	pte_t *pte;
 
-	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE))
+	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
+					    flags & FAULT_FLAG_FOREIGN))
 		return VM_FAULT_SIGSEGV;
 
 	if (unlikely(is_vm_hugetlb_page(vma)))
_
