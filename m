From: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] kbuild: put kallsyms into its own section
Date: Tue,  1 Nov 2016 16:38:52 +1100
Message-ID: <20161101053852.2440-1-npiggin@gmail.com>
Return-path: <linux-kbuild-owner@vger.kernel.org>
Sender: linux-kbuild-owner@vger.kernel.org
To: Michal Marek <mmarek@suse.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

kallsyms gets put into rodata, which can get put into the middle of the
object file. This means that when the kallsyms section is linked in, the
two halves of the object file get further apart, and that can require new
linker stubs to be added (as is the case with very large powerpc64 builds).
These new linker stubs add new names, which break kallsyms, resulting in
the "inconsistent kallsyms" error.

It is possible on powerpc to have the linker not give them names, but
that makes disassembly extremely difficult to follow. Doing an extra pass
usually solves it, but in theory the next pass could result in slightly
larger kallsyms again, which then adds yet another stub name and fails.
In general we also would prefer not to add those extra stubs at all.

Putting kallsyms right at the end of the image can avoid these problems.
So put kallsyms data into its own section, and allow it to be overridden.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/vmlinux.lds.S |  6 ++++++
 include/asm-generic/vmlinux.lds.h | 12 ++++++++++++
 kernel/kallsyms.c                 | 22 ++++++++++++++--------
 scripts/kallsyms.c                |  2 +-
 4 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 28ebe1a..05f4ae1 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -262,6 +262,15 @@
 #define RO_AFTER_INIT_DATA *(.data..ro_after_init)
 #endif
 
+#ifndef CONFIG_ARCH_PLACES_KALLSYMS
+#define KALLSYMS							\
+	__kallsyms : AT(ADDR(__kallsyms) - LOAD_OFFSET) {		\
+		KEEP(*(.kallsyms))					\
+	}
+#else
+#define KALLSYMS
+#endif
+
 /*
  * Read only Data
  */
@@ -419,6 +428,9 @@
 		. = ALIGN((align));					\
 		VMLINUX_SYMBOL(__end_rodata) = .;			\
 	}								\
+									\
+	KALLSYMS							\
+									\
 	. = ALIGN((align));
 
 /* RODATA & RO_DATA provided for backward compatibility.
diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index fafd1a3..311fe07 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -37,24 +37,30 @@
  * These will be re-linked against their real values
  * during the second link stage.
  */
-extern const unsigned long kallsyms_addresses[] __weak;
-extern const int kallsyms_offsets[] __weak;
-extern const u8 kallsyms_names[] __weak;
+extern const unsigned long kallsyms_addresses[]
+__attribute__((weak, section(".kallsyms")));
+extern const int kallsyms_offsets[]
+__attribute__((weak, section(".kallsyms")));
+extern const u8 kallsyms_names[]
+__attribute__((weak, section(".kallsyms")));
 
 /*
  * Tell the compiler that the count isn't in the small data section if the arch
  * has one (eg: FRV).
  */
 extern const unsigned long kallsyms_num_syms
-__attribute__((weak, section(".rodata")));
+__attribute__((weak, section(".kallsyms")));
 
 extern const unsigned long kallsyms_relative_base
-__attribute__((weak, section(".rodata")));
+__attribute__((weak, section(".kallsyms")));
 
-extern const u8 kallsyms_token_table[] __weak;
-extern const u16 kallsyms_token_index[] __weak;
+extern const u8 kallsyms_token_table[]
+__attribute__((weak, section(".kallsyms")));
+extern const u16 kallsyms_token_index[]
+__attribute__((weak, section(".kallsyms")));
 
-extern const unsigned long kallsyms_markers[] __weak;
+extern const unsigned long kallsyms_markers[]
+__attribute__((weak, section(".kallsyms")));
 
 static inline int is_kernel_inittext(unsigned long addr)
 {
diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index 1f22a18..4327d80 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -349,7 +349,7 @@ static void write_src(void)
 	printf("#define ALGN .align 4\n");
 	printf("#endif\n");
 
-	printf("\t.section .rodata, \"a\"\n");
+	printf("\t.section .kallsyms, \"a\"\n");
 
 	/* Provide proper symbols relocatability by their relativeness
 	 * to a fixed anchor point in the runtime image, either '_text'
-- 
2.9.3

