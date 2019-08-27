From: Will Deacon <will@kernel.org>
Subject: [PATCH 4/6] arm64: sysreg: Add some field definitions for PAR_EL1
Date: Tue, 27 Aug 2019 14:18:16 +0100
Message-ID: <20190827131818.14724-5-will@kernel.org>
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

PAR_EL1 is a mysterious creature, but sometimes it's necessary to read
it when translating addresses in situations where we cannot walk the
page table directly.

Add a couple of system register definitions for the fault indication
field ('F') and the fault status code ('FST').

Signed-off-by: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/sysreg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 06ebcfef73df..2b229c23f3c1 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -212,6 +212,9 @@
 #define SYS_FAR_EL1			sys_reg(3, 0, 6, 0, 0)
 #define SYS_PAR_EL1			sys_reg(3, 0, 7, 4, 0)
 
+#define SYS_PAR_EL1_F			BIT(1)
+#define SYS_PAR_EL1_FST			GENMASK(6, 1)
+
 /*** Statistical Profiling Extension ***/
 /* ID registers */
 #define SYS_PMSIDR_EL1			sys_reg(3, 0, 9, 9, 7)
-- 
2.11.0
