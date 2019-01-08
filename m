From: guoren@kernel.org
Subject: [PATCH 2/5] csky: fixup relocation error with 807 & 860
Date: Wed,  9 Jan 2019 00:26:35 +0800
Message-ID: <1546964798-30067-2-git-send-email-guoren@kernel.org>
References: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546964798-30067-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tglx@linutronix.de, marc.zyngier@arm.com, arnd@arndb.de
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, mhocko@kernel.org, torvalds@linux-foundation.org, linux@roeck-us.net, Guo Ren <ren_guo@c-sky.com>, Hui Kai <huikai@acoinfo.com>
List-Id: linux-arch.vger.kernel.org

From: Guo Ren <ren_guo@c-sky.com>

810 doesn't support jsri instruction and csky-as will leave
jsri + nop for relocation. Module-probe need replace them with
lrw + jsr.

Signed-off-by: Guo Ren <ren_guo@c-sky.com>
Cc: Hui Kai <huikai@acoinfo.com>
---
 arch/csky/kernel/module.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
index 65abab0..0b028ee 100644
--- a/arch/csky/kernel/module.c
+++ b/arch/csky/kernel/module.c
@@ -12,7 +12,7 @@
 #include <linux/spinlock.h>
 #include <asm/pgtable.h>
 
-#if defined(__CSKYABIV2__)
+#ifdef CONFIG_CPU_CK810
 #define IS_BSR32(hi16, lo16)		(((hi16) & 0xFC00) == 0xE000)
 #define IS_JSRI32(hi16, lo16)		((hi16) == 0xEAE0)
 
@@ -25,6 +25,26 @@
 	*(uint16_t *)(addr) = 0xE8Fa;		\
 	*((uint16_t *)(addr) + 1) = 0x0000;	\
 } while (0)
+
+static void jsri_2_lrw_jsr(uint32_t *location)
+{
+	uint16_t location_tmp = (uint16_t *)location;
+
+	if (IS_BSR32(*location_tmp, *(location_tmp + 1)))
+		return;
+
+	if (IS_JSRI32(*location_tmp, *(location_tmp + 1))) {
+		/* jsri 0x...  --> lrw r26, 0x... */
+		CHANGE_JSRI_TO_LRW(location);
+		/* lsli r0, r0 --> jsr r26 */
+		SET_JSR32_R26(location + 1);
+	}
+}
+#else
+static void inline jsri_2_lrw_jsr(uint32_t *location)
+{
+	return;
+}
 #endif
 
 int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
@@ -35,9 +55,6 @@ int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
 	Elf32_Sym	*sym;
 	uint32_t	*location;
 	short		*temp;
-#if defined(__CSKYABIV2__)
-	uint16_t	*location_tmp;
-#endif
 
 	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
 		/* This is where to make the change */
@@ -59,18 +76,7 @@ int apply_relocate_add(Elf32_Shdr *sechdrs, const char *strtab,
 		case R_CSKY_PCRELJSR_IMM11BY2:
 			break;
 		case R_CSKY_PCRELJSR_IMM26BY2:
-#if defined(__CSKYABIV2__)
-			location_tmp = (uint16_t *)location;
-			if (IS_BSR32(*location_tmp, *(location_tmp + 1)))
-				break;
-
-			if (IS_JSRI32(*location_tmp, *(location_tmp + 1))) {
-				/* jsri 0x...  --> lrw r26, 0x... */
-				CHANGE_JSRI_TO_LRW(location);
-				/* lsli r0, r0 --> jsr r26 */
-				SET_JSR32_R26(location + 1);
-			}
-#endif
+			jsri_2_lrw_jsr(location);
 			break;
 		case R_CSKY_ADDR_HI16:
 			temp = ((short  *)location) + 1;
-- 
2.7.4
