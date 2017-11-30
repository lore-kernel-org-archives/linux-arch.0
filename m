From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v5 21/27] x86_64: assembly, add ENDs to some functions and relabel with SYM_CODE_*
Date: Thu, 30 Nov 2017 15:46:47 +0100
Message-ID: <20171130144653.23688-22-jslaby@suse.cz>
References: <20171130144653.23688-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171130144653.23688-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, xen-devel@lists.xenproject.org
List-Id: linux-arch.vger.kernel.org

All these are functions which are invoked from elsewhere, but they are
not typical C functions. So we annotate them (as global) using the new
SYM_CODE_START. All these were not balanced with any END, so mark their
ends by SYM_CODE_END, appropriatelly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com> [xen bits]
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/boot/compressed/head_64.S   |  3 ++-
 arch/x86/platform/olpc/xo1-wakeup.S  |  3 ++-
 arch/x86/power/hibernate_asm_64.S    |  6 ++++--
 arch/x86/realmode/rm/reboot.S        |  3 ++-
 arch/x86/realmode/rm/trampoline_64.S | 10 +++++++---
 arch/x86/realmode/rm/wakeup_asm.S    |  3 ++-
 arch/x86/xen/xen-asm_64.S            |  6 ++++--
 7 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 108dbd71ae0b..647be777b5cc 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -249,7 +249,7 @@ ENDPROC(efi32_stub_entry)
 
 	.code64
 	.org 0x200
-ENTRY(startup_64)
+SYM_CODE_START(startup_64)
 	/*
 	 * 64bit entry is 0x200 and it is ABI so immutable!
 	 * We come here either from startup_32 or directly from a
@@ -369,6 +369,7 @@ lvl5:
  */
 	leaq	relocated(%rbx), %rax
 	jmp	*%rax
+SYM_CODE_END(startup_64)
 
 #ifdef CONFIG_EFI_STUB
 
diff --git a/arch/x86/platform/olpc/xo1-wakeup.S b/arch/x86/platform/olpc/xo1-wakeup.S
index 5fee3a2c2fd4..75f4faff8468 100644
--- a/arch/x86/platform/olpc/xo1-wakeup.S
+++ b/arch/x86/platform/olpc/xo1-wakeup.S
@@ -90,7 +90,7 @@ restore_registers:
 
 	ret
 
-ENTRY(do_olpc_suspend_lowlevel)
+SYM_CODE_START(do_olpc_suspend_lowlevel)
 	call	save_processor_state
 	call	save_registers
 
@@ -110,6 +110,7 @@ ret_point:
 	call	restore_registers
 	call	restore_processor_state
 	ret
+SYM_CODE_END(do_olpc_suspend_lowlevel)
 
 .data
 saved_gdt:             .long   0,0
diff --git a/arch/x86/power/hibernate_asm_64.S b/arch/x86/power/hibernate_asm_64.S
index ce8da3a0412c..44755a847856 100644
--- a/arch/x86/power/hibernate_asm_64.S
+++ b/arch/x86/power/hibernate_asm_64.S
@@ -53,7 +53,7 @@ ENTRY(swsusp_arch_suspend)
 	ret
 ENDPROC(swsusp_arch_suspend)
 
-ENTRY(restore_image)
+SYM_CODE_START(restore_image)
 	/* prepare to jump to the image kernel */
 	movq	restore_jump_address(%rip), %r8
 	movq	restore_cr3(%rip), %r9
@@ -68,9 +68,10 @@ ENTRY(restore_image)
 	/* jump to relocated restore code */
 	movq	relocated_restore_code(%rip), %rcx
 	jmpq	*%rcx
+SYM_CODE_END(restore_image)
 
 	/* code below has been relocated to a safe page */
-ENTRY(core_restore_code)
+SYM_CODE_START(core_restore_code)
 	/* switch to temporary page tables */
 	movq	%rax, %cr3
 	/* flush TLB */
@@ -98,6 +99,7 @@ ENTRY(core_restore_code)
 .Ldone:
 	/* jump to the restore_registers address from the image header */
 	jmpq	*%r8
+SYM_CODE_END(core_restore_code)
 
 	 /* code below belongs to the image kernel */
 	.align PAGE_SIZE
diff --git a/arch/x86/realmode/rm/reboot.S b/arch/x86/realmode/rm/reboot.S
index 6e38c13c1873..7db1459d363f 100644
--- a/arch/x86/realmode/rm/reboot.S
+++ b/arch/x86/realmode/rm/reboot.S
@@ -19,7 +19,7 @@
  */
 	.section ".text32", "ax"
 	.code32
