From: Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 4/5] mm: remove arch_bprm_mm_init() hook
Date: Thu, 23 Jan 2020 11:05:03 -0800
Message-ID: <20200123190503.133804C8@viggo.jf.intel.com>
References: <20200123190456.8E05ADE6@viggo.jf.intel.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:9851 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgAWTKy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 Jan 2020 14:10:54 -0500
In-Reply-To: <20200123190456.8E05ADE6@viggo.jf.intel.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>, peterz@infradead.org, luto@kernel.org, x86@kernel.org, torvalds@linux-foundation.org, linux-arch@vger.kernel.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, gxt@pku.edu.cn, akpm@linux-foundation.org


From: Dave Hansen <dave.hansen@linux.intel.com>

MPX is being removed from the kernel due to a lack of support
in the toolchain going forward (gcc).

arch_bprm_mm_init() is used at execve() time.  The only non-stub
implementation is on x86 for MPX.  Remove the hook entirely from
all architectures and generic code.

Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: x86@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Guan Xuetao <gxt@pku.edu.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
---

 b/arch/powerpc/include/asm/mmu_context.h   |    5 -----
 b/arch/um/include/asm/mmu_context.h        |    5 -----
 b/arch/unicore32/include/asm/mmu_context.h |    5 -----
 b/arch/x86/include/asm/mmu_context.h       |    6 ------
 b/fs/exec.c                                |    1 -
 b/include/asm-generic/mm_hooks.h           |    5 -----
 6 files changed, 27 deletions(-)

diff -puN arch/powerpc/include/asm/mmu_context.h~mpx-remove-generic-mm arch/powerpc/include/asm/mmu_context.h
--- a/arch/powerpc/include/asm/mmu_context.h~mpx-remove-generic-mm	2020-01-23 10:41:07.054942434 -0800
+++ b/arch/powerpc/include/asm/mmu_context.h	2020-01-23 10:41:07.068942434 -0800
@@ -238,11 +238,6 @@ static inline void arch_unmap(struct mm_
 		mm->context.vdso_base = 0;
 }
 
-static inline void arch_bprm_mm_init(struct mm_struct *mm,
-				     struct vm_area_struct *vma)
-{
-}
-
 #ifdef CONFIG_PPC_MEM_KEYS
 bool arch_vma_access_permitted(struct vm_area_struct *vma, bool write,
 			       bool execute, bool foreign);
diff -puN arch/um/include/asm/mmu_context.h~mpx-remove-generic-mm arch/um/include/asm/mmu_context.h
--- a/arch/um/include/asm/mmu_context.h~mpx-remove-generic-mm	2020-01-23 10:41:07.056942434 -0800
+++ b/arch/um/include/asm/mmu_context.h	2020-01-23 10:41:07.068942434 -0800
@@ -25,11 +25,6 @@ static inline void arch_unmap(struct mm_
 			unsigned long start, unsigned long end)
 {
 }
-static inline void arch_bprm_mm_init(struct mm_struct *mm,
-				     struct vm_area_struct *vma)
-{
-}
-
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
diff -puN arch/unicore32/include/asm/mmu_context.h~mpx-remove-generic-mm arch/unicore32/include/asm/mmu_context.h
--- a/arch/unicore32/include/asm/mmu_context.h~mpx-remove-generic-mm	2020-01-23 10:41:07.058942434 -0800
+++ b/arch/unicore32/include/asm/mmu_context.h	2020-01-23 10:41:07.068942434 -0800
@@ -89,11 +89,6 @@ static inline void arch_unmap(struct mm_
 {
 }
 
-static inline void arch_bprm_mm_init(struct mm_struct *mm,
-				     struct vm_area_struct *vma)
-{
-}
-
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
diff -puN arch/x86/include/asm/mmu_context.h~mpx-remove-generic-mm arch/x86/include/asm/mmu_context.h
--- a/arch/x86/include/asm/mmu_context.h~mpx-remove-generic-mm	2020-01-23 10:41:07.060942434 -0800
+++ b/arch/x86/include/asm/mmu_context.h	2020-01-23 10:41:07.069942434 -0800
@@ -272,12 +272,6 @@ static inline bool is_64bit_mm(struct mm
 }
 #endif
 
-static inline void arch_bprm_mm_init(struct mm_struct *mm,
-		struct vm_area_struct *vma)
-{
-	mpx_mm_init(mm);
-}
-
 static inline void arch_unmap(struct mm_struct *mm, unsigned long start,
 			      unsigned long end)
 {
diff -puN fs/exec.c~mpx-remove-generic-mm fs/exec.c
--- a/fs/exec.c~mpx-remove-generic-mm	2020-01-23 10:41:07.062942434 -0800
+++ b/fs/exec.c	2020-01-23 10:41:07.069942434 -0800
@@ -273,7 +273,6 @@ static int __bprm_mm_init(struct linux_b
 		goto err;
 
 	mm->stack_vm = mm->total_vm = 1;
-	arch_bprm_mm_init(mm, vma);
 	up_write(&mm->mmap_sem);
 	bprm->p = vma->vm_end - sizeof(void *);
 	return 0;
diff -puN include/asm-generic/mm_hooks.h~mpx-remove-generic-mm include/asm-generic/mm_hooks.h
--- a/include/asm-generic/mm_hooks.h~mpx-remove-generic-mm	2020-01-23 10:41:07.064942434 -0800
+++ b/include/asm-generic/mm_hooks.h	2020-01-23 10:41:07.069942434 -0800
@@ -22,11 +22,6 @@ static inline void arch_unmap(struct mm_
 {
 }
 
-static inline void arch_bprm_mm_init(struct mm_struct *mm,
-				     struct vm_area_struct *vma)
-{
-}
-
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
_
