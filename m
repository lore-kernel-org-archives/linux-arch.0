From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v2 04/21] KVM: x86/mmu: Remove superfluous gotos from mmu_topup_memory_caches()
Date: Mon, 22 Jun 2020 13:08:05 -0700
Message-ID: <20200622200822.4426-5-sean.j.christopherson@intel.com>
References: <20200622200822.4426-1-sean.j.christopherson@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200622200822.4426-1-sean.j.christopherson@intel.com>
Sender: kvm-owner@vger.kernel.org
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>, Peter Feiner <pfeiner@google.com>, Peter Shier <pshier@google.com>, Junaid Shahid <junaids@google.com>, Christoffer Dall <christoffer.dall@arm.com>
List-Id: linux-arch.vger.kernel.org

Return errors directly from mmu_topup_memory_caches() instead of
branching to a label that does the same.

No functional change intended.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/mmu.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 36c90f004ef4..ba70de24a5b0 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1100,13 +1100,11 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
 	r = mmu_topup_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache,
 				   8 + PTE_PREFETCH_NUM);
 	if (r)
-		goto out;
+		return r;
 	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache, 8);
 	if (r)
-		goto out;
-	r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache, 4);
-out:
-	return r;
+		return r;
+	return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache, 4);
 }
 
 static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
-- 
2.26.0
