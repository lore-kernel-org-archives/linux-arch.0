From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 14/21] KVM: Move x86's version of struct
 kvm_mmu_memory_cache to common code
Date: Thu,  2 Jul 2020 19:35:38 -0700
Message-ID: <20200703023545.8771-15-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, Junaid Shahid <junaids@google.com>, Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>, linux-mips@vger.kernel.org, Sean Christopherson <sean.j.christopherson@intel.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Ben Gardon <bgardon@google.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Peter Feiner <pfeiner@google.com>, kvmarm@lists.cs.columbia.edu, Jim Mattson <jmattson@google.com>
List-Id: linux-arch.vger.kernel.org

Move x86's 'struct kvm_mmu_memory_cache' to common code in anticipation
of moving the entire x86 implementation code to common KVM and reusing
it for arm64 and MIPS.  Add a new architecture specific asm/kvm_types.h
to control the existence and parameters of the struct.  The new header
is needed to avoid a chicken-and-egg problem with asm/kvm_host.h as all
architectures define instances of the struct in their vCPU structs.

Add an asm-generic version of kvm_types.h to avoid having empty files on
PPC and s390 in the long term, and for arm64 and mips in the short term.

Suggested-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/arm64/include/asm/Kbuild    |  1 +
 arch/mips/include/asm/Kbuild     |  1 +
 arch/powerpc/include/asm/Kbuild  |  1 +
 arch/s390/include/asm/Kbuild     |  1 +
 arch/x86/include/asm/kvm_host.h  | 13 -------------
 arch/x86/include/asm/kvm_types.h |  7 +++++++
 include/asm-generic/kvm_types.h  |  5 +++++
 include/linux/kvm_types.h        | 19 +++++++++++++++++++
 8 files changed, 35 insertions(+), 13 deletions(-)
 create mode 100644 arch/x86/include/asm/kvm_types.h
 create mode 100644 include/asm-generic/kvm_types.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index ff9cbb631212..35a68155cd0e 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 generic-y += early_ioremap.h
+generic-y += kvm_types.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
index 8643d313890e..397e6d24d2ab 100644
--- a/arch/mips/include/asm/Kbuild
+++ b/arch/mips/include/asm/Kbuild
@@ -5,6 +5,7 @@ generated-y += syscall_table_64_n32.h
 generated-y += syscall_table_64_n64.h
 generated-y += syscall_table_64_o32.h
 generic-y += export.h
+generic-y += kvm_types.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += parport.h
diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
index dadbcf3a0b1e..2d444d09b553 100644
--- a/arch/powerpc/include/asm/Kbuild
+++ b/arch/powerpc/include/asm/Kbuild
@@ -4,6 +4,7 @@ generated-y += syscall_table_64.h
 generated-y += syscall_table_c32.h
 generated-y += syscall_table_spu.h
 generic-y += export.h
+generic-y += kvm_types.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
 generic-y += vtime.h
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 83f6e85de7bc..319efa0e6d02 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -6,5 +6,6 @@ generated-y += unistd_nr.h
 
 generic-y += asm-offsets.h
 generic-y += export.h
+generic-y += kvm_types.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 685fe5ac7124..c461710d621a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -193,8 +193,6 @@ struct x86_exception;
 enum x86_intercept;
 enum x86_intercept_stage;
 
-#define KVM_NR_MEM_OBJS 40
-
 #define KVM_NR_DB_REGS	4
 
 #define DR6_BD		(1 << 13)
@@ -245,17 +243,6 @@ enum x86_intercept_stage;
 
 struct kvm_kernel_irq_routing_entry;
 
-/*
- * We don't want allocation failures within the mmu code, so we preallocate
- * enough memory for a single page fault in a cache.
- */
-struct kvm_mmu_memory_cache {
-	int nobjs;
-	gfp_t gfp_zero;
-	struct kmem_cache *kmem_cache;
-	void *objects[KVM_NR_MEM_OBJS];
-};
-
 /*
  * the pages used as guest page table on soft mmu are tracked by
  * kvm_memory_slot.arch.gfn_track which is 16 bits, so the role bits used
diff --git a/arch/x86/include/asm/kvm_types.h b/arch/x86/include/asm/kvm_types.h
new file mode 100644
index 000000000000..08f1b57d3b62
--- /dev/null
+++ b/arch/x86/include/asm/kvm_types.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_KVM_TYPES_H
+#define _ASM_X86_KVM_TYPES_H
+
+#define KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE 40
+
+#endif /* _ASM_X86_KVM_TYPES_H */
diff --git a/include/asm-generic/kvm_types.h b/include/asm-generic/kvm_types.h
new file mode 100644
index 000000000000..2a82daf110f1
--- /dev/null
+++ b/include/asm-generic/kvm_types.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_KVM_TYPES_H
+#define _ASM_GENERIC_KVM_TYPES_H
+
+#endif
diff --git a/include/linux/kvm_types.h b/include/linux/kvm_types.h
index 68e84cf42a3f..a7580f69dda0 100644
--- a/include/linux/kvm_types.h
+++ b/include/linux/kvm_types.h
@@ -20,6 +20,8 @@ enum kvm_mr_change;
 
 #include <linux/types.h>
 
+#include <asm/kvm_types.h>
+
 /*
  * Address types:
  *
@@ -58,4 +60,21 @@ struct gfn_to_pfn_cache {
 	bool dirty;
 };
 
+#ifdef KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE
+/*
+ * Memory caches are used to preallocate memory ahead of various MMU flows,
+ * e.g. page fault handlers.  Gracefully handling allocation failures deep in
+ * MMU flows is problematic, as is triggering reclaim, I/O, etc... while
+ * holding MMU locks.  Note, these caches act more like prefetch buffers than
+ * classical caches, i.e. objects are not returned to the cache on being freed.
+ */
+struct kvm_mmu_memory_cache {
+	int nobjs;
+	gfp_t gfp_zero;
+	struct kmem_cache *kmem_cache;
+	void *objects[KVM_ARCH_NR_OBJS_PER_MEMORY_CACHE];
+};
+#endif
+
+
 #endif /* __KVM_TYPES_H__ */
-- 
2.26.0
