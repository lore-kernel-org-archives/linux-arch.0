From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Subject: [RFC v2 5/7] jump_label: port __jump_table to linker
	tables
Date: Fri, 19 Feb 2016 05:45:57 -0800
Message-ID: <1455889559-9428-6-git-send-email-mcgrof@kernel.org>
References: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xen.org>
In-Reply-To: <1455889559-9428-1-git-send-email-mcgrof@kernel.org>
List-Unsubscribe: <http://lists.xen.org/cgi-bin/mailman/options/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xen.org>
List-Help: <mailto:xen-devel-request@lists.xen.org?subject=help>
List-Subscribe: <http://lists.xen.org/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xen.org?subject=subscribe>
Sender: xen-devel-bounces@lists.xen.org
Errors-To: xen-devel-bounces@lists.xen.org
To: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc: benh@kernel.crashing.org, ming.lei@canonical.com, masami.hiramatsu.pt@hitachi.com, linux-arch@vger.kernel.org, xen-devel@lists.xensource.com, linux@arm.linux.org.uk, x86@kernel.org, anil.s.keshavamurthy@intel.com, arnd@arndb.de, rusty@rustcorp.com.au, jbaron@akamai.com, boris.ostrovsky@oracle.com, andriy.shevchenko@linux.intel.com, mcb30@ipxe.org, jgross@suse.com, ananth@in.ibm.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, luto@amacapital.net, "Luis R. Rodriguez" <mcgrof@kernel.org>, david.vrabel@citrix.com, dwmw2@infradead.org, davem@davemloft.net
List-Id: linux-arch.vger.kernel.org

Move the __jump_table from the a custom section solution
to a generic solution, this avoiding extra vmlinux.lds.h
customizations.

This also demos the use of the .data (SECTION_DATA)
linker tables and of push_section_tbl().

Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
---
 arch/arm/include/asm/jump_label.h     |  4 ++--
 arch/arm64/include/asm/jump_label.h   |  4 ++--
 arch/mips/include/asm/jump_label.h    |  4 ++--
 arch/powerpc/include/asm/jump_label.h |  6 +++---
 arch/s390/include/asm/jump_label.h    |  4 ++--
 arch/sparc/include/asm/jump_label.h   |  4 ++--
 arch/x86/include/asm/jump_label.h     |  9 +++++----
 include/asm-generic/vmlinux.lds.h     |  4 ----
 include/linux/jump_label.h            |  5 +++--
 kernel/jump_label.c                   | 16 +++++++++-------
 kernel/module.c                       |  4 +++-
 11 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/arch/arm/include/asm/jump_label.h b/arch/arm/include/asm/jump_label.h
