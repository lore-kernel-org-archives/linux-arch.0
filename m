From: "Jan Beulich" <JBeulich@suse.com>
Subject: [PATCH, resend] allow putting the exception table into .rodata
 (and do so on x86)
Date: Mon, 02 Jun 2014 15:54:27 +0100
Message-ID: <538CAC430200007800016ED3@mail.emea.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kbuild-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kbuild-owner@vger.kernel.org
To: mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com
Cc: x86@kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

This is since the table is really a set of pointers, i.e. misplaced in
.text. There are no runtime writes to this table (and if an arch needs
to do boot time writes but the table is already r/o - on x86 it isn't -
it simply shouldn't make use of the new construct).

Quite likely other architectures would want to follow.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
---
 arch/x86/include/asm/sections.h   |    2 +-
 arch/x86/kernel/vmlinux.lds.S     |    5 +++--
 arch/x86/mm/init_64.c             |    6 +++---
 include/asm-generic/vmlinux.lds.h |    5 +++++
 4 files changed, 12 insertions(+), 6 deletions(-)

--- 3.15-rc8/arch/x86/include/asm/sections.h
+++ 3.15-rc8-extable-in-rodata/arch/x86/include/asm/sections.h
@@ -5,7 +5,7 @@
 #include <asm/uaccess.h>
 
 extern char __brk_base[], __brk_limit[];
-extern struct exception_table_entry __stop___ex_table[];
+extern const void __stop_notes;
 
 #if defined(CONFIG_X86_64) && defined(CONFIG_DEBUG_RODATA)
 extern char __end_rodata_hpage_align[];
--- 3.15-rc8/arch/x86/kernel/vmlinux.lds.S
+++ 3.15-rc8-extable-in-rodata/arch/x86/kernel/vmlinux.lds.S
@@ -20,6 +20,8 @@
 #define LOAD_OFFSET __START_KERNEL_map
 #endif
 
+#define EXCEPTION_TABLE_RO EXCEPTION_TABLE(16)
+
 #include <asm-generic/vmlinux.lds.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
@@ -109,8 +111,7 @@ SECTIONS
 	} :text = 0x9090
 
 	NOTES :text :note
-
-	EXCEPTION_TABLE(16) :text = 0x9090
+	text_continues : {} :text /* switch back to regular text... */
 
 #if defined(CONFIG_DEBUG_RODATA)
 	/* .text should occupy whole number of pages */
--- 3.15-rc8/arch/x86/mm/init_64.c
+++ 3.15-rc8-extable-in-rodata/arch/x86/mm/init_64.c
@@ -1070,7 +1070,7 @@ int kernel_set_to_readonly;
 void set_kernel_text_rw(void)
 {
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = PFN_ALIGN(__stop___ex_table);
+	unsigned long end = PFN_ALIGN(_etext);
 
 	if (!kernel_set_to_readonly)
 		return;
@@ -1089,7 +1089,7 @@ void set_kernel_text_rw(void)
 void set_kernel_text_ro(void)
 {
 	unsigned long start = PFN_ALIGN(_text);
-	unsigned long end = PFN_ALIGN(__stop___ex_table);
+	unsigned long end = PFN_ALIGN(_etext);
 
 	if (!kernel_set_to_readonly)
 		return;
@@ -1108,7 +1108,7 @@ void mark_rodata_ro(void)
 	unsigned long start = PFN_ALIGN(_text);
 	unsigned long rodata_start = PFN_ALIGN(__start_rodata);
 	unsigned long end = (unsigned long) &__end_rodata_hpage_align;
-	unsigned long text_end = PFN_ALIGN(&__stop___ex_table);
+	unsigned long text_end = PFN_ALIGN(&__stop_notes);
 	unsigned long rodata_end = PFN_ALIGN(&__end_rodata);
 	unsigned long all_end = PFN_ALIGN(&_end);
 
--- 3.15-rc8/include/asm-generic/vmlinux.lds.h
+++ 3.15-rc8-extable-in-rodata/include/asm-generic/vmlinux.lds.h
@@ -263,6 +263,7 @@
 		*(.rodata1)						\
 	}								\
 									\
+	EXCEPTION_TABLE_RO						\
 	BUG_TABLE							\
 									\
 	/* PCI quirks */						\
@@ -479,6 +480,10 @@
 		VMLINUX_SYMBOL(__stop___ex_table) = .;			\
 	}
 
+#ifndef EXCEPTION_TABLE_RO
+#define EXCEPTION_TABLE_RO
+#endif
+
 /*
  * Init task
  */



