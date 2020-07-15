From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v7 16/29] arm64: mte: Validate the PROT_MTE request via arch_validate_flags()
Date: Wed, 15 Jul 2020 18:08:31 +0100
Message-ID: <20200715170844.30064-17-catalin.marinas@arm.com>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgGORJ1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jul 2020 13:09:27 -0400
In-Reply-To: <20200715170844.30064-1-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>, Dave P Martin <Dave.Martin@arm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, Andrew Morton <akpm@linux-foundation.org>

Make use of the newly introduced arch_validate_flags() hook to
sanity-check the PROT_MTE request passed to mmap() and mprotect(). If
the mapping does not support MTE, these syscalls will return -EINVAL.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/mman.h | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index b01051be7750..e3e28f7daf62 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -49,8 +49,10 @@ static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 	 * register (1) as VM_MTE in the vma->vm_flags and (2) as
 	 * VM_MTE_ALLOWED. Note that the latter can only be set during the
 	 * mmap() call since mprotect() does not accept MAP_* flags.
+	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
+	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
 	 */
-	if ((vm_flags & VM_MTE) && (vm_flags & VM_MTE_ALLOWED))
+	if (vm_flags & VM_MTE)
 		prot |= PTE_ATTRINDX(MT_NORMAL_TAGGED);
 
 	return __pgprot(prot);
@@ -72,4 +74,14 @@ static inline bool arch_validate_prot(unsigned long prot,
 }
 #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
 
+static inline bool arch_validate_flags(unsigned long vm_flags)
+{
+	if (!system_supports_mte())
+		return true;
+
+	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
+	return !(vm_flags & VM_MTE) || (vm_flags & VM_MTE_ALLOWED);
+}
+#define arch_validate_flags(vm_flags) arch_validate_flags(vm_flags)
+
 #endif /* ! __ASM_MMAN_H__ */
