From: David Brazdil <dbrazdil@google.com>
Subject: [PATCH 9/9] kvm: arm64: Remove unnecessary hyp mappings
Date: Wed, 22 Jul 2020 17:44:24 +0100
Message-ID: <20200722164424.42225-10-dbrazdil@google.com>
References: <20200722164424.42225-1-dbrazdil@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200722164424.42225-1-dbrazdil@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, Arnd Bergmann <arnd@arndb.de>
Cc: James Morse <james.morse@arm.com>, Julien Thierry <julien.thierry.kdev@gmail.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arch@vger.kernel.org, kernel-team@google.com, David Brazdil <dbrazdil@google.com>
List-Id: linux-arch.vger.kernel.org

With all nVHE per-CPU variables being part of the hyp per-CPU region,
mapping them individual is not necessary any longer. They are mapped to hyp
as part of the overall per-CPU region.

Signed-off-by: David Brazdil <dbrazdil@google.com>
---
 arch/arm64/include/asm/kvm_mmu.h | 25 +++++++------------------
 arch/arm64/kvm/arm.c             | 17 +----------------
 2 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index e9e5875274cb..1a66089cf4f4 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -531,28 +531,17 @@ static inline int kvm_map_vectors(void)
 DECLARE_PER_CPU_READ_MOSTLY(u64, arm64_ssbd_callback_required);
 DECLARE_KVM_NVHE_PER_CPU(u64, arm64_ssbd_callback_required);
 
-static inline int hyp_init_aux_data(void)
+static inline void hyp_init_aux_data(void)
 {
-	int cpu, err;
+	int cpu;
 
-	for_each_possible_cpu(cpu) {
-		u64 *ptr;
-
-		ptr = per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu);
-		err = create_hyp_mappings(ptr, ptr + 1, PAGE_HYP);
-		if (err)
-			return err;
-
-		/* Copy value from kernel to hyp. */
-		*ptr = per_cpu(arm64_ssbd_callback_required, cpu);
-	}
-	return 0;
+	/* Copy arm64_ssbd_callback_required values from kernel to hyp. */
+	for_each_possible_cpu(cpu)
+		*(per_cpu_ptr_nvhe(arm64_ssbd_callback_required, cpu)) =
+			per_cpu(arm64_ssbd_callback_required, cpu);
 }
 #else
-static inline int hyp_init_aux_data(void)
-{
-	return 0;
-}
+static inline void hyp_init_aux_data(void) {}
 #endif
 
 #define kvm_phys_to_vttbr(addr)		phys_to_ttbr(addr)
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index bbbc5c1519a9..f2e537d99d2b 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1628,22 +1628,7 @@ static int init_hyp_mode(void)
 		}
 	}
 
-	for_each_possible_cpu(cpu) {
-		kvm_host_data_t *cpu_data;
-
-		cpu_data = per_cpu_ptr_hyp(kvm_host_data, cpu);
-		err = create_hyp_mappings(cpu_data, cpu_data + 1, PAGE_HYP);
-
-		if (err) {
-			kvm_err("Cannot map host CPU state: %d\n", err);
-			goto out_err;
-		}
-	}
-
-	err = hyp_init_aux_data();
-	if (err)
-		kvm_err("Cannot map host auxiliary data: %d\n", err);
-
+	hyp_init_aux_data();
 	return 0;
 
 out_err:
-- 
2.27.0
