From: =?UTF-8?B?dGlwLWJvdCBmb3IgS2VlcyBDb29rIDx0aXBib3RAenl0b3IuY29tPg==?=@zytor.com
Subject: =?UTF-8?B?W3RpcDptbS9yZWFkb25seV0geDg2L21tOiBBbHdheXMgZW5hYmxlIENPTkZJR18=?=
 =?UTF-8?B?REVCVUdfUk9EQVRBIGFuZCByZW1vdmUgdGhlIEtjb25maWcgb3B0aW9u?=
Date: Mon, 22 Feb 2016 04:19:09 -0800
Message-ID: <tip-9ccaf77cf05915f51231d158abfd5448aedde758@git.kernel.org>
References: <1455748879-21872-4-git-send-email-keescook@chromium.org>
Reply-To: keescook@chromium.org, arnd@arndb.de, peterz@infradead.org,
	  tglx@linutronix.de, brgerst@gmail.com, mpe@ellerman.id.au,
	  dvlasenk@redhat.com, linux-arch@vger.kernel.org,
	  luto@amacapital.net, bp@alien8.de, re.emese@gmail.com,
	  linux-kernel@vger.kernel.org, pageexec@freemail.hu,
	  hpa@zytor.com, minipli@googlemail.com, david.brown@linaro.org,
	  torvalds@linux-foundation.org, mingo@kernel.org
Mime-Version: =?UTF-8?B?MS4w?=
Content-Type: =?UTF-8?B?dGV4dC9wbGFpbjsgY2hhcnNldD1VVEYtOA==?=
Content-Transfer-Encoding: =?UTF-8?B?OGJpdA==?=
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455748879-21872-4-git-send-email-keescook@chromium.org>
Content-Disposition: =?UTF-8?B?aW5saW5l?=
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?B?bGludXgtdGlwLWNvbW1pdHNAdmdlci5rZXJuZWwub3Jn?=@zytor.com
Cc: arnd@arndb.de, keescook@chromium.org, mpe@ellerman.id.au, peterz@infradead.org, tglx@linutronix.de, brgerst@gmail.com, dvlasenk@redhat.com, re.emese@gmail.com, bp@alien8.de, luto@amacapital.net, linux-arch@vger.kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, pageexec@freemail.hu, minipli@googlemail.com, david.brown@linaro.org, torvalds@linux-foundation.org, mingo@kernel.org
List-Id: linux-arch.vger.kernel.org

Commit-ID:  9ccaf77cf05915f51231d158abfd5448aedde758
Gitweb:     http://git.kernel.org/tip/9ccaf77cf05915f51231d158abfd5448aedde758
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Wed, 17 Feb 2016 14:41:14 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 22 Feb 2016 08:51:38 +0100

x86/mm: Always enable CONFIG_DEBUG_RODATA and remove the Kconfig option

This removes the CONFIG_DEBUG_RODATA option and makes it always enabled.

This simplifies the code and also makes it clearer that read-only mapped
memory is just as fundamental a security feature in kernel-space as it is
in user-space.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Brown <david.brown@linaro.org>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: Emese Revfy <re.emese@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathias Krause <minipli@googlemail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: PaX Team <pageexec@freemail.hu>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: kernel-hardening@lists.openwall.com
Cc: linux-arch <linux-arch@vger.kernel.org>
Link: http://lkml.kernel.org/r/1455748879-21872-4-git-send-email-keescook@chromium.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/Kconfig                  |  3 +++
 arch/x86/Kconfig.debug            | 18 +++---------------
 arch/x86/include/asm/cacheflush.h |  5 -----
 arch/x86/include/asm/kvm_para.h   |  7 -------
 arch/x86/include/asm/sections.h   |  2 +-
 arch/x86/kernel/ftrace.c          |  6 +++---
 arch/x86/kernel/kgdb.c            |  8 ++------
 arch/x86/kernel/test_nx.c         |  2 --
 arch/x86/kernel/test_rodata.c     |  2 +-
 arch/x86/kernel/vmlinux.lds.S     | 25 +++++++++++--------------
 arch/x86/mm/init_32.c             |  3 ---
 arch/x86/mm/init_64.c             |  3 ---
 arch/x86/mm/pageattr.c            |  2 +-
 13 files changed, 25 insertions(+), 61 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c46662f..b105105 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -303,6 +303,9 @@ config ARCH_SUPPORTS_UPROBES
 config FIX_EARLYCON_MEM
 	def_bool y
 
