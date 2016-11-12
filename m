From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH RFC] mm: Add debug_virt_to_phys()
Date: Fri, 11 Nov 2016 16:44:43 -0800
Message-ID: <20161112004449.30566-1-f.fainelli@gmail.com>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nicolas.pitre@linaro.org>, Chris Brandt <chris.brandt@renesas.com>, Pratyush Anand <panand@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Mark Rutland <mark.rutland@arm.com>, James Morse <james.morse@arm.com>, Neeraj Upadhyay <neeraju@codeaurora.org>, Laura Abbott <labbott@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Jerome Marchand <jmarchan@redhat.com>, Konstantin Khlebnikov <koct9i@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>, "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

When CONFIG_DEBUG_VM is turned on, virt_to_phys() maps to
debug_virt_to_phys() which helps catch vmalloc space addresses being
passed. This is helpful in debugging bogus drivers that just assume
linear mappings all over the place.

For ARM, ARM64, Unicore32 and Microblaze, the architectures define
__virt_to_phys() as being the functional implementation of the address
translation, so we special case the debug stub to call into
__virt_to_phys directly.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/include/asm/memory.h      |  4 ++++
 arch/arm64/include/asm/memory.h    |  4 ++++
 include/asm-generic/memory_model.h |  4 ++++
 mm/debug.c                         | 15 +++++++++++++++
 4 files changed, 27 insertions(+)

diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 76cbd9c674df..448dec9b8b00 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -260,11 +260,15 @@ static inline unsigned long __phys_to_virt(phys_addr_t x)
  * translation for translating DMA addresses.  Use the driver
  * DMA support - see dma-mapping.h.
  */
+#ifndef CONFIG_DEBUG_VM
 #define virt_to_phys virt_to_phys
 static inline phys_addr_t virt_to_phys(const volatile void *x)
 {
 	return __virt_to_phys((unsigned long)(x));
 }
+#else
+#define virt_to_phys debug_virt_to_phys
+#endif
 
 #define phys_to_virt phys_to_virt
 static inline void *phys_to_virt(phys_addr_t x)
diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index b71086d25195..c9e436b28523 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -186,11 +186,15 @@ extern u64			kimage_voffset;
  * translation for translating DMA addresses.  Use the driver
  * DMA support - see dma-mapping.h.
  */
+#ifndef CONFIG_DEBUG_VM
 #define virt_to_phys virt_to_phys
 static inline phys_addr_t virt_to_phys(const volatile void *x)
 {
 	return __virt_to_phys((unsigned long)(x));
 }
+#else
+#define virt_to_phys debug_virt_to_phys
+#endif
 
 #define phys_to_virt phys_to_virt
 static inline void *phys_to_virt(phys_addr_t x)
diff --git a/include/asm-generic/memory_model.h b/include/asm-generic/memory_model.h
index 5148150cc80b..426085757258 100644
--- a/include/asm-generic/memory_model.h
+++ b/include/asm-generic/memory_model.h
@@ -80,6 +80,10 @@
 #define page_to_pfn __page_to_pfn
 #define pfn_to_page __pfn_to_page
 
+#ifdef CONFIG_DEBUG_VM
+unsigned long debug_virt_to_phys(volatile void *address);
+#endif /* CONFIG_DEBUG_VM */
+
 #endif /* __ASSEMBLY__ */
 
 #endif
diff --git a/mm/debug.c b/mm/debug.c
index 9feb699c5d25..72b2ca9b11f4 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -161,4 +161,19 @@ void dump_mm(const struct mm_struct *mm)
 	);
 }
 
+#include <asm/memory.h>
+#include <linux/mm.h>
+
+unsigned long debug_virt_to_phys(volatile void *address)
+{
+	BUG_ON(is_vmalloc_addr((const void *)address));
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64) || defined(CONFIG_UNICORE32) || \
+	defined(CONFIG_MICROBLAZE)
+	return __virt_to_phys(address);
+#else
+	return virt_to_phys(address);
+#endif
+}
+EXPORT_SYMBOL(debug_virt_to_phys);
+
 #endif		/* CONFIG_DEBUG_VM */
-- 
2.9.3

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
