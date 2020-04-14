From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v4 01/14] h8300: remove usage of __ARCH_USE_5LEVEL_HACK
Date: Tue, 14 Apr 2020 18:34:42 +0300
Message-ID: <20200414153455.21744-2-rppt@kernel.org>
References: <20200414153455.21744-1-rppt@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20200414153455.21744-1-rppt@kernel.org>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, linux-sh@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>, linux-hexagon@vger.kernel.org, Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu, Jonas Bonn <jonas@southpole.se>, linux-arch@vger.kernel.org, Brian Cain <bcain@codeaurora.org>, Marc Zyngier <maz@kernel.org>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Mike Rapoport <rppt@linux.ibm.com>, Catalin Marinas <catalin.marinas@arm.com>, uclinux-h8-devel@lists.sourceforge.jp, Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>, kvm-ppc@vger.kernel.org, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, openrisc@lists.librecores.org, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@p>
List-Id: linux-arch.vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

h8300 is a nommu architecture and does not require fixup for upper layers
of the page tables because it is already handled by the generic nommu
implementation.

Remove definition of __ARCH_USE_5LEVEL_HACK in
arch/h8300/include/asm/pgtable.h

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/h8300/include/asm/pgtable.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/h8300/include/asm/pgtable.h b/arch/h8300/include/asm/pgtable.h
index 4d00152fab58..f00828720dc4 100644
--- a/arch/h8300/include/asm/pgtable.h
+++ b/arch/h8300/include/asm/pgtable.h
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _H8300_PGTABLE_H
 #define _H8300_PGTABLE_H
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopud.h>
 #include <asm-generic/pgtable.h>
 extern void paging_init(void);
-- 
2.25.1