+config DEBUG_RODATA
+	def_bool y
+
 config PGTABLE_LEVELS
 	int
 	default 4 if X86_64
diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 9b18ed9..7816b7b 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -74,28 +74,16 @@ config EFI_PGT_DUMP
 	  issues with the mapping of the EFI runtime regions into that
 	  table.
 
-config DEBUG_RODATA
-	bool "Write protect kernel read-only data structures"
-	default y
-	depends on DEBUG_KERNEL
-	---help---
-	  Mark the kernel read-only data as write-protected in the pagetables,
-	  in order to catch accidental (and incorrect) writes to such const
-	  data. This is recommended so that we can catch kernel bugs sooner.
-	  If in doubt, say "Y".
-
 config DEBUG_RODATA_TEST
-	bool "Testcase for the DEBUG_RODATA feature"
-	depends on DEBUG_RODATA
+	bool "Testcase for the marking rodata read-only"
 	default y
 	---help---
-	  This option enables a testcase for the DEBUG_RODATA
-	  feature as well as for the change_page_attr() infrastructure.
+	  This option enables a testcase for the setting rodata read-only
+	  as well as for the change_page_attr() infrastructure.
 	  If in doubt, say "N"
 
 config DEBUG_WX
 	bool "Warn on W+X mappings at boot"
-	depends on DEBUG_RODATA
 	select X86_PTDUMP_CORE
 	---help---
 	  Generate a warning if any W+X mappings are found at boot.
diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index c8cff75..61518cf 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -91,15 +91,10 @@ void clflush_cache_range(void *addr, unsigned int size);
 
 #define mmio_flush_range(addr, size) clflush_cache_range(addr, size)
 
-#ifdef CONFIG_DEBUG_RODATA
 extern const int rodata_test_data;
 extern int kernel_set_to_readonly;
 void set_kernel_text_rw(void);
 void set_kernel_text_ro(void);
-#else
-static inline void set_kernel_text_rw(void) { }
-static inline void set_kernel_text_ro(void) { }
-#endif
 
 #ifdef CONFIG_DEBUG_RODATA_TEST
 int rodata_test(void);
diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index c1adf33..bc62e7c 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -17,15 +17,8 @@ static inline bool kvm_check_and_clear_guest_paused(void)
 }
 #endif /* CONFIG_KVM_GUEST */
 
-#ifdef CONFIG_DEBUG_RODATA
 #define KVM_HYPERCALL \
         ALTERNATIVE(".byte 0x0f,0x01,0xc1", ".byte 0x0f,0x01,0xd9", X86_FEATURE_VMMCALL)
