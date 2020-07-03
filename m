Return-Path: <SRS0=KQoP=AO=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:33746 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgGCCgM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:12 -0400
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 19/21] KVM: MIPS: Drop @max param from mmu_topup_memory_cache()
Date: Thu,  2 Jul 2020 19:35:43 -0700
Message-ID: <20200703023545.8771-20-sean.j.christopherson@intel.com>
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>, Peter Feiner <pfeiner@google.com>, Peter Shier <pshier@google.com>, Junaid Shahid <junaids@google.com>, Christoffer Dall <christoffer.dall@arm.com>
Message-ID: <20200703023543.D4-CSzsiEk7XiS9F6Cg2qrU5JfzYCh-8P8q-kG-fiM0@z>

Replace the @max param in mmu_topup_memory_cache() and instead use
ARRAY_SIZE() to terminate the loop to fill the cache.  This removes a
BUG_ON() and sets the stage for moving MIPS to the common memory cache
implementation.

No functional change intended.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/mips/kvm/mmu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 49bd160f4d85..d1f148db2449 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -25,15 +25,13 @@
 #define KVM_MMU_CACHE_MIN_PAGES 2
 #endif
 
-static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
-				  int min, int max)
+static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
 {
 	void *page;
 
-	BUG_ON(max > KVM_NR_MEM_OBJS);
 	if (cache->nobjs >= min)
 		return 0;
-	while (cache->nobjs < max) {
+	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
 		page = (void *)__get_free_page(GFP_KERNEL);
 		if (!page)
 			return -ENOMEM;
@@ -711,8 +709,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 		goto out;
 
 	/* We need a minimum of cached pages ready for page table creation */
-	err = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES,
-				     KVM_NR_MEM_OBJS);
+	err = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES);
 	if (err)
 		goto out;
 
@@ -796,8 +793,7 @@ static pte_t *kvm_trap_emul_pte_for_gva(struct kvm_vcpu *vcpu,
 	int ret;
 
 	/* We need a minimum of cached pages ready for page table creation */
-	ret = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES,
-				     KVM_NR_MEM_OBJS);
+	ret = mmu_topup_memory_cache(memcache, KVM_MMU_CACHE_MIN_PAGES);
 	if (ret)
 		return NULL;
 
-- 
2.26.0
