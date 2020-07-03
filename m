From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 03/21] KVM: x86/mmu: Use consistent "mc" name for
 kvm_mmu_memory_cache locals
Date: Thu,  2 Jul 2020 19:35:27 -0700
Message-ID: <20200703023545.8771-4-sean.j.christopherson@intel.com>
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

Use "mc" for local variables to shorten line lengths and provide
consistent names, which will be especially helpful when some of the
helpers are moved to common KVM code in future patches.

No functional change intended.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d6612af6c056..b6df4525e86c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1060,27 +1060,27 @@ static void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
 	local_irq_enable();
 }
 
-static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
+static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
 {
 	void *obj;
 
-	if (cache->nobjs >= min)
+	if (mc->nobjs >= min)
 		return 0;
-	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		if (cache->kmem_cache)
-			obj = kmem_cache_zalloc(cache->kmem_cache, GFP_KERNEL_ACCOUNT);
+	while (mc->nobjs < ARRAY_SIZE(mc->objects)) {
+		if (mc->kmem_cache)
+			obj = kmem_cache_zalloc(mc->kmem_cache, GFP_KERNEL_ACCOUNT);
 		else
 			obj = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
 		if (!obj)
-			return cache->nobjs >= min ? 0 : -ENOMEM;
-		cache->objects[cache->nobjs++] = obj;
+			return mc->nobjs >= min ? 0 : -ENOMEM;
+		mc->objects[mc->nobjs++] = obj;
 	}
 	return 0;
 }
 
-static int mmu_memory_cache_free_objects(struct kvm_mmu_memory_cache *cache)
+static int mmu_memory_cache_free_objects(struct kvm_mmu_memory_cache *mc)
 {
-	return cache->nobjs;
+	return mc->nobjs;
 }
 
 static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
@@ -1395,10 +1395,10 @@ static struct kvm_rmap_head *gfn_to_rmap(struct kvm *kvm, gfn_t gfn,
 
 static bool rmap_can_add(struct kvm_vcpu *vcpu)
 {
-	struct kvm_mmu_memory_cache *cache;
+	struct kvm_mmu_memory_cache *mc;
 
-	cache = &vcpu->arch.mmu_pte_list_desc_cache;
-	return mmu_memory_cache_free_objects(cache);
+	mc = &vcpu->arch.mmu_pte_list_desc_cache;
+	return mmu_memory_cache_free_objects(mc);
 }
 
 static int rmap_add(struct kvm_vcpu *vcpu, u64 *spte, gfn_t gfn)
-- 
2.26.0