-#else
-/* On AMD processors, vmcall will generate a trap that we will
- * then rewrite to the appropriate instruction.
- */
-#define KVM_HYPERCALL ".byte 0x0f,0x01,0xc1"
-#endif
 
 /* For KVM hypercalls, a three-byte sequence of either the vmcall or the vmmcall
  * instruction.  The hypervisor may replace it with something else but only the
diff --git a/arch/x86/include/asm/sections.h b/arch/x86/include/asm/sections.h
index 0a52424..13b6cdd 100644
--- a/arch/x86/include/asm/sections.h
+++ b/arch/x86/include/asm/sections.h
@@ -7,7 +7,7 @@
 extern char __brk_base[], __brk_limit[];
 extern struct exception_table_entry __stop___ex_table[];
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_DEBUG_RODATA)
+#if defined(CONFIG_X86_64)
 extern char __end_rodata_hpage_align[];
 #endif
 
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 29408d6..05c9e3f 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -81,9 +81,9 @@ within(unsigned long addr, unsigned long start, unsigned long end)
 static unsigned long text_ip_addr(unsigned long ip)
 {
 	/*
-	 * On x86_64, kernel text mappings are mapped read-only with
-	 * CONFIG_DEBUG_RODATA. So we use the kernel identity mapping instead
-	 * of the kernel text mapping to modify the kernel text.
+	 * On x86_64, kernel text mappings are mapped read-only, so we use
+	 * the kernel identity mapping instead of the kernel text mapping
+	 * to modify the kernel text.
 	 *
 	 * For 32bit kernels, these mappings are same and we can use
 	 * kernel identity mapping to modify code.
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index 44256a6..ed15cd48 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -750,9 +750,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 {
 	int err;
-#ifdef CONFIG_DEBUG_RODATA
 	char opc[BREAK_INSTR_SIZE];
-#endif /* CONFIG_DEBUG_RODATA */
 
 	bpt->type = BP_BREAKPOINT;
 	err = probe_kernel_read(bpt->saved_instr, (char *)bpt->bpt_addr,
@@ -761,7 +759,6 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 		return err;
 	err = probe_kernel_write((char *)bpt->bpt_addr,
 				 arch_kgdb_ops.gdb_bpt_instr, BREAK_INSTR_SIZE);
-#ifdef CONFIG_DEBUG_RODATA
 	if (!err)
 		return err;
 	/*
@@ -778,13 +775,12 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 	if (memcmp(opc, arch_kgdb_ops.gdb_bpt_instr, BREAK_INSTR_SIZE))
 		return -EINVAL;
 	bpt->type = BP_POKE_BREAKPOINT;
-#endif /* CONFIG_DEBUG_RODATA */
+
 	return err;
 }
 
 int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 {
-#ifdef CONFIG_DEBUG_RODATA
 	int err;
 	char opc[BREAK_INSTR_SIZE];
 
@@ -801,8 +797,8 @@ int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 	if (err || memcmp(opc, bpt->saved_instr, BREAK_INSTR_SIZE))
 		goto knl_write;
 	return err;
+
 knl_write:
-#endif /* CONFIG_DEBUG_RODATA */
 	return probe_kernel_write((char *)bpt->bpt_addr,
 				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
 }
diff --git a/arch/x86/kernel/test_nx.c b/arch/x86/kernel/test_nx.c
index 3f92ce0..27538f1 100644
--- a/arch/x86/kernel/test_nx.c
+++ b/arch/x86/kernel/test_nx.c
@@ -142,7 +142,6 @@ static int test_NX(void)
 	 * by the error message
 	 */
 
-#ifdef CONFIG_DEBUG_RODATA
 	/* Test 3: Check if the .rodata section is executable */
 	if (rodata_test_data != 0xC3) {
 		printk(KERN_ERR "test_nx: .rodata marker has invalid value\n");
@@ -151,7 +150,6 @@ static int test_NX(void)
 		printk(KERN_ERR "test_nx: .rodata section is executable\n");
 		ret = -ENODEV;
 	}
-#endif
 
 #if 0
 	/* Test 4: Check if the .data section of a module is executable */
diff --git a/arch/x86/kernel/test_rodata.c b/arch/x86/kernel/test_rodata.c
index 5ecbfe5..cb4a01b 100644
--- a/arch/x86/kernel/test_rodata.c
+++ b/arch/x86/kernel/test_rodata.c
@@ -76,5 +76,5 @@ int rodata_test(void)
 }
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Testcase for the DEBUG_RODATA infrastructure");
+MODULE_DESCRIPTION("Testcase for marking rodata as read-only");
 MODULE_AUTHOR("Arjan van de Ven <arjan@linux.intel.com>");
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 74e4bf1..fe133b7 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -41,29 +41,28 @@ ENTRY(phys_startup_64)
 jiffies_64 = jiffies;
 #endif
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_DEBUG_RODATA)
+#if defined(CONFIG_X86_64)
 /*
- * On 64-bit, align RODATA to 2MB so that even with CONFIG_DEBUG_RODATA
- * we retain large page mappings for boundaries spanning kernel text, rodata
- * and data sections.
+ * On 64-bit, align RODATA to 2MB so we retain large page mappings for
+ * boundaries spanning kernel text, rodata and data sections.
  *
  * However, kernel identity mappings will have different RWX permissions
  * to the pages mapping to text and to the pages padding (which are freed) the
  * text section. Hence kernel identity mappings will be broken to smaller
  * pages. For 64-bit, kernel text and kernel identity mappings are different,
- * so we can enable protection checks that come with CONFIG_DEBUG_RODATA,
- * as well as retain 2MB large page mappings for kernel text.
+ * so we can enable protection checks as well as retain 2MB large page
+ * mappings for kernel text.
  */
