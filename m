From: Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v3 20/21] KVM: MIPS: Account pages used for GPA page tables
Date: Thu,  2 Jul 2020 19:35:44 -0700
Message-ID: <20200703023545.8771-21-sean.j.christopherson@intel.com>
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

Use GFP_KERNEL_ACCOUNT instead of GFP_KERNEL when allocating pages for
the the GPA page tables.  The primary motivation for accounting the
allocations is to align with the common KVM memory cache helpers in
preparation for moving to the common implementation in a future patch.
The actual accounting is a bonus side effect.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
---
 arch/mips/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index d1f148db2449..9d3c8c025624 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -32,7 +32,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
 	if (cache->nobjs >= min)
 		return 0;
 	while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
-		page = (void *)__get_free_page(GFP_KERNEL);
+		page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
 		if (!page)
 			return -ENOMEM;
 		cache->objects[cache->nobjs++] = page;
-- 
2.26.0
