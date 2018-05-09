From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 7/8] vmlinux.lds.h: remove no-op macro VMLINUX_SYMBOL()
Date: Wed,  9 May 2018 16:23:51 +0900
Message-ID: <1525850632-10921-8-git-send-email-yamada.masahiro@socionext.com>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>, Sam Ravnborg <sam@ravnborg.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Now that VMLINUX_SYMBOL() is no-op, clean up the linker script.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/vmlinux.lds.h | 289 +++++++++++++++++++-------------------
 1 file changed, 144 insertions(+), 145 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9efb82a..e373e2e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -113,66 +113,66 @@
 
 #ifdef CONFIG_FTRACE_MCOUNT_RECORD
 #define MCOUNT_REC()	. = ALIGN(8);				\
-			VMLINUX_SYMBOL(__start_mcount_loc) = .; \
+			__start_mcount_loc = .;			\
 			KEEP(*(__mcount_loc))			\
-			VMLINUX_SYMBOL(__stop_mcount_loc) = .;
+			__stop_mcount_loc = .;
 #else
 #define MCOUNT_REC()
 #endif
 
 #ifdef CONFIG_TRACE_BRANCH_PROFILING
-#define LIKELY_PROFILE()	VMLINUX_SYMBOL(__start_annotated_branch_profile) = .; \
-				KEEP(*(_ftrace_annotated_branch))		      \
-				VMLINUX_SYMBOL(__stop_annotated_branch_profile) = .;
+#define LIKELY_PROFILE()	__start_annotated_branch_profile = .;	\
+				KEEP(*(_ftrace_annotated_branch))	\
+				__stop_annotated_branch_profile = .;
 #else
 #define LIKELY_PROFILE()
 #endif
 
 #ifdef CONFIG_PROFILE_ALL_BRANCHES
-#define BRANCH_PROFILE()	VMLINUX_SYMBOL(__start_branch_profile) = .;   \
-				KEEP(*(_ftrace_branch))			      \
-				VMLINUX_SYMBOL(__stop_branch_profile) = .;
+#define BRANCH_PROFILE()	__start_branch_profile = .;		\
+				KEEP(*(_ftrace_branch))			\
+				__stop_branch_profile = .;
 #else
 #define BRANCH_PROFILE()
 #endif
 
 #ifdef CONFIG_KPROBES
 #define KPROBE_BLACKLIST()	. = ALIGN(8);				      \
-				VMLINUX_SYMBOL(__start_kprobe_blacklist) = .; \
+				__start_kprobe_blacklist = .;		      \
 				KEEP(*(_kprobe_blacklist))		      \
-				VMLINUX_SYMBOL(__stop_kprobe_blacklist) = .;
+				__stop_kprobe_blacklist = .;
 #else
 #define KPROBE_BLACKLIST()
 #endif
 
 #ifdef CONFIG_FUNCTION_ERROR_INJECTION
 #define ERROR_INJECT_WHITELIST()	STRUCT_ALIGN();			      \
-			VMLINUX_SYMBOL(__start_error_injection_whitelist) = .;\
+			__start_error_injection_whitelist = .;		      \
 			KEEP(*(_error_injection_whitelist))		      \
-			VMLINUX_SYMBOL(__stop_error_injection_whitelist) = .;
+			__stop_error_injection_whitelist = .;
 #else
 #define ERROR_INJECT_WHITELIST()
 #endif
 
 #ifdef CONFIG_EVENT_TRACING
 #define FTRACE_EVENTS()	. = ALIGN(8);					\
-			VMLINUX_SYMBOL(__start_ftrace_events) = .;	\
+			__start_ftrace_events = .;			\
 			KEEP(*(_ftrace_events))				\
-			VMLINUX_SYMBOL(__stop_ftrace_events) = .;	\
-			VMLINUX_SYMBOL(__start_ftrace_eval_maps) = .;	\
+			__stop_ftrace_events = .;			\
+			__start_ftrace_eval_maps = .;			\
 			KEEP(*(_ftrace_eval_map))			\
-			VMLINUX_SYMBOL(__stop_ftrace_eval_maps) = .;
+			__stop_ftrace_eval_maps = .;
 #else
 #define FTRACE_EVENTS()
 #endif
 
 #ifdef CONFIG_TRACING
