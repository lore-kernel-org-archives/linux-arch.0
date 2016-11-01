Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49538 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbcKARLM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Nov 2016 13:11:12 -0400
From: Christopher Covington <cov@codeaurora.org>
Subject: [RFC v2 1/7] mm: Provide generic VDSO unmap and remap functions
Date: Tue,  1 Nov 2016 11:10:55 -0600
Message-ID: <20161101171101.24704-1-cov@codeaurora.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: criu@openvz.org, Will Deacon <will.deacon@arm.com>, linux-mm@kvack.org, Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Christopher Covington <cov@codeaurora.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20161101171055.tE0QKfdBbJtyvKplKLpjoYvkIiWneCFZ3wdPF3EVgWY@z>

When Address Space Layout Randomization (ASLR, randmaps) is enabled, the
address of the VDSO fluctuates from one process to the next. If
Checkpoint/Restore In Userspace (CRIU) is to fully replicate the memory map
of a previous process, it must be able to remap the VDSO of a new process
to the address used by the previous process. Historically this has been
implemented in architecture-specific code for PowerPC and x86. In order to
support 32-bit and 64-bit ARM without further duplication of code, copy
Laurent Dufour's implementation for PowerPC with slight modifications to a
generic location. This is hopefully the beginning of a long process of VDSO
code de-duplication between architectures.

Signed-off-by: Christopher Covington <cov@codeaurora.org>
---
 include/asm-generic/mm_hooks.h | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
index cc5d9a1..73f09f1 100644
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -1,7 +1,17 @@
 /*
- * Define generic no-op hooks for arch_dup_mmap, arch_exit_mmap
- * and arch_unmap to be included in asm-FOO/mmu_context.h for any
- * arch FOO which doesn't need to hook these.
+ * Define generic hooks for arch_dup_mmap, arch_exit_mmap and arch_unmap to be
+ * included in asm-FOO/mmu_context.h for any arch FOO which doesn't need to
+ * specially hook these.
+ *
+ * arch_remap originally from include/linux-mm-arch-hooks.h
+ * arch_unmap originally from arch/powerpc/include/asm/mmu_context.h
+ * Copyright (C) 2015, IBM Corporation
+ * Author: Laurent Dufour <ldufour@linux.vnet.ibm.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
  */
 #ifndef _ASM_GENERIC_MM_HOOKS_H
 #define _ASM_GENERIC_MM_HOOKS_H
@@ -19,6 +29,25 @@ static inline void arch_unmap(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
+#ifdef CONFIG_GENERIC_VDSO
+	if (start <= mm->context.vdso && mm->context.vdso < end)
+		mm->context.vdso = 0;
+#endif /* CONFIG_GENERIC_VDSO */
+}
+
+static inline void arch_remap(struct mm_struct *mm,
+			      unsigned long old_start, unsigned long old_end,
+			      unsigned long new_start, unsigned long new_end)
+{
+#ifdef CONFIG_GENERIC_VDSO
+	/*
+	 * mremap() doesn't allow moving multiple vmas so we can limit the
+	 * check to old_addr == vdso.
+	 */
+	if (old_addr == mm->context.vdso)
+		mm->context.vdso = new_addr;
+
+#endif /* CONFIG_GENERIC_VDSO */
 }
 
 static inline void arch_bprm_mm_init(struct mm_struct *mm,
-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

