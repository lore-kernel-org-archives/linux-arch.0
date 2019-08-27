From: Will Deacon <will@kernel.org>
Subject: [PATCH 3/6] arm64: mm: Add ISB instruction to set_pgd()
Date: Tue, 27 Aug 2019 14:18:15 +0100
Message-ID: <20190827131818.14724-4-will@kernel.org>
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

Commit 6a4cbd63c25a ("Revert "arm64: Remove unnecessary ISBs from
set_{pte,pmd,pud}"") reintroduced ISB instructions to some of our
page table setter functions in light of a recent clarification to the
Armv8 architecture. Although 'set_pgd()' isn't currently used to update
a live page table, add the ISB instruction there too for consistency
with the other macros and to provide some future-proofing if we use it
on live tables in the future.

Reported-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index feda7294320c..2faa77635942 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -605,6 +605,7 @@ static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
 
 	WRITE_ONCE(*pgdp, pgd);
 	dsb(ishst);
+	isb();
 }
 
 static inline void pgd_clear(pgd_t *pgdp)
-- 
2.11.0
