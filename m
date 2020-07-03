From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 08/21] KVM: x86/mmu: Clean up the gorilla math in
 mmu_topup_memory_caches()
Date: Thu,  2 Jul 2020 19:35:32 -0700
Message-ID: <20200703023545.8771-9-sean.j.christopherson@intel.com>
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

Clean up the minimums in mmu_topup_memory_caches() to document the
driving mechanisms behind the minimums.  Now that encountering an empty
cache is unlikely to trigger BUG_ON(), it is less dangerous to be more
precise when defining the minimums.

For rmaps, the logic is 1 parent PTE per level, plus a single rmap, and
prefetched rmaps.  The extra objects in the current '8 + PREFETCH'
minimum came about due to an abundance of paranoia in commit
c41ef344de212 ("KVM: MMU: increase per-vcpu rmap cache alloc size"),
i.e. it could have increased the minimum to 2 rmaps.  Furthermore, the
unexpected extra rmap case was killed off entirely by commits
f759e2b4c728c ("KVM: MMU: avoid pte_list_desc running out in
kvm_mmu_pte_write") and f5a1e9f89504f ("KVM: MMU: remove call to
kvm_mmu_pte_write from walk_addr").

For the so called page cache, replace '8' with 2*PT64_ROOT_MAX_LEVEL.
The 2x multiplier is needed because the cache is used for both shadow
pages and gfn arrays for indirect MMUs.

And finally, for page headers, replace '4' with PT64_ROOT_MAX_LEVEL.

Note, KVM now supports 5-level paging, i.e. the old minimums that used a
baseline derived from 4-level paging were technically wrong.  But, KVM
always allocates roots in a separate flow, e.g. it's impossible in the
current implementation to actually need 5 new shadow pages in a single
flow.  Use PT64_ROOT_MAX_LEVEL unmodified instead of subtracting 1, as
the direct usage is likely more intuitive to uninformed readers, and the
inflated minimum is unlikely to affect functionality in practice.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 3d0768e16463..cf02ad93c249 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1103,14 +1103,17 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 {
 	int r;
 
+	/* 1 rmap, 1 parent PTE per level, and the prefetched rmaps. */
 	r = mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
-				   8 + PTE_PREFETCH_NUM);
+				   1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);
 	if (r)
 		return r;
-	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache, 8);
+	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache,
+				   2 * PT64_ROOT_MAX_LEVEL);
 	if (r)
 		return r;
-	return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache, 4);
+	return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache,
+				      PT64_ROOT_MAX_LEVEL);
 }
 
 static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
-- 
2.26.0
