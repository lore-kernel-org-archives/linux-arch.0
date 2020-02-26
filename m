From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v2 14/19] arm64: mte: Validate the PROT_MTE request via arch_validate_flags()
Date: Wed, 26 Feb 2020 18:05:21 +0000
Message-ID: <20200226180526.3272848-15-catalin.marinas@arm.com>
References: <20200226180526.3272848-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.110.172]:40228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbgBZSGA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 Feb 2020 13:06:00 -0500
In-Reply-To: <20200226180526.3272848-1-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Will Deacon <will@kernel.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Richard Earnshaw <Richard.Earnshaw@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Andrey Konovalov <andreyknvl@google.com>, Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org, linux-arch@vger.kernel.org

Make use of the newly introduced arch_validate_flags() hook to
sanity-check the PROT_MTE request passed to mmap() and mprotect(). If
the mapping does not support MTE, these syscalls will return -EINVAL.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/mman.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index c77a23869223..5c356d1ca266 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -44,7 +44,11 @@ static inline unsigned long arch_calc_vm_flag_bits(unsigned long flags)
 
 static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 {
-	return (vm_flags & VM_MTE) && (vm_flags & VM_MTE_ALLOWED) ?
+	/*
+	 * Checking for VM_MTE only is sufficient since arch_validate_flags()
+	 * does not permit (VM_MTE & !VM_MTE_ALLOWED).
+	 */
+	return (vm_flags & VM_MTE) ?
 		__pgprot(PTE_ATTRINDX(MT_NORMAL_TAGGED)) :
 		__pgprot(0);
 }
@@ -61,4 +65,14 @@ static inline bool arch_validate_prot(unsigned long prot, unsigned long addr)
 }
 #define arch_validate_prot arch_validate_prot
 
+static inline bool arch_validate_flags(unsigned long flags)
+{
+	if (!system_supports_mte())
+		return true;
+
+	/* only allow VM_MTE if VM_MTE_ALLOWED has been set previously */
+	return !(flags & VM_MTE) || (flags & VM_MTE_ALLOWED);
+}
+#define arch_validate_flags arch_validate_flags
+
 #endif /* !__ASM_MMAN_H__ */
