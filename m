From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3/7] vmlinux.lds: preserve eh_frame for DWARF unwinder
Date: Fri,  5 May 2017 14:21:56 +0200
Message-ID: <20170505122200.31436-3-jslaby@suse.cz>
References: <20170505122200.31436-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170505122200.31436-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: akpm@linux-foundation.org
Cc: torvalds@linux-foundation.org, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

If we choose to use the DWARF unwinder, we need to preserve the eh_frame
section. So define EH_FRAME macro to contain it in vmlinux.lds.h. We
also define symbols __start_unwind_hdr/__end_unwind_hdr and
__start_unwind/__end_unwind to use in the code.

The config option proper is added at the end of the series.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org
---
 arch/x86/tools/relocs.c           |  1 +
 include/asm-generic/vmlinux.lds.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 73eb7fd4aec4..47b7bdd6f535 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -58,6 +58,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"(__iommu_table|__apicdrivers|__smp_locks)(|_end)|"
 	"__(start|end)_pci_.*|"
 	"__(start|end)_builtin_fw|"
+	"__(start|end)_unwind(|_hdr)|"
 	"__(start|stop)___ksymtab(|_gpl|_unused|_unused_gpl|_gpl_future)|"
 	"__(start|stop)___kcrctab(|_gpl|_unused|_unused_gpl|_gpl_future)|"
 	"__(start|stop)___param|"
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 314a0b9219c6..349034b41e60 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -406,6 +406,8 @@
 		MEM_KEEP(exit.rodata)					\
 	}								\
 									\
+	EH_FRAME							\
+									\
 	/* Built-in module parameters. */				\
 	__param : AT(ADDR(__param) - LOAD_OFFSET) {			\
 		VMLINUX_SYMBOL(__start___param) = .;			\
@@ -882,3 +884,23 @@
 	BSS(bss_align)							\
 	. = ALIGN(stop_align);						\
 	VMLINUX_SYMBOL(__bss_stop) = .;
+
+#ifdef CONFIG_DWARF_UNWIND
+#define EH_FRAME							\
+		/* Unwind data binary search table */			\
+		. = ALIGN(8);						\
+		.eh_frame_hdr : AT(ADDR(.eh_frame_hdr) - LOAD_OFFSET) {	\
+			VMLINUX_SYMBOL(__start_unwind_hdr) = .;		\
+			*(.eh_frame_hdr)				\
+			VMLINUX_SYMBOL(__end_unwind_hdr) = .;		\
+		}							\
+		/* Unwind data */					\
+		. = ALIGN(8);						\
+		.eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {		\
+			VMLINUX_SYMBOL(__start_unwind) = .;		\
+			*(.eh_frame)					\
+			VMLINUX_SYMBOL(__end_unwind) = .;		\
+		}
+#else
+#define EH_FRAME
+#endif
-- 
2.12.2