-#define X64_ALIGN_DEBUG_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
+#define X64_ALIGN_RODATA_BEGIN	. = ALIGN(HPAGE_SIZE);
 
-#define X64_ALIGN_DEBUG_RODATA_END				\
+#define X64_ALIGN_RODATA_END					\
 		. = ALIGN(HPAGE_SIZE);				\
 		__end_rodata_hpage_align = .;
 
 #else
 
-#define X64_ALIGN_DEBUG_RODATA_BEGIN
-#define X64_ALIGN_DEBUG_RODATA_END
+#define X64_ALIGN_RODATA_BEGIN
+#define X64_ALIGN_RODATA_END
 
 #endif
 
@@ -112,13 +111,11 @@ SECTIONS
 
 	EXCEPTION_TABLE(16) :text = 0x9090
 
-#if defined(CONFIG_DEBUG_RODATA)
 	/* .text should occupy whole number of pages */
 	. = ALIGN(PAGE_SIZE);
-#endif
-	X64_ALIGN_DEBUG_RODATA_BEGIN
+	X64_ALIGN_RODATA_BEGIN
 	RO_DATA(PAGE_SIZE)
-	X64_ALIGN_DEBUG_RODATA_END
+	X64_ALIGN_RODATA_END
 
 	/* Data */
 	.data : AT(ADDR(.data) - LOAD_OFFSET) {
diff --git a/arch/x86/mm/init_32.c b/arch/x86/mm/init_32.c
index cb4ef3d..2ebfbaf 100644
--- a/arch/x86/mm/init_32.c
+++ b/arch/x86/mm/init_32.c
@@ -871,7 +871,6 @@ static noinline int do_test_wp_bit(void)
 	return flag;
 }
 
-#ifdef CONFIG_DEBUG_RODATA
 const int rodata_test_data = 0xC3;
 EXPORT_SYMBOL_GPL(rodata_test_data);
 
@@ -960,5 +959,3 @@ void mark_rodata_ro(void)
 	if (__supported_pte_mask & _PAGE_NX)
 		debug_checkwx();
 }
-#endif
-
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 5488d21..a40b755 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1074,7 +1074,6 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 }
 
-#ifdef CONFIG_DEBUG_RODATA
 const int rodata_test_data = 0xC3;
 EXPORT_SYMBOL_GPL(rodata_test_data);
 
@@ -1166,8 +1165,6 @@ void mark_rodata_ro(void)
 	debug_checkwx();
 }
 
-#endif
-
 int kern_addr_valid(unsigned long addr)
 {
 	unsigned long above = ((long)addr) >> __VIRTUAL_MASK_SHIFT;
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 2440814..2450488 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -283,7 +283,7 @@ static inline pgprot_t static_protections(pgprot_t prot, unsigned long address,
 		   __pa_symbol(__end_rodata) >> PAGE_SHIFT))
 		pgprot_val(forbidden) |= _PAGE_RW;
 
-#if defined(CONFIG_X86_64) && defined(CONFIG_DEBUG_RODATA)
+#if defined(CONFIG_X86_64)
 	/*
 	 * Once the kernel maps the text as RO (kernel_set_to_readonly is set),
 	 * kernel text mappings for the large page aligned text, rodata sections
