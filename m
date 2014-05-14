From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 01/27] arm64: Override defaults from generic/tlb.h
Date: Wed, 14 May 2014 20:59:33 +0200
Message-ID: <1400093999-18703-2-git-send-email-richard@nod.at>
References: <1400093999-18703-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1400093999-18703-1-git-send-email-richard@nod.at>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arch@vger.kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org
Cc: Steve Capper <steve.capper@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Will Deacon <will.deacon@arm.com>, Michal Hocko <mhocko@suse.cz>, Catalin Marinas <catalin.marinas@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

Make sure to not conflict with the defaults provided
by generic/tlb.h.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Michal Hocko <mhocko@suse.cz>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/arm64/include/asm/tlb.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 80e2c08..65a474d 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -19,7 +19,14 @@
 #ifndef __ASM_TLB_H
 #define __ASM_TLB_H
 
+/* These defines are needed to override the defaults from asm-generic/tlb.h */
 #define  __tlb_remove_pmd_tlb_entry __tlb_remove_pmd_tlb_entry
+#define tlb_start_vma tlb_start_vma
+#define tlb_end_vma tlb_end_vma
+#define __tlb_remove_tlb_entry __tlb_remove_tlb_entry
+#define tlb_flush tlb_flush
+#define __pte_free_tlb __pte_free_tlb
+#define __pmd_free_tlb __pmd_free_tlb
 
 #include <asm-generic/tlb.h>
 
-- 
1.8.4.2
