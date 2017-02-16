Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-sn1nam01on0047.outbound.protection.outlook.com ([104.47.32.47]:29533
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932571AbdBPPrU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 16 Feb 2017 10:47:20 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v4 23/28] x86/kvm: Enable Secure Memory Encryption of
 nested page tables
Date: Thu, 16 Feb 2017 09:47:11 -0600
Message-ID: <20170216154711.19244.36719.stgit@tlendack-t1.amdoffice.net>
In-Reply-To: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
References: <20170216154158.19244.66630.stgit@tlendack-t1.amdoffice.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org, linux-efi@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc: Rik van Riel <riel@redhat.com>, Radim =?utf-8?b?S3LEjW3DocWZ?= <rkrcmar@redhat.com>, Toshimitsu Kani <toshi.kani@hpe.com>, Arnd Bergmann <arnd@arndb.de>, Jonathan Corbet <corbet@lwn.net>, Matt Fleming <matt@codeblueprint.co.uk>, "Michael S. Tsirkin" <mst@redhat.com>, Joerg Roedel <joro@8bytes.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Brijesh Singh <brijesh.singh@amd.com>, Ingo Molnar <mingo@redhat.com>, Alexander Potapenko <glider@google.com>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Thomas Gleixner <tglx@linutronix.de>, Larry Woodman <lwoodman@redhat.com>, Dmitry Vyukov <dvyukov@google.com>
Message-ID: <20170216154711.WU459FNfYTrGvSC-qsQUuRD8z_g5a50Ev6bHCUEX25E@z>

Update the KVM support to include the memory encryption mask when creating
and using nested page tables.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/kvm_host.h |    3 ++-
 arch/x86/kvm/mmu.c              |    8 ++++++--
 arch/x86/kvm/vmx.c              |    3 ++-
 arch/x86/kvm/x86.c              |    3 ++-
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index a7066dc..37326b5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1050,7 +1050,8 @@ struct kvm_arch_async_pf {
 void kvm_mmu_init_vm(struct kvm *kvm);
 void kvm_mmu_uninit_vm(struct kvm *kvm);
 void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
-		u64 dirty_mask, u64 nx_mask, u64 x_mask, u64 p_mask);
+		u64 dirty_mask, u64 nx_mask, u64 x_mask, u64 p_mask,
+		u64 me_mask);
 
 void kvm_mmu_reset_context(struct kvm_vcpu *vcpu);
 void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index d8d235b..46f246c 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -123,7 +123,7 @@ enum {
 					    * PT32_LEVEL_BITS))) - 1))
 
 #define PT64_PERM_MASK (PT_PRESENT_MASK | PT_WRITABLE_MASK | shadow_user_mask \
-			| shadow_x_mask | shadow_nx_mask)
+			| shadow_x_mask | shadow_nx_mask | shadow_me_mask)
 
 #define ACC_EXEC_MASK    1
 #define ACC_WRITE_MASK   PT_WRITABLE_MASK
@@ -178,6 +178,7 @@ struct kvm_shadow_walk_iterator {
 static u64 __read_mostly shadow_dirty_mask;
 static u64 __read_mostly shadow_mmio_mask;
 static u64 __read_mostly shadow_present_mask;
+static u64 __read_mostly shadow_me_mask;
 
 static void mmu_spte_set(u64 *sptep, u64 spte);
 static void mmu_free_roots(struct kvm_vcpu *vcpu);
@@ -285,7 +286,8 @@ static bool check_mmio_spte(struct kvm_vcpu *vcpu, u64 spte)
 }
 
 void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
-		u64 dirty_mask, u64 nx_mask, u64 x_mask, u64 p_mask)
+		u64 dirty_mask, u64 nx_mask, u64 x_mask, u64 p_mask,
+		u64 me_mask)
 {
 	shadow_user_mask = user_mask;
 	shadow_accessed_mask = accessed_mask;
@@ -293,6 +295,7 @@ void kvm_mmu_set_mask_ptes(u64 user_mask, u64 accessed_mask,
 	shadow_nx_mask = nx_mask;
 	shadow_x_mask = x_mask;
 	shadow_present_mask = p_mask;
+	shadow_me_mask = me_mask;
 }
 EXPORT_SYMBOL_GPL(kvm_mmu_set_mask_ptes);
 
@@ -2546,6 +2549,7 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
 		pte_access &= ~ACC_WRITE_MASK;
 
 	spte |= (u64)pfn << PAGE_SHIFT;
+	spte |= shadow_me_mask;
 
 	if (pte_access & ACC_WRITE_MASK) {
 
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index a236dec..fac3c27 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -6703,7 +6703,8 @@ static __init int hardware_setup(void)
 			(enable_ept_ad_bits) ? VMX_EPT_DIRTY_BIT : 0ull,
 			0ull, VMX_EPT_EXECUTABLE_MASK,
 			cpu_has_vmx_ept_execute_only() ?
-				      0ull : VMX_EPT_READABLE_MASK);
+				      0ull : VMX_EPT_READABLE_MASK,
+			0ull);
 		ept_set_mmio_spte_mask();
 		kvm_enable_tdp();
 	} else
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a719783..9e6a593 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -67,6 +67,7 @@
 #include <asm/pvclock.h>
 #include <asm/div64.h>
 #include <asm/irq_remapping.h>
+#include <asm/mem_encrypt.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -6027,7 +6028,7 @@ int kvm_arch_init(void *opaque)
 
 	kvm_mmu_set_mask_ptes(PT_USER_MASK, PT_ACCESSED_MASK,
 			PT_DIRTY_MASK, PT64_NX_MASK, 0,
-			PT_PRESENT_MASK);
+			PT_PRESENT_MASK, sme_me_mask);
 	kvm_timer_init();
 
 	perf_register_guest_info_callbacks(&kvm_guest_cbs);
