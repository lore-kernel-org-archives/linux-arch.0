From: changbin.du@intel.com
Subject: [PATCH v4 4/4] asm-generic: fix build error in fix_to_virt with CONFIG_CC_OPTIMIZE_FOR_DEBUGGING
Date: Wed,  9 May 2018 16:43:16 +0800
Message-ID: <1525855396-7908-5-git-send-email-changbin.du@intel.com>
References: <1525855396-7908-1-git-send-email-changbin.du@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525855396-7908-1-git-send-email-changbin.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yamada.masahiro@socionext.com, michal.lkml@markovi.net, tglx@linutronix.de, mingo@redhat.com, akpm@linux-foundation.org
Cc: rostedt@goodmis.org, rdunlap@infradead.org, x86@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, arnd@arndb.de, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Changbin Du <changbin.du@intel.com>
List-Id: linux-arch.vger.kernel.org

From: Changbin Du <changbin.du@intel.com>

With '-Og' optimization level, GCC would not optimize a count for a loop
as a constant value. But BUILD_BUG_ON() only accept compile-time constant
values. Let's use __fix_to_virt() to avoid the error.

arch/arm/mm/mmu.o: In function `fix_to_virt':
/home/changbin/work/linux/./include/asm-generic/fixmap.h:31: undefined reference to `__compiletime_assert_31'
Makefile:1051: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1

Signed-off-by: Changbin Du <changbin.du@intel.com>

---
v2: use __fix_to_virt() to fix the issue.
---
 arch/arm/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index e46a6a4..c08d74e 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1599,7 +1599,7 @@ static void __init early_fixmap_shutdown(void)
 		pte_t *pte;
 		struct map_desc map;
 
-		map.virtual = fix_to_virt(i);
+		map.virtual = __fix_to_virt(i);
 		pte = pte_offset_early_fixmap(pmd_off_k(map.virtual), map.virtual);
 
 		/* Only i/o device mappings are supported ATM */
-- 
2.7.4
