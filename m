Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60394 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753801AbdDCPT5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 3 Apr 2017 11:19:57 -0400
From: Mark Rutland <mark.rutland@arm.com>
Subject: [RFC 1/9] asm-generic: mm_hooks: allow hooks to be overridden individually
Date: Mon,  3 Apr 2017 16:19:17 +0100
Message-ID: <1491232765-32501-2-git-send-email-mark.rutland@arm.com>
In-Reply-To: <1491232765-32501-1-git-send-email-mark.rutland@arm.com>
References: <1491232765-32501-1-git-send-email-mark.rutland@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com, christoffer.dall@linaro.org, jiong.wang@arm.com, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, marc.zyngier@arm.com, mark.rutland@arm.com, suzuki.poulose@arm.com, will.deacon@arm.com
Message-ID: <20170403151917.23nmYV91Pct2R6BTj9r6VUJwrtZ-cyoH12uVIWZjdJU@z>

Currently, an architecture must either implement all of the mm hooks
itself, or use all of those provided by the asm-generic implementation.
When an architecture only needs to override a single hook, it must copy
the stub implementations from the asm-generic version.

To avoid this repetition, allow each hook to be overridden indiviually,
by placing each under an #ifndef block. As architectures providing their
own hooks can't include this file today, this shouldn't adversely affect
any existing hooks.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de> 
Cc: linux-arch@vger.kernel.org
---
 include/asm-generic/mm_hooks.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/asm-generic/mm_hooks.h b/include/asm-generic/mm_hooks.h
index cc5d9a1..c5a4328 100644
--- a/include/asm-generic/mm_hooks.h
+++ b/include/asm-generic/mm_hooks.h
@@ -6,36 +6,48 @@
 #ifndef _ASM_GENERIC_MM_HOOKS_H
 #define _ASM_GENERIC_MM_HOOKS_H
 
+#ifndef arch_dup_mmap
 static inline void arch_dup_mmap(struct mm_struct *oldmm,
 				 struct mm_struct *mm)
 {
 }
+#endif
 
+#ifndef arch_exit_mmap
 static inline void arch_exit_mmap(struct mm_struct *mm)
 {
 }
+#endif
 
+#ifndef arch_unmap
 static inline void arch_unmap(struct mm_struct *mm,
 			struct vm_area_struct *vma,
 			unsigned long start, unsigned long end)
 {
 }
+#endif
 
+#ifndef arch_bprm_mm_init
 static inline void arch_bprm_mm_init(struct mm_struct *mm,
 				     struct vm_area_struct *vma)
 {
 }
+#endif
 
+#ifndef arch_vma_access_permitted
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
 	/* by default, allow everything */
 	return true;
 }
+#endif
 
+#ifndef arch_pte_access_permitted
 static inline bool arch_pte_access_permitted(pte_t pte, bool write)
 {
 	/* by default, allow everything */
 	return true;
 }
+#endif
 #endif	/* _ASM_GENERIC_MM_HOOKS_H */
-- 
1.9.1
