From: Will Deacon <will@kernel.org>
Subject: [PATCH 6/6] arm64: kvm: Replace hardcoded '1' with SYS_PAR_EL1_F
Date: Tue, 27 Aug 2019 14:18:18 +0100
Message-ID: <20190827131818.14724-7-will@kernel.org>
References: <20190827131818.14724-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190827131818.14724-1-will@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-arch@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>
List-Id: linux-arch.vger.kernel.org

Now that we have a definition for the 'F' field of PAR_EL1, use that
instead of coding the immediate directly.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/kvm/hyp/switch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index adaf266d8de8..bd978ad71936 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -264,7 +264,7 @@ static bool __hyp_text __translate_far_to_hpfar(u64 far, u64 *hpfar)
 	tmp = read_sysreg(par_el1);
 	write_sysreg(par, par_el1);
 
-	if (unlikely(tmp & 1))
+	if (unlikely(tmp & SYS_PAR_EL1_F))
 		return false; /* Translation failed, back to guest */
 
 	/* Convert PAR to HPFAR format */
-- 
2.11.0
