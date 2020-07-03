Return-Path: <SRS0=KQoP=AO=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3199 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgGCCgO (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:14 -0400
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 09/21] KVM: x86/mmu: Separate the memory caches for shadow pages and gfn arrays
Date: Thu,  2 Jul 2020 19:35:33 -0700
Message-ID: <20200703023545.8771-10-sean.j.christopherson@intel.com>
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>, Peter Feiner <pfeiner@google.com>, Peter Shier <pshier@google.com>, Junaid Shahid <junaids@google.com>, Christoffer Dall <christoffer.dall@arm.com>
Message-ID: <20200703023533.GxVuBQggg5XpyISGFmAvIDyijhDQVZXI-FDhA4ALPt8@z>

Use separate caches for allocating shadow pages versus gfn arrays.  This
sets the stage for specifying __GFP_ZERO when allocating shadow pages
without incurring extra cost for gfn arrays.

No functional change intended.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/kvm/mmu/mmu.c          | 15 ++++++++++-----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 71bc32e00d7e..b71a4e77f65a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -636,7 +636,8 @@ struct kvm_vcpu_arch {
 	struct kvm_mmu *walk_mmu;
 
 	struct kvm_mmu_memory_cache mmu_pte_list_desc_cache;
-	struct kvm_mmu_memory_cache mmu_page_cache;
+	struct kvm_mmu_memory_cache mmu_shadow_page_cache;
+	struct kvm_mmu_memory_cache mmu_gfn_array_cache;
 	struct kvm_mmu_memory_cache mmu_page_header_cache;
 
 	/*
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cf02ad93c249..8e1b55d8a728 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1108,8 +1108,12 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 				   1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);
 	if (r)
 		return r;
-	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache,
-				   2 * PT64_ROOT_MAX_LEVEL);
+	r = mmu_topup_memory_cache(&vcpu->arch.mmu_shadow_page_cache,
+				   PT64_ROOT_MAX_LEVEL);
+	if (r)
+		return r;
+	r = mmu_topup_memory_cache(&vcpu->arch.mmu_gfn_array_cache,
+				   PT64_ROOT_MAX_LEVEL);
 	if (r)
 		return r;
 	return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache,
@@ -1119,7 +1123,8 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 {
 	mmu_free_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache);
-	mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
+	mmu_free_memory_cache(&vcpu->arch.mmu_shadow_page_cache);
+	mmu_free_memory_cache(&vcpu->arch.mmu_gfn_array_cache);
 	mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
 }
 
@@ -2096,9 +2101,9 @@ static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct
 	struct kvm_mmu_page *sp;
 
 	sp = mmu_memory_cache_alloc(&vcpu->arch.mmu_page_header_cache);
-	sp->spt = mmu_memory_cache_alloc(&vcpu->arch.mmu_page_cache);
+	sp->spt = mmu_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache);
 	if (!direct)
-		sp->gfns = mmu_memory_cache_alloc(&vcpu->arch.mmu_page_cache);
+		sp->gfns = mmu_memory_cache_alloc(&vcpu->arch.mmu_gfn_array_cache);
 	set_page_private(virt_to_page(sp->spt), (unsigned long)sp);
 
 	/*
-- 
2.26.0