-ENTRY(machine_real_restart_asm)
+SYM_CODE_START(machine_real_restart_asm)
 
 #ifdef CONFIG_X86_64
 	/* Switch to trampoline GDT as it is guaranteed < 4 GiB */
@@ -63,6 +63,7 @@ SYM_CODE_INNER_LABEL(machine_real_restart_paging_off, SYM_L_GLOBAL)
 	movl	%ecx, %gs
 	movl	%ecx, %ss
 	ljmpw	$8, $1f
+SYM_CODE_END(machine_real_restart_asm)
 
 /*
  * This is 16-bit protected mode code to disable paging and the cache,
diff --git a/arch/x86/realmode/rm/trampoline_64.S b/arch/x86/realmode/rm/trampoline_64.S
index 41d4806d14a5..49f27822c9c1 100644
--- a/arch/x86/realmode/rm/trampoline_64.S
+++ b/arch/x86/realmode/rm/trampoline_64.S
@@ -38,7 +38,7 @@
 	.code16
 
 	.balign	PAGE_SIZE
-ENTRY(trampoline_start)
+SYM_CODE_START(trampoline_start)
 	cli			# We should be safe anyway
 	wbinvd
 
@@ -81,12 +81,14 @@ ENTRY(trampoline_start)
 no_longmode:
 	hlt
 	jmp no_longmode
+SYM_CODE_END(trampoline_start)
+
 #include "../kernel/verify_cpu.S"
 
 	.section ".text32","ax"
 	.code32
 	.balign 4
-ENTRY(startup_32)
+SYM_CODE_START(startup_32)
 	movl	%edx, %ss
 	addl	$pa_real_mode_base, %esp
 	movl	%edx, %ds
@@ -140,13 +142,15 @@ ENTRY(startup_32)
 	 * the new gdt/idt that has __KERNEL_CS with CS.L = 1.
 	 */
 	ljmpl	$__KERNEL_CS, $pa_startup_64
+SYM_CODE_END(startup_32)
 
 	.section ".text64","ax"
 	.code64
 	.balign 4
-ENTRY(startup_64)
+SYM_CODE_START(startup_64)
 	# Now jump into the kernel using virtual addresses
 	jmpq	*tr_start(%rip)
+SYM_CODE_END(startup_64)
 
 	.section ".rodata","a"
 	# Duplicate the global descriptor table
diff --git a/arch/x86/realmode/rm/wakeup_asm.S b/arch/x86/realmode/rm/wakeup_asm.S
index 0af6b30d3c68..7079913adbd2 100644
--- a/arch/x86/realmode/rm/wakeup_asm.S
+++ b/arch/x86/realmode/rm/wakeup_asm.S
@@ -37,7 +37,7 @@ SYM_DATA_END(wakeup_header)
 	.code16
 
 	.balign	16
-ENTRY(wakeup_start)
+SYM_CODE_START(wakeup_start)
 	cli
 	cld
 
@@ -135,6 +135,7 @@ ENTRY(wakeup_start)
 #else
 	jmp	trampoline_start
 #endif
+SYM_CODE_END(wakeup_start)
 
 bogus_real_magic:
 1:
diff --git a/arch/x86/xen/xen-asm_64.S b/arch/x86/xen/xen-asm_64.S
index 0820db159053..1e419040bef1 100644
--- a/arch/x86/xen/xen-asm_64.S
+++ b/arch/x86/xen/xen-asm_64.S
@@ -70,11 +70,12 @@ hypercall_iret = hypercall_page + __HYPERVISOR_iret * 32
  *	r11		}<-- pushed by hypercall page
  * rsp->rax		}
  */
-ENTRY(xen_iret)
+SYM_CODE_START(xen_iret)
 	pushq $0
 	jmp hypercall_iret
+SYM_CODE_END(xen_iret)
 
-ENTRY(xen_sysret64)
+SYM_CODE_START(xen_sysret64)
 	/*
 	 * We're already on the usermode stack at this point, but
 	 * still with the kernel gs, so we can easily switch back
@@ -90,6 +91,7 @@ ENTRY(xen_sysret64)
 
 	pushq $VGCF_in_syscall
 	jmp hypercall_iret
+SYM_CODE_END(xen_sysret64)
 
 /*
  * Xen handles syscall callbacks much like ordinary exceptions, which
-- 
2.15.0
