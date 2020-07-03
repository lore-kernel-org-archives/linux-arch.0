Return-Path: <SRS0=KQoP=AO=vger.kernel.org=linux-arch-owner@kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3196 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726263AbgGCCgL (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 2 Jul 2020 22:36:11 -0400
From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 07/21] KVM: x86/mmu: Topup memory caches after walking GVA->GPA
Date: Thu,  2 Jul 2020 19:35:31 -0700
Message-ID: <20200703023545.8771-8-sean.j.christopherson@intel.com>
In-Reply-To: <20200703023545.8771-1-sean.j.christopherson@intel.com>
References: <20200703023545.8771-1-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Sean Christopherson <sean.j.christopherson@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Wanpeng Li <wanpengli@tencent.com>, Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org, kvm@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>, Peter Feiner <pfeiner@google.com>, Peter Shier <pshier@google.com>, Junaid Shahid <junaids@google.com>, Christoffer Dall <christoffer.dall@arm.com>
Message-ID: <20200703023531.z44j2tpKhOxOoK0RTTVRiSJJkL9EmSJShZmTyNqK4Cc@z>

Topup memory caches after walking the GVA->GPA translation during a
shadow page fault, there is no need to ensure the caches are full when
walking the GVA.  As of commit f5a1e9f89504f ("KVM: MMU: remove call
to kvm_mmu_pte_write from walk_addr"), the FNAME(walk_addr) flow no
longer add rmaps via kvm_mmu_pte_write().

This avoids allocating memory in the case that the GVA is unmapped in
the guest, and also provides a paper trail of why/when the memory caches
need to be filled.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 58234bfaca07..451d7aa7d959 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -788,10 +788,6 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 
 	pgprintk("%s: addr %lx err %x\n", __func__, addr, error_code);
 
-	r = mmu_topup_memory_caches(vcpu);
-	if (r)
-		return r;
-
 	/*
 	 * If PFEC.RSVD is set, this is a shadow page fault.
 	 * The bit needs to be cleared before walking guest page tables.
@@ -819,6 +815,10 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
 		return RET_PF_EMULATE;
 	}
 
+	r = mmu_topup_memory_caches(vcpu);
+	if (r)
+		return r;
+
 	vcpu->arch.write_fault_to_shadow_pgtable = false;
 
 	is_self_change_mapping = FNAME(is_self_change_mapping)(vcpu,
-- 
2.26.0
