Return-Path: <rppt@kernel.org>
From: Mike Rapoport <rppt@kernel.org>
Subject: [PATCH v2 11/13] unicore32: remove __ARCH_USE_5LEVEL_HACK
Date: Sun, 16 Feb 2020 10:18:41 +0200
Message-ID: <20200216081843.28670-12-rppt@kernel.org>
In-Reply-To: <20200216081843.28670-1-rppt@kernel.org>
References: <20200216081843.28670-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Brian Cain <bcain@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@c-s.fr>, Fenghua Yu <fenghua.yu@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Guan Xuetao <gxt@pku.edu.cn>, James Morse <james.morse@arm.com>, Jonas Bonn <jonas@southpole.se>, Julien Thierry <julien.thierry.kdev@gmail.com>, Ley Foon Tan <ley.foon.tan@intel.com>, Marc Zyngier <maz@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, Rich Felker <dalias@libc.org>, Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Suzuki K Poulose <suzuki.poulose@arm.com>, Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, uclinux-h8-devel@lists.sourceforge.jp, Mike Rapoport <rppt@kernel.org>, Mike Rapoport <rppt@linux.ibm.com>
List-ID: <linux-arch.vger.kernel.org>
Message-ID: <20200216081841.xUEritmh6DxfkcKokADl-GH58qREmwhG3DJZP8MdGfI@z>

From: Mike Rapoport <rppt@linux.ibm.com>

The unicore32 architecture has 2 level page tables and
asm-generic/pgtable-nopmd.h and explicit casts from pud_t to pgd_t for page
table folding.

Add p4d walk in the only place that actually unfolds the pud level and
remove __ARCH_USE_5LEVEL_HACK.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/unicore32/include/asm/pgtable.h | 1 -
 arch/unicore32/kernel/hibernate.c    | 4 +++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/unicore32/include/asm/pgtable.h b/arch/unicore32/include/asm/pgtable.h
index c8f7ba12f309..82030c32fc05 100644
--- a/arch/unicore32/include/asm/pgtable.h
+++ b/arch/unicore32/include/asm/pgtable.h
@@ -9,7 +9,6 @@
 #ifndef __UNICORE_PGTABLE_H__
 #define __UNICORE_PGTABLE_H__
 
-#define __ARCH_USE_5LEVEL_HACK
 #include <asm-generic/pgtable-nopmd.h>
 #include <asm/cpu-single.h>
 
diff --git a/arch/unicore32/kernel/hibernate.c b/arch/unicore32/kernel/hibernate.c
index f3812245cc00..ccad051a79b6 100644
--- a/arch/unicore32/kernel/hibernate.c
+++ b/arch/unicore32/kernel/hibernate.c
@@ -33,9 +33,11 @@ struct swsusp_arch_regs swsusp_arch_regs_cpu0;
 static pmd_t *resume_one_md_table_init(pgd_t *pgd)
 {
 	pud_t *pud;
+	p4d_t *p4d;
 	pmd_t *pmd_table;
 
-	pud = pud_offset(pgd, 0);
+	p4d = p4d_offset(pgd, 0);
+	pud = pud_offset(p4d, 0);
 	pmd_table = pmd_offset(pud, 0);
 
 	return pmd_table;
-- 
2.24.0