-#define TRACE_PRINTKS() VMLINUX_SYMBOL(__start___trace_bprintk_fmt) = .;      \
+#define TRACE_PRINTKS()	 __start___trace_bprintk_fmt = .;      \
 			 KEEP(*(__trace_printk_fmt)) /* Trace_printk fmt' pointer */ \
-			 VMLINUX_SYMBOL(__stop___trace_bprintk_fmt) = .;
-#define TRACEPOINT_STR() VMLINUX_SYMBOL(__start___tracepoint_str) = .;	\
+			 __stop___trace_bprintk_fmt = .;
+#define TRACEPOINT_STR() __start___tracepoint_str = .;	\
 			 KEEP(*(__tracepoint_str)) /* Trace_printk fmt' pointer */ \
-			 VMLINUX_SYMBOL(__stop___tracepoint_str) = .;
+			 __stop___tracepoint_str = .;
 #else
 #define TRACE_PRINTKS()
 #define TRACEPOINT_STR()
@@ -180,27 +180,27 @@
 
 #ifdef CONFIG_FTRACE_SYSCALLS
 #define TRACE_SYSCALLS() . = ALIGN(8);					\
-			 VMLINUX_SYMBOL(__start_syscalls_metadata) = .;	\
+			 __start_syscalls_metadata = .;			\
 			 KEEP(*(__syscalls_metadata))			\
-			 VMLINUX_SYMBOL(__stop_syscalls_metadata) = .;
+			 __stop_syscalls_metadata = .;
 #else
 #define TRACE_SYSCALLS()
 #endif
 
 #ifdef CONFIG_BPF_EVENTS
 #define BPF_RAW_TP() STRUCT_ALIGN();					\
-			 VMLINUX_SYMBOL(__start__bpf_raw_tp) = .;	\
+			 __start__bpf_raw_tp = .;			\
 			 KEEP(*(__bpf_raw_tp_map))			\
-			 VMLINUX_SYMBOL(__stop__bpf_raw_tp) = .;
+			 __stop__bpf_raw_tp = .;
 #else
 #define BPF_RAW_TP()
 #endif
 
 #ifdef CONFIG_SERIAL_EARLYCON
 #define EARLYCON_TABLE() . = ALIGN(8);				\
-			 VMLINUX_SYMBOL(__earlycon_table) = .;	\
+			 __earlycon_table = .;			\
 			 KEEP(*(__earlycon_table))		\
-			 VMLINUX_SYMBOL(__earlycon_table_end) = .;
+			 __earlycon_table_end = .;
 #else
 #define EARLYCON_TABLE()
 #endif
@@ -211,7 +211,7 @@
 #define _OF_TABLE_0(name)
 #define _OF_TABLE_1(name)						\
 	. = ALIGN(8);							\