index 34f7b6980d21..c1df4f105df3 100644
--- a/arch/arm/include/asm/jump_label.h
+++ b/arch/arm/include/asm/jump_label.h
@@ -12,7 +12,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 {
 	asm_volatile_goto("1:\n\t"
 		 WASM(nop) "\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		 ".word 1b, %l[l_yes], %c0\n\t"
 		 ".popsection\n\t"
 		 : :  "i" (&((char *)key)[branch]) :  : l_yes);
@@ -26,7 +26,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm_volatile_goto("1:\n\t"
 		 WASM(b) " %l[l_yes]\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		 ".word 1b, %l[l_yes], %c0\n\t"
 		 ".popsection\n\t"
 		 : :  "i" (&((char *)key)[branch]) :  : l_yes);
diff --git a/arch/arm64/include/asm/jump_label.h b/arch/arm64/include/asm/jump_label.h
index 1b5e0e843c3a..18f5ca294eaa 100644
--- a/arch/arm64/include/asm/jump_label.h
+++ b/arch/arm64/include/asm/jump_label.h
@@ -29,7 +29,7 @@
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm goto("1: nop\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
 		 ".popsection\n\t"
@@ -43,7 +43,7 @@ l_yes:
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
 	asm goto("1: b %l[l_yes]\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		 ".align 3\n\t"
 		 ".quad 1b, %l[l_yes], %c0\n\t"
 		 ".popsection\n\t"
diff --git a/arch/mips/include/asm/jump_label.h b/arch/mips/include/asm/jump_label.h
index e77672539e8e..13e70e290830 100644
--- a/arch/mips/include/asm/jump_label.h
+++ b/arch/mips/include/asm/jump_label.h
@@ -30,7 +30,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 {
 	asm_volatile_goto("1:\t" NOP_INSN "\n\t"
 		"nop\n\t"
-		".pushsection __jump_table,  \"aw\"\n\t"
+		push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"
 		: :  "i" (&((char *)key)[branch]) : : l_yes);
@@ -44,7 +44,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm_volatile_goto("1:\tj %l[l_yes]\n\t"
 		"nop\n\t"
-		".pushsection __jump_table,  \"aw\"\n\t"
+		push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		WORD_INSN " 1b, %l[l_yes], %0\n\t"
 		".popsection\n\t"
 		: :  "i" (&((char *)key)[branch]) : : l_yes);
diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index 47e155f15433..5fffc7b12361 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -22,7 +22,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 {
 	asm_volatile_goto("1:\n\t"
 		 "nop\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
@@ -36,7 +36,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm_volatile_goto("1:\n\t"
 		 "b %l[l_yes]\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		 JUMP_ENTRY_TYPE "1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
@@ -61,7 +61,7 @@ struct jump_entry {
 #else
 #define ARCH_STATIC_BRANCH(LABEL, KEY)		\
 1098:	nop;					\
-	.pushsection __jump_table, "aw";	\
+	.pushsection .data.tbl.__jump_table.all, "aw";	\
 	FTR_ENTRY_LONG 1098b, LABEL, KEY;	\
 	.popsection
 #endif
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 7f9fd5e3f1bf..1ebfb7ddcb11 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -15,7 +15,7 @@
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("0:	brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
-		".pushsection __jump_table, \"aw\"\n"
+		".pushsection .data.tbl.__jump_table.all, \"aw\"\n"
 		".balign 8\n"
 		".quad 0b, %l[label], %0\n"
 		".popsection\n"
@@ -29,7 +29,7 @@ label:
 static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("0:	brcl 15, %l[label]\n"
-		".pushsection __jump_table, \"aw\"\n"
+		".pushsection .data.tbl.__jump_table.all, \"aw\"\n"
 		".balign 8\n"
 		".quad 0b, %l[label], %0\n"
 		".popsection\n"
diff --git a/arch/sparc/include/asm/jump_label.h b/arch/sparc/include/asm/jump_label.h
index 62d0354d1727..848bece455bb 100644
--- a/arch/sparc/include/asm/jump_label.h
+++ b/arch/sparc/include/asm/jump_label.h
@@ -12,7 +12,7 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 	asm_volatile_goto("1:\n\t"
 		 "nop\n\t"
 		 "nop\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		 ".align 4\n\t"
 		 ".word 1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
@@ -28,7 +28,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	asm_volatile_goto("1:\n\t"
 		 "b %l[l_yes]\n\t"
 		 "nop\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
+		 push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		 ".align 4\n\t"
 		 ".word 1b, %l[l_yes], %c0\n\t"
 		 ".popsection \n\t"
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index adc54c12cbd1..5b80a0e755df 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -29,12 +29,13 @@
 
 #include <linux/stringify.h>
 #include <linux/types.h>
+#include <asm-generic/sections.h>
 
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
 	asm_volatile_goto("1:"
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
+		push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		_ASM_ALIGN "\n\t"
 		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
 		".popsection \n\t"
@@ -50,7 +51,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	asm_volatile_goto("1:"
 		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
 		"2:\n\t"
-		".pushsection __jump_table,  \"aw\" \n\t"
+		push_section_tbl(SECTION_DATA, __jump_table, all, aw)
 		_ASM_ALIGN "\n\t"
 		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
 		".popsection \n\t"
@@ -85,7 +86,7 @@ struct jump_entry {
 	.else
 	.byte		STATIC_KEY_INIT_NOP
 	.endif
-	.pushsection __jump_table, "aw"
+	.pushsection .data.tbl.__jump_table.all, "aw"
 	_ASM_ALIGN
 	_ASM_PTR	.Lstatic_jump_\@, \target, \key
 	.popsection
@@ -101,7 +102,7 @@ struct jump_entry {
 	.long		\target - .Lstatic_jump_after_\@
 .Lstatic_jump_after_\@:
 	.endif
-	.pushsection __jump_table, "aw"
+	.pushsection .data.tbl.__jump_table.all, "aw"
 	_ASM_ALIGN
 	_ASM_PTR	.Lstatic_jump_\@, \target, \key + 1
 	.popsection
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 91815fb1f2fa..11e1adcbcb24 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -210,10 +210,6 @@
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
-	. = ALIGN(8);                                                   \
-	VMLINUX_SYMBOL(__start___jump_table) = .;                       \
-	*(__jump_table)                                                 \
-	VMLINUX_SYMBOL(__stop___jump_table) = .;                        \
 	. = ALIGN(8);							\
 	VMLINUX_SYMBOL(__start___verbose) = .;                          \
 	*(__verbose)                                                    \
diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 0536524bb9eb..42b68b1e4a39 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -1,6 +1,8 @@
 #ifndef _LINUX_JUMP_LABEL_H
 #define _LINUX_JUMP_LABEL_H
 
+#include <linux/tables.h>
+
 /*
  * Jump label support
  *
@@ -138,8 +140,7 @@ static __always_inline bool static_key_true(struct static_key *key)
 	return !arch_static_branch(key, true);
 }
 
-extern struct jump_entry __start___jump_table[];
-extern struct jump_entry __stop___jump_table[];
+DECLARE_LINKTABLE_DATA(struct jump_entry, __jump_table);
 
 extern void jump_label_init(void);
 extern void jump_label_lock(void);
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 05254eeb4b4e..66d6e24148be 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -17,6 +17,8 @@
 
 #ifdef HAVE_JUMP_LABEL
 
+DEFINE_LINKTABLE_DATA(struct jump_entry, __jump_table);
+
 /* mutex to protect coming/going of the the jump_label table */
 static DEFINE_MUTEX(jump_label_mutex);
 
@@ -200,15 +202,14 @@ static void __jump_label_update(struct static_key *key,
 
 void __init jump_label_init(void)
 {
-	struct jump_entry *iter_start = __start___jump_table;
-	struct jump_entry *iter_stop = __stop___jump_table;
 	struct static_key *key = NULL;
 	struct jump_entry *iter;
 
 	jump_label_lock();
-	jump_label_sort_entries(iter_start, iter_stop);
+	jump_label_sort_entries(LINKTABLE_START(__jump_table),
+				LINKTABLE_END(__jump_table));
 
-	for (iter = iter_start; iter < iter_stop; iter++) {
+	LINKTABLE_FOR_EACH(iter, __jump_table) {
 		struct static_key *iterk;
 
 		/* rewrite NOPs */
@@ -450,8 +451,9 @@ early_initcall(jump_label_init_module);
  */
 int jump_label_text_reserved(void *start, void *end)
 {
-	int ret = __jump_label_text_reserved(__start___jump_table,
-			__stop___jump_table, start, end);
+	int ret = __jump_label_text_reserved(LINKTABLE_START(__jump_table),
+					     LINKTABLE_END(__jump_table),
+					     start, end);
 
 	if (ret)
 		return ret;
@@ -464,7 +466,7 @@ int jump_label_text_reserved(void *start, void *end)
 
 static void jump_label_update(struct static_key *key)
 {
-	struct jump_entry *stop = __stop___jump_table;
+	struct jump_entry *stop = LINKTABLE_END(__jump_table);
 	struct jump_entry *entry = static_key_entries(key);
 #ifdef CONFIG_MODULES
 	struct module *mod;
diff --git a/kernel/module.c b/kernel/module.c
index 9537da37ce87..42249ee8e462 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2930,7 +2930,9 @@ static int find_module_sections(struct module *mod, struct load_info *info)
 					     &mod->num_tracepoints);
 #endif
 #ifdef HAVE_JUMP_LABEL
-	mod->jump_entries = section_objs(info, "__jump_table",
+	mod->jump_entries = section_objs(info,
+					SECTION_TBL(SECTION_DATA,
+						    __jump_table,),
 					sizeof(*mod->jump_entries),
 					&mod->num_jump_entries);
 #endif
-- 
2.7.0
