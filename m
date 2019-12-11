From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 17/22] arm64: mte: Validate the PROT_MTE request via
 arch_validate_flags()
Date: Wed, 11 Dec 2019 18:40:22 +0000
Message-ID: <20191211184027.20130-18-catalin.marinas@arm.com>
References: <20191211184027.20130-1-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191211184027.20130-1-catalin.marinas@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Richard Earnshaw <Richard.Earnshaw@arm.com>, Szabolcs Nagy <szabolcs.nagy@arm.com>, Marc Zyngier <maz@kernel.org>, Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org, Andrey Konovalov <andreyknvl@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

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