-	VMLINUX_SYMBOL(__##name##_of_table) = .;			\
+	__##name##_of_table = .;					\
 	KEEP(*(__##name##_of_table))					\
 	KEEP(*(__##name##_of_table_end))
 
@@ -226,18 +226,18 @@
 #ifdef CONFIG_ACPI
 #define ACPI_PROBE_TABLE(name)						\
 	. = ALIGN(8);							\
-	VMLINUX_SYMBOL(__##name##_acpi_probe_table) = .;		\
+	__##name##_acpi_probe_table = .;				\
 	KEEP(*(__##name##_acpi_probe_table))				\
-	VMLINUX_SYMBOL(__##name##_acpi_probe_table_end) = .;
+	__##name##_acpi_probe_table_end = .;
 #else
 #define ACPI_PROBE_TABLE(name)
 #endif
 
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
-	VMLINUX_SYMBOL(__dtb_start) = .;				\
+	__dtb_start = .;						\
 	KEEP(*(.dtb.init.rodata))					\
-	VMLINUX_SYMBOL(__dtb_end) = .;
+	__dtb_end = .;
 
 /*
  * .data section
@@ -250,20 +250,20 @@
 	MEM_KEEP(init.data*)						\
 	MEM_KEEP(exit.data*)						\
 	*(.data.unlikely)						\
-	VMLINUX_SYMBOL(__start_once) = .;				\
+	__start_once = .;						\
 	*(.data.once)							\
-	VMLINUX_SYMBOL(__end_once) = .;					\
+	__end_once = .;							\
 	STRUCT_ALIGN();							\
 	*(__tracepoints)						\
 	/* implement dynamic printk debug */				\
 	. = ALIGN(8);                                                   \
-	VMLINUX_SYMBOL(__start___jump_table) = .;                       \
+	__start___jump_table = .;					\
 	KEEP(*(__jump_table))                                           \
-	VMLINUX_SYMBOL(__stop___jump_table) = .;                        \
+	__stop___jump_table = .;					\
 	. = ALIGN(8);							\
-	VMLINUX_SYMBOL(__start___verbose) = .;                          \
+	__start___verbose = .;						\
 	KEEP(*(__verbose))                                              \
-	VMLINUX_SYMBOL(__stop___verbose) = .;				\
+	__stop___verbose = .;						\
 	LIKELY_PROFILE()		       				\
 	BRANCH_PROFILE()						\
 	TRACE_PRINTKS()							\
@@ -275,10 +275,10 @@
  */
 #define NOSAVE_DATA							\
 	. = ALIGN(PAGE_SIZE);						\
-	VMLINUX_SYMBOL(__nosave_begin) = .;				\
+	__nosave_begin = .;						\
 	*(.data..nosave)						\
 	. = ALIGN(PAGE_SIZE);						\
-	VMLINUX_SYMBOL(__nosave_end) = .;
+	__nosave_end = .;
 
 #define PAGE_ALIGNED_DATA(page_align)					\
 	. = ALIGN(page_align);						\
@@ -295,13 +295,13 @@
 
 #define INIT_TASK_DATA(align)						\
 	. = ALIGN(align);						\
-	VMLINUX_SYMBOL(__start_init_task) = .;				\
-	VMLINUX_SYMBOL(init_thread_union) = .;				\
-	VMLINUX_SYMBOL(init_stack) = .;					\
+	__start_init_task = .;						\
+	init_thread_union = .;						\
+	init_stack = .;							\
 	KEEP(*(.data..init_task))					\
 	KEEP(*(.data..init_thread_info))				\
-	. = VMLINUX_SYMBOL(__start_init_task) + THREAD_SIZE;		\
-	VMLINUX_SYMBOL(__end_init_task) = .;
+	. = __start_init_task + THREAD_SIZE;				\
+	__end_init_task = .;
 
 /*
  * Allow architectures to handle ro_after_init data on their
@@ -309,9 +309,9 @@
  */
 #ifndef RO_AFTER_INIT_DATA
 #define RO_AFTER_INIT_DATA						\
-	VMLINUX_SYMBOL(__start_ro_after_init) = .;			\
+	__start_ro_after_init = .;					\
 	*(.data..ro_after_init)						\
-	VMLINUX_SYMBOL(__end_ro_after_init) = .;
+	__end_ro_after_init = .;
 #endif
 
 /*
@@ -320,14 +320,14 @@
 #define RO_DATA_SECTION(align)						\
 	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
-		VMLINUX_SYMBOL(__start_rodata) = .;			\
+		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		KEEP(*(__vermagic))	/* Kernel version magic */	\
 		. = ALIGN(8);						\
-		VMLINUX_SYMBOL(__start___tracepoints_ptrs) = .;		\
+		__start___tracepoints_ptrs = .;				\
 		KEEP(*(__tracepoints_ptrs)) /* Tracepoints: pointer array */ \
-		VMLINUX_SYMBOL(__stop___tracepoints_ptrs) = .;		\
+		__stop___tracepoints_ptrs = .;				\
 		*(__tracepoints_strings)/* Tracepoints: strings */	\
 	}								\
 									\
@@ -337,109 +337,109 @@
 									\
 	/* PCI quirks */						\
 	.pci_fixup        : AT(ADDR(.pci_fixup) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__start_pci_fixups_early) = .;		\
+		__start_pci_fixups_early = .;				\
 		KEEP(*(.pci_fixup_early))				\
-		VMLINUX_SYMBOL(__end_pci_fixups_early) = .;		\
-		VMLINUX_SYMBOL(__start_pci_fixups_header) = .;		\
+		__end_pci_fixups_early = .;				\
+		__start_pci_fixups_header = .;				\
 		KEEP(*(.pci_fixup_header))				\
-		VMLINUX_SYMBOL(__end_pci_fixups_header) = .;		\
-		VMLINUX_SYMBOL(__start_pci_fixups_final) = .;		\
+		__end_pci_fixups_header = .;				\
+		__start_pci_fixups_final = .;				\
 		KEEP(*(.pci_fixup_final))				\
-		VMLINUX_SYMBOL(__end_pci_fixups_final) = .;		\
-		VMLINUX_SYMBOL(__start_pci_fixups_enable) = .;		\
+		__end_pci_fixups_final = .;				\
+		__start_pci_fixups_enable = .;				\
 		KEEP(*(.pci_fixup_enable))				\
-		VMLINUX_SYMBOL(__end_pci_fixups_enable) = .;		\
-		VMLINUX_SYMBOL(__start_pci_fixups_resume) = .;		\
+		__end_pci_fixups_enable = .;				\
+		__start_pci_fixups_resume = .;				\
 		KEEP(*(.pci_fixup_resume))				\
-		VMLINUX_SYMBOL(__end_pci_fixups_resume) = .;		\
-		VMLINUX_SYMBOL(__start_pci_fixups_resume_early) = .;	\
+		__end_pci_fixups_resume = .;				\
+		__start_pci_fixups_resume_early = .;			\
 		KEEP(*(.pci_fixup_resume_early))			\
-		VMLINUX_SYMBOL(__end_pci_fixups_resume_early) = .;	\
-		VMLINUX_SYMBOL(__start_pci_fixups_suspend) = .;		\
+		__end_pci_fixups_resume_early = .;			\
+		__start_pci_fixups_suspend = .;				\
 		KEEP(*(.pci_fixup_suspend))				\
-		VMLINUX_SYMBOL(__end_pci_fixups_suspend) = .;		\
-		VMLINUX_SYMBOL(__start_pci_fixups_suspend_late) = .;	\
+		__end_pci_fixups_suspend = .;				\
+		__start_pci_fixups_suspend_late = .;			\
 		KEEP(*(.pci_fixup_suspend_late))			\
-		VMLINUX_SYMBOL(__end_pci_fixups_suspend_late) = .;	\
+		__end_pci_fixups_suspend_late = .;			\
 	}								\
 									\
 	/* Built-in firmware blobs */					\
 	.builtin_fw        : AT(ADDR(.builtin_fw) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__start_builtin_fw) = .;			\
+		__start_builtin_fw = .;					\
 		KEEP(*(.builtin_fw))					\
-		VMLINUX_SYMBOL(__end_builtin_fw) = .;			\
+		__end_builtin_fw = .;					\
 	}								\
 									\
 	TRACEDATA							\
 									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
-		VMLINUX_SYMBOL(__start___ksymtab) = .;			\
+		__start___ksymtab = .;					\
 		KEEP(*(SORT(___ksymtab+*)))				\
-		VMLINUX_SYMBOL(__stop___ksymtab) = .;			\
+		__stop___ksymtab = .;					\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__ksymtab_gpl     : AT(ADDR(__ksymtab_gpl) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__start___ksymtab_gpl) = .;		\
+		__start___ksymtab_gpl = .;				\
 		KEEP(*(SORT(___ksymtab_gpl+*)))				\
-		VMLINUX_SYMBOL(__stop___ksymtab_gpl) = .;		\
+		__stop___ksymtab_gpl = .;				\
 	}								\
 									\
 	/* Kernel symbol table: Normal unused symbols */		\
 	__ksymtab_unused  : AT(ADDR(__ksymtab_unused) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__start___ksymtab_unused) = .;		\
+		__start___ksymtab_unused = .;				\
 		KEEP(*(SORT(___ksymtab_unused+*)))			\
-		VMLINUX_SYMBOL(__stop___ksymtab_unused) = .;		\
+		__stop___ksymtab_unused = .;				\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only unused symbols */		\
 	__ksymtab_unused_gpl : AT(ADDR(__ksymtab_unused_gpl) - LOAD_OFFSET) { \
-		VMLINUX_SYMBOL(__start___ksymtab_unused_gpl) = .;	\
+		__start___ksymtab_unused_gpl = .;			\
 		KEEP(*(SORT(___ksymtab_unused_gpl+*)))			\
-		VMLINUX_SYMBOL(__stop___ksymtab_unused_gpl) = .;	\
+		__stop___ksymtab_unused_gpl = .;			\
 	}								\
 									\
 	/* Kernel symbol table: GPL-future-only symbols */		\
 	__ksymtab_gpl_future : AT(ADDR(__ksymtab_gpl_future) - LOAD_OFFSET) { \
-		VMLINUX_SYMBOL(__start___ksymtab_gpl_future) = .;	\
+		__start___ksymtab_gpl_future = .;			\
 		KEEP(*(SORT(___ksymtab_gpl_future+*)))			\
-		VMLINUX_SYMBOL(__stop___ksymtab_gpl_future) = .;	\
+		__stop___ksymtab_gpl_future = .;			\
 	}								\
 									\
 	/* Kernel symbol table: Normal symbols */			\
 	__kcrctab         : AT(ADDR(__kcrctab) - LOAD_OFFSET) {		\
-		VMLINUX_SYMBOL(__start___kcrctab) = .;			\
+		__start___kcrctab = .;					\
 		KEEP(*(SORT(___kcrctab+*)))				\
-		VMLINUX_SYMBOL(__stop___kcrctab) = .;			\
+		__stop___kcrctab = .;					\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only symbols */			\
 	__kcrctab_gpl     : AT(ADDR(__kcrctab_gpl) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__start___kcrctab_gpl) = .;		\
+		__start___kcrctab_gpl = .;				\
 		KEEP(*(SORT(___kcrctab_gpl+*)))				\
-		VMLINUX_SYMBOL(__stop___kcrctab_gpl) = .;		\
+		__stop___kcrctab_gpl = .;				\
 	}								\
 									\
 	/* Kernel symbol table: Normal unused symbols */		\
 	__kcrctab_unused  : AT(ADDR(__kcrctab_unused) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__start___kcrctab_unused) = .;		\
+		__start___kcrctab_unused = .;				\
 		KEEP(*(SORT(___kcrctab_unused+*)))			\
-		VMLINUX_SYMBOL(__stop___kcrctab_unused) = .;		\
+		__stop___kcrctab_unused = .;				\
 	}								\
 									\
 	/* Kernel symbol table: GPL-only unused symbols */		\
 	__kcrctab_unused_gpl : AT(ADDR(__kcrctab_unused_gpl) - LOAD_OFFSET) { \
-		VMLINUX_SYMBOL(__start___kcrctab_unused_gpl) = .;	\
+		__start___kcrctab_unused_gpl = .;			\
 		KEEP(*(SORT(___kcrctab_unused_gpl+*)))			\
-		VMLINUX_SYMBOL(__stop___kcrctab_unused_gpl) = .;	\
+		__stop___kcrctab_unused_gpl = .;			\
 	}								\
 									\
 	/* Kernel symbol table: GPL-future-only symbols */		\
 	__kcrctab_gpl_future : AT(ADDR(__kcrctab_gpl_future) - LOAD_OFFSET) { \
-		VMLINUX_SYMBOL(__start___kcrctab_gpl_future) = .;	\
+		__start___kcrctab_gpl_future = .;			\
 		KEEP(*(SORT(___kcrctab_gpl_future+*)))			\
-		VMLINUX_SYMBOL(__stop___kcrctab_gpl_future) = .;	\
+		__stop___kcrctab_gpl_future = .;			\
 	}								\
 									\
 	/* Kernel symbol table: strings */				\
@@ -456,18 +456,18 @@
 									\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
-		VMLINUX_SYMBOL(__start___param) = .;			\
+		__start___param = .;					\
 		KEEP(*(__param))					\
-		VMLINUX_SYMBOL(__stop___param) = .;			\
+		__stop___param = .;					\
 	}								\
 									\
 	/* Built-in module versions. */					\
 	__modver : AT(ADDR(__modver) - LOAD_OFFSET) {			\
-		VMLINUX_SYMBOL(__start___modver) = .;			\
+		__start___modver = .;					\
 		KEEP(*(__modver))					\
-		VMLINUX_SYMBOL(__stop___modver) = .;			\
+		__stop___modver = .;					\
 		. = ALIGN((align));					\
-		VMLINUX_SYMBOL(__end_rodata) = .;			\
+		__end_rodata = .;					\
 	}								\
 	. = ALIGN((align));
 
@@ -478,9 +478,9 @@
 
 #define SECURITY_INIT							\
 	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
-		VMLINUX_SYMBOL(__security_initcall_start) = .;		\
+		__security_initcall_start = .;				\
 		KEEP(*(.security_initcall.init))			\
-		VMLINUX_SYMBOL(__security_initcall_end) = .;		\
+		__security_initcall_end = .;				\
 	}
 
 /*
@@ -504,47 +504,47 @@
  * address even at second ld pass when generating System.map */
 #define SCHED_TEXT							\
 		ALIGN_FUNCTION();					\
-		VMLINUX_SYMBOL(__sched_text_start) = .;			\
+		__sched_text_start = .;					\
 		*(.sched.text)						\
-		VMLINUX_SYMBOL(__sched_text_end) = .;
+		__sched_text_end = .;
 
 /* spinlock.text is aling to function alignment to secure we have same
  * address even at second ld pass when generating System.map */
 #define LOCK_TEXT							\
 		ALIGN_FUNCTION();					\
-		VMLINUX_SYMBOL(__lock_text_start) = .;			\
+		__lock_text_start = .;					\
 		*(.spinlock.text)					\
-		VMLINUX_SYMBOL(__lock_text_end) = .;
+		__lock_text_end = .;
 
 #define CPUIDLE_TEXT							\
 		ALIGN_FUNCTION();					\
-		VMLINUX_SYMBOL(__cpuidle_text_start) = .;		\
+		__cpuidle_text_start = .;				\
 		*(.cpuidle.text)					\
-		VMLINUX_SYMBOL(__cpuidle_text_end) = .;
+		__cpuidle_text_end = .;
 
 #define KPROBES_TEXT							\
 		ALIGN_FUNCTION();					\
-		VMLINUX_SYMBOL(__kprobes_text_start) = .;		\
+		__kprobes_text_start = .;				\
 		*(.kprobes.text)					\
-		VMLINUX_SYMBOL(__kprobes_text_end) = .;
+		__kprobes_text_end = .;
 
 #define ENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
-		VMLINUX_SYMBOL(__entry_text_start) = .;			\
+		__entry_text_start = .;					\
 		*(.entry.text)						\
-		VMLINUX_SYMBOL(__entry_text_end) = .;
+		__entry_text_end = .;
 
 #define IRQENTRY_TEXT							\
 		ALIGN_FUNCTION();					\
-		VMLINUX_SYMBOL(__irqentry_text_start) = .;		\
+		__irqentry_text_start = .;				\
 		*(.irqentry.text)					\
-		VMLINUX_SYMBOL(__irqentry_text_end) = .;
+		__irqentry_text_end = .;
 
 #define SOFTIRQENTRY_TEXT						\
 		ALIGN_FUNCTION();					\
-		VMLINUX_SYMBOL(__softirqentry_text_start) = .;		\
+		__softirqentry_text_start = .;				\
 		*(.softirqentry.text)					\
-		VMLINUX_SYMBOL(__softirqentry_text_end) = .;
+		__softirqentry_text_end = .;
 
 /* Section used for early init (in .S files) */
 #define HEAD_TEXT  KEEP(*(.head.text))
@@ -560,9 +560,9 @@
 #define EXCEPTION_TABLE(align)						\
 	. = ALIGN(align);						\
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {		\
-		VMLINUX_SYMBOL(__start___ex_table) = .;			\
+		__start___ex_table = .;					\
 		KEEP(*(__ex_table))					\
-		VMLINUX_SYMBOL(__stop___ex_table) = .;			\
+		__stop___ex_table = .;					\
 	}
 
 /*
@@ -576,11 +576,11 @@
 
 #ifdef CONFIG_CONSTRUCTORS
 #define KERNEL_CTORS()	. = ALIGN(8);			   \
-			VMLINUX_SYMBOL(__ctors_start) = .; \
+			__ctors_start = .;		   \
 			KEEP(*(.ctors))			   \
 			KEEP(*(SORT(.init_array.*)))	   \
 			KEEP(*(.init_array))		   \
-			VMLINUX_SYMBOL(__ctors_end) = .;
+			__ctors_end = .;
 #else
 #define KERNEL_CTORS()
 #endif
@@ -715,9 +715,9 @@
 #define BUG_TABLE							\
 	. = ALIGN(8);							\
 	__bug_table : AT(ADDR(__bug_table) - LOAD_OFFSET) {		\
-		VMLINUX_SYMBOL(__start___bug_table) = .;		\
+		__start___bug_table = .;				\
 		KEEP(*(__bug_table))					\
-		VMLINUX_SYMBOL(__stop___bug_table) = .;			\
+		__stop___bug_table = .;					\
 	}
 #else
 #define BUG_TABLE
@@ -727,22 +727,22 @@
 #define ORC_UNWIND_TABLE						\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__start_orc_unwind_ip) = .;		\
+		__start_orc_unwind_ip = .;				\
 		KEEP(*(.orc_unwind_ip))					\
-		VMLINUX_SYMBOL(__stop_orc_unwind_ip) = .;		\
+		__stop_orc_unwind_ip = .;				\
 	}								\
 	. = ALIGN(6);							\
 	.orc_unwind : AT(ADDR(.orc_unwind) - LOAD_OFFSET) {		\
-		VMLINUX_SYMBOL(__start_orc_unwind) = .;			\
+		__start_orc_unwind = .;					\
 		KEEP(*(.orc_unwind))					\
-		VMLINUX_SYMBOL(__stop_orc_unwind) = .;			\
+		__stop_orc_unwind = .;					\
 	}								\
 	. = ALIGN(4);							\
 	.orc_lookup : AT(ADDR(.orc_lookup) - LOAD_OFFSET) {		\
-		VMLINUX_SYMBOL(orc_lookup) = .;				\
+		orc_lookup = .;						\
 		. += (((SIZEOF(.text) + LOOKUP_BLOCK_SIZE - 1) /	\
 			LOOKUP_BLOCK_SIZE) + 1) * 4;			\
-		VMLINUX_SYMBOL(orc_lookup_end) = .;			\
+		orc_lookup_end = .;					\
 	}
 #else
 #define ORC_UNWIND_TABLE
@@ -752,9 +752,9 @@
 #define TRACEDATA							\
 	. = ALIGN(4);							\
 	.tracedata : AT(ADDR(.tracedata) - LOAD_OFFSET) {		\
-		VMLINUX_SYMBOL(__tracedata_start) = .;			\
+		__tracedata_start = .;					\
 		KEEP(*(.tracedata))					\
-		VMLINUX_SYMBOL(__tracedata_end) = .;			\
+		__tracedata_end = .;					\
 	}
 #else
 #define TRACEDATA
@@ -762,24 +762,24 @@
 
 #define NOTES								\
 	.notes : AT(ADDR(.notes) - LOAD_OFFSET) {			\
-		VMLINUX_SYMBOL(__start_notes) = .;			\
+		__start_notes = .;					\
 		KEEP(*(.note.*))					\
-		VMLINUX_SYMBOL(__stop_notes) = .;			\
+		__stop_notes = .;					\
 	}
 
 #define INIT_SETUP(initsetup_align)					\
 		. = ALIGN(initsetup_align);				\
-		VMLINUX_SYMBOL(__setup_start) = .;			\
+		__setup_start = .;					\
 		KEEP(*(.init.setup))					\
-		VMLINUX_SYMBOL(__setup_end) = .;
+		__setup_end = .;
 
 #define INIT_CALLS_LEVEL(level)						\
-		VMLINUX_SYMBOL(__initcall##level##_start) = .;		\
+		__initcall##level##_start = .;				\
 		KEEP(*(.initcall##level##.init))			\
 		KEEP(*(.initcall##level##s.init))			\
 
 #define INIT_CALLS							\
-		VMLINUX_SYMBOL(__initcall_start) = .;			\
+		__initcall_start = .;					\
 		KEEP(*(.initcallearly.init))				\
 		INIT_CALLS_LEVEL(0)					\
 		INIT_CALLS_LEVEL(1)					\
@@ -790,22 +790,22 @@
 		INIT_CALLS_LEVEL(rootfs)				\
 		INIT_CALLS_LEVEL(6)					\
 		INIT_CALLS_LEVEL(7)					\
-		VMLINUX_SYMBOL(__initcall_end) = .;
+		__initcall_end = .;
 
 #define CON_INITCALL							\
-		VMLINUX_SYMBOL(__con_initcall_start) = .;		\
+		__con_initcall_start = .;				\
 		KEEP(*(.con_initcall.init))				\
-		VMLINUX_SYMBOL(__con_initcall_end) = .;
+		__con_initcall_end = .;
 
 #define SECURITY_INITCALL						\
-		VMLINUX_SYMBOL(__security_initcall_start) = .;		\
+		__security_initcall_start = .;				\
 		KEEP(*(.security_initcall.init))			\
-		VMLINUX_SYMBOL(__security_initcall_end) = .;
+		__security_initcall_end = .;
 
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
-	VMLINUX_SYMBOL(__initramfs_start) = .;				\
+	__initramfs_start = .;						\
 	KEEP(*(.init.ramfs))						\
 	. = ALIGN(8);							\
 	KEEP(*(.init.ramfs.info))
@@ -860,7 +860,7 @@
  * sharing between subsections for different purposes.
  */
 #define PERCPU_INPUT(cacheline)						\
-	VMLINUX_SYMBOL(__per_cpu_start) = .;				\
+	__per_cpu_start = .;						\
 	*(.data..percpu..first)						\
 	. = ALIGN(PAGE_SIZE);						\
 	*(.data..percpu..page_aligned)					\
@@ -870,7 +870,7 @@
 	*(.data..percpu)						\
 	*(.data..percpu..shared_aligned)				\
 	PERCPU_DECRYPTED_SECTION					\
-	VMLINUX_SYMBOL(__per_cpu_end) = .;
+	__per_cpu_end = .;
 
 /**
  * PERCPU_VADDR - define output section for percpu area
@@ -897,12 +897,11 @@
  * address, use PERCPU_SECTION.
  */
 #define PERCPU_VADDR(cacheline, vaddr, phdr)				\
-	VMLINUX_SYMBOL(__per_cpu_load) = .;				\
-	.data..percpu vaddr : AT(VMLINUX_SYMBOL(__per_cpu_load)		\
-				- LOAD_OFFSET) {			\
+	__per_cpu_load = .;						\
+	.data..percpu vaddr : AT(__per_cpu_load - LOAD_OFFSET) {	\
 		PERCPU_INPUT(cacheline)					\
 	} phdr								\
-	. = VMLINUX_SYMBOL(__per_cpu_load) + SIZEOF(.data..percpu);
+	. = __per_cpu_load + SIZEOF(.data..percpu);
 
 /**
  * PERCPU_SECTION - define output section for percpu area, simple version
@@ -919,7 +918,7 @@
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\
 	.data..percpu	: AT(ADDR(.data..percpu) - LOAD_OFFSET) {	\
-		VMLINUX_SYMBOL(__per_cpu_load) = .;			\
+		__per_cpu_load = .;					\
 		PERCPU_INPUT(cacheline)					\
 	}
 
@@ -958,9 +957,9 @@
 #define INIT_TEXT_SECTION(inittext_align)				\
 	. = ALIGN(inittext_align);					\
 	.init.text : AT(ADDR(.init.text) - LOAD_OFFSET) {		\
-		VMLINUX_SYMBOL(_sinittext) = .;				\
+		_sinittext = .;						\
 		INIT_TEXT						\
-		VMLINUX_SYMBOL(_einittext) = .;				\
+		_einittext = .;						\
 	}
 
 #define INIT_DATA_SECTION(initsetup_align)				\
@@ -975,8 +974,8 @@
 
 #define BSS_SECTION(sbss_align, bss_align, stop_align)			\
 	. = ALIGN(sbss_align);						\
-	VMLINUX_SYMBOL(__bss_start) = .;				\
+	__bss_start = .;						\
 	SBSS(sbss_align)						\
 	BSS(bss_align)							\
 	. = ALIGN(stop_align);						\
-	VMLINUX_SYMBOL(__bss_stop) = .;
+	__bss_stop = .;
-- 
2.7.4
