From: Zong Li <zong@andestech.com>
Subject: [PATCH] module: Add the print format of Elf_Addr for 32/64-bit compatibly
Date: Tue, 17 Jul 2018 11:05:56 +0800
Message-ID: <1531796756-16982-1-git-send-email-zong@andestech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: palmer@sifive.com, aou@eecs.berkeley.edu, arnd@arndb.de, schwab@suse.de, hch@infradead.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: zongbox@gmail.com, greentime@andestech.com, Zong Li <zong@andestech.com>
List-Id: linux-arch.vger.kernel.org

Use a similar way like fixed width integer types in inttypes.h.

For the ELF, the Elf32_Addr is int type and Elf64_Addr is long long
type. It is opposite to definition of inttypes.h, so the Elf_Addr cannot
re-use the header.

In many architectures, the module loader only print the message of
module name and relocation type except the address information. We can
print the address correctly without compile warning by using PRIdEA,
PRIxEA and so on.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/kernel/module.c   | 13 +++++++------
 include/asm-generic/module.h |  9 +++++++++
 2 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 3303ed2cd419..d839528e491a 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -16,11 +16,12 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/moduleloader.h>
+#include <asm-generic/module.h>
 
 static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	if (v != (u32)v) {
-		pr_err("%s: value %016llx out of range for 32-bit field\n",
+		pr_err("%s: value %016" PRIxEA "out of range for 32-bit field\n",
 		       me->name, v);
 		return -EINVAL;
 	}
@@ -101,7 +102,7 @@ static int apply_r_riscv_pcrel_hi20_rela(struct module *me, u32 *location,
 
 	if (offset != (s32)offset) {
 		pr_err(
-		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+		  "%s: target %016" PRIxEA "can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, v, location);
 		return -EINVAL;
 	}
@@ -143,7 +144,7 @@ static int apply_r_riscv_hi20_rela(struct module *me, u32 *location,
 
 	if (IS_ENABLED(CMODEL_MEDLOW)) {
 		pr_err(
-		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+		  "%s: target %016" PRIxEA "can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, v, location);
 		return -EINVAL;
 	}
@@ -187,7 +188,7 @@ static int apply_r_riscv_got_hi20_rela(struct module *me, u32 *location,
 		offset = (void *)offset - (void *)location;
 	} else {
 		pr_err(
-		  "%s: can not generate the GOT entry for symbol = %016llx from PC = %p\n",
+		  "%s: can not generate the GOT entry for symbol = %016" PRIxEA "from PC = %p\n",
 		  me->name, v, location);
 		return -EINVAL;
 	}
@@ -211,7 +212,7 @@ static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
 			offset = (void *)offset - (void *)location;
 		} else {
 			pr_err(
-			  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+			  "%s: target %016" PRIxEA "can not be addressed by the 32-bit offset from PC = %p\n",
 			  me->name, v, location);
 			return -EINVAL;
 		}
@@ -233,7 +234,7 @@ static int apply_r_riscv_call_rela(struct module *me, u32 *location,
 
 	if (offset != fill_v) {
 		pr_err(
-		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
+		  "%s: target %016" PRIxEA "can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, v, location);
 		return -EINVAL;
 	}
diff --git a/include/asm-generic/module.h b/include/asm-generic/module.h
index 98e1541b72b7..d358f2414e5e 100644
--- a/include/asm-generic/module.h
+++ b/include/asm-generic/module.h
@@ -27,6 +27,7 @@ struct mod_arch_specific
 #endif
 #define ELF_R_TYPE(X)	ELF64_R_TYPE(X)
 #define ELF_R_SYM(X)	ELF64_R_SYM(X)
+#define ELF_ADDR_PREFIX "ll"
 
 #else /* CONFIG_64BIT */
 
@@ -44,6 +45,14 @@ struct mod_arch_specific
 #endif
 #define ELF_R_TYPE(X)	ELF32_R_TYPE(X)
 #define ELF_R_SYM(X)	ELF32_R_SYM(X)
+#define ELF_ADDR_PREFIX
 #endif
 
+#define PRIdEA	ELF_ADDR_PREFIX "d" /* signed decimal */
+#define PRIiEA	ELF_ADDR_PREFIX "i" /* signed decimal */
+#define PRIuEA	ELF_ADDR_PREFIX "u" /* unsigned decimal */
+#define PRIoEA	ELF_ADDR_PREFIX "o" /* unsigned octal */
+#define PRIxEA	ELF_ADDR_PREFIX "x" /* unsigned lowercase hexadecimal */
+#define PRIXEA	ELF_ADDR_PREFIX "X" /* unsigned uppercase hexadecimal */
+
 #endif /* __ASM_GENERIC_MODULE_H */
-- 
2.16.1
