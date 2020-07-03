From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 10/21] KVM: x86/mmu: Make __GFP_ZERO a property of the
 memory cache
Date: Thu,  2 Jul 2020 19:35:34 -0700
Message-ID: <20200703023545.8771-11-sean.j.christopherson@intel.com>
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

Add a gfp_zero flag to 'struct kvm_mmu_memory_cache' and use it to
control __GFP_ZERO instead of hardcoding a call to kmem_cache_zalloc().
A future patch needs such a flag for the __get_free_page() path, as
gfn arrays do not need/want the allocator to zero the memory.  Convert
the kmem_cache paths to __GFP_ZERO now so as to avoid a weird and
inconsistent API in the future.

No functional change intended.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/include/asm/kvm_host.h | 1 +
 arch/x86/kvm/mmu/mmu.c          | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index b71a4e77f65a..685fe5ac7124 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -251,6 +251,7 @@ struct kvm_kernel_irq_routing_entry;
  */
 struct kvm_mmu_memory_cache {
 	int nobjs;
+	gfp_t gfp_zero;
 	struct kmem_cache *kmem_cache;
 	void *objects[KVM_NR_MEM_OBJS];
 };
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8e1b55d8a728..ed36f5e63863 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1063,8 +1063,10 @@ static void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
 static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
 					       gfp_t gfp_flags)
 {
+	gfp_flags |= mc->gfp_zero;
+
 	if (mc->kmem_cache)
-		return kmem_cache_zalloc(mc->kmem_cache, gfp_flags);
+		return kmem_cache_alloc(mc->kmem_cache, gfp_flags);
 	else
 		return (void *)__get_free_page(gfp_flags);
 }
@@ -5675,7 +5677,10 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
 	int ret;
 
 	vcpu->arch.mmu_pte_list_desc_cache.kmem_cache = pte_list_desc_cache;
+	vcpu->arch.mmu_pte_list_desc_cache.gfp_zero = __GFP_ZERO;
+
 	vcpu->arch.mmu_page_header_cache.kmem_cache = mmu_page_header_cache;
+	vcpu->arch.mmu_page_header_cache.gfp_zero = __GFP_ZERO;
 
 	vcpu->arch.mmu = &vcpu->arch.root_mmu;
 	vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
-- 
2.26.0
