From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v7 03/28] x86/asm/suspend: use SYM_DATA for data
Date: Wed, 30 Jan 2019 13:46:46 +0100
Message-ID: <20190130124711.12463-4-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: bp@alien8.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Some global data in the suspend code were marked as `ENTRY'. ENTRY was
intended for functions and shall be paired with ENDPROC. ENTRY also
aligns symbols which creates unnecessary holes here between data. Since
we are dropping historical markings, make proper use of newly added
SYM_DATA in this code.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
---
 arch/x86/kernel/acpi/wakeup_32.S | 2 +-
 arch/x86/kernel/acpi/wakeup_64.S | 2 +-
 arch/x86/kernel/head_32.S        | 6 ++----
 arch/x86/kernel/head_64.S        | 5 ++---
 4 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index 4203d4f0c68d..feac1e5ecba0 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -89,7 +89,7 @@ ret_point:
 
 .data
 ALIGN
-ENTRY(saved_magic)	.long	0
+SYM_DATA(saved_magic,	.long 0)
 saved_eip:		.long 0
 
 # saved registers
diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
index 510fa12aab73..551758f48eb7 100644
--- a/arch/x86/kernel/acpi/wakeup_64.S
+++ b/arch/x86/kernel/acpi/wakeup_64.S
@@ -133,4 +133,4 @@ saved_rbx:		.quad	0
 saved_rip:		.quad	0
 saved_rsp:		.quad	0
 
-ENTRY(saved_magic)	.quad	0
+SYM_DATA(saved_magic,	.quad	0)
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 30f9cb2c0b55..d1e213da4782 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -507,10 +507,8 @@ GLOBAL(early_recursion_flag)
 
 __REFDATA
 	.align 4
-ENTRY(initial_code)
-	.long i386_start_kernel
-ENTRY(setup_once_ref)
-	.long setup_once
+SYM_DATA(initial_code,		.long i386_start_kernel)
+SYM_DATA(setup_once_ref,	.long setup_once)
 
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 #define	PGD_ALIGN	(2 * PAGE_SIZE)
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d1dbe8e4eb82..d994162cce31 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -471,9 +471,8 @@ early_gdt_descr:
 early_gdt_descr_base:
 	.quad	INIT_PER_CPU_VAR(gdt_page)
 
-ENTRY(phys_base)
-	/* This must match the first entry in level2_kernel_pgt */
-	.quad   0x0000000000000000
+/* This must match the first entry in level2_kernel_pgt */
+SYM_DATA(phys_base, .quad 0x0000000000000000)
 EXPORT_SYMBOL(phys_base)
 
 #include "../../x86/xen/xen-head.S"
-- 
2.20.1
