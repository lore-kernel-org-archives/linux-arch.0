From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 12/21] KVM: x86/mmu: Skip filling the gfn cache for
 guaranteed direct MMU topups
Date: Thu,  2 Jul 2020 19:35:36 -0700
Message-ID: <20200703023545.8771-13-sean.j.christopherson@intel.com>
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

Don't bother filling the gfn array cache when the caller is a fully
direct MMU, i.e. won't need a gfn array for shadow pages.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c         | 18 ++++++++++--------
 arch/x86/kvm/mmu/paging_tmpl.h |  4 ++--
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 60b0d460bbf5..586d63de0e78 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1101,7 +1101,7 @@ static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
 	}
 }
 
-static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
+static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
 {
 	int r;
 
@@ -1114,10 +1114,12 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 				   PT64_ROOT_MAX_LEVEL);
 	if (r)
 		return r;
-	r = mmu_topup_memory_cache(&vcpu->arch.mmu_gfn_array_cache,
-				   PT64_ROOT_MAX_LEVEL);
-	if (r)
-		return r;
+	if (maybe_indirect) {
+		r = mmu_topup_memory_cache(&vcpu->arch.mmu_gfn_array_cache,
+					   PT64_ROOT_MAX_LEVEL);
+		if (r)
+			return r;
+	}
 	return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache,
 				      PT64_ROOT_MAX_LEVEL);
 }
@@ -4107,7 +4109,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
 	if (fast_page_fault(vcpu, gpa, error_code))
 		return RET_PF_RETRY;
 
-	r = mmu_topup_memory_caches(vcpu);
+	r = mmu_topup_memory_caches(vcpu, false);
 	if (r)
 		return r;
 
@@ -5142,7 +5144,7 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
 {
 	int r;
 
-	r = mmu_topup_memory_caches(vcpu);
+	r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->direct_map);
 	if (r)
 		goto out;
 	r = mmu_alloc_roots(vcpu);
@@ -5336,7 +5338,7 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
 	 * or not since pte prefetch is skiped if it does not have
 	 * enough objects in the cache.
 	 */
-	mmu_topup_memory_caches(vcpu);
+	mmu_topup_memory_caches(vcpu, true);
 
 	spin_lock(&vcpu->kvm->mmu_lock);
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 451d7aa7d959..8d2159ae3bdf 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -815,7 +815,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 		return RET_PF_EMULATE;
 	}
 
-	r = mmu_topup_memory_caches(vcpu);
+	r = mmu_topup_memory_caches(vcpu, true);
 	if (r)
 		return r;
 
@@ -902,7 +902,7 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
 	 * No need to check return value here, rmap_can_add() can
 	 * help us to skip pte prefetch later.
 	 */
-	mmu_topup_memory_caches(vcpu);
+	mmu_topup_memory_caches(vcpu, true);
 
 	if (!VALID_PAGE(root_hpa)) {
 		WARN_ON(1);
-- 
2.26.0
