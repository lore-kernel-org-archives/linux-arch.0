From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH v7 25/28] x86_32/asm: add ENDs to some functions and relabel with SYM_CODE_*
Date: Wed, 30 Jan 2019 13:47:08 +0100
Message-ID: <20190130124711.12463-26-jslaby@suse.cz>
References: <20190130124711.12463-1-jslaby@suse.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130124711.12463-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: bp@alien8.de, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Juergen Gross <jgross@suse.com>, linux-pm@vger.kernel.org, xen-devel@lists.xenproject.org
List-Id: linux-arch.vger.kernel.org

All these are functions which are invoked from elsewhere, but they are
not typical C functions. So we annotate them using the new
SYM_CODE_START. All these were not balanced with any END, so mark their
ends by SYM_CODE_END, appropriatelly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com> [xen bits]
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com> [hibernate]
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-pm@vger.kernel.org
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/entry/entry_32.S            | 3 ++-
 arch/x86/kernel/acpi/wakeup_32.S     | 7 ++++---
 arch/x86/kernel/ftrace_32.S          | 3 ++-
 arch/x86/kernel/head_32.S            | 3 ++-
 arch/x86/power/hibernate_asm_32.S    | 6 ++++--
 arch/x86/realmode/rm/trampoline_32.S | 6 ++++--
 arch/x86/xen/xen-asm_32.S            | 7 ++++---
 7 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 07029b98111d..f7190d5da9f1 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -790,9 +790,10 @@ SYM_ENTRY(__begin_SYSENTER_singlestep_region, SYM_L_GLOBAL, SYM_A_NONE)
  * Xen doesn't set %esp to be precisely what the normal SYSENTER
  * entry point expects, so fix it up before using the normal path.
  */
-ENTRY(xen_sysenter_target)
+SYM_CODE_START(xen_sysenter_target)
 	addl	$5*4, %esp			/* remove xen-provided frame */
 	jmp	.Lsysenter_past_esp
+SYM_CODE_END(xen_sysenter_target)
 #endif
 
 /*
diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
index feac1e5ecba0..71a05a6cc36a 100644
--- a/arch/x86/kernel/acpi/wakeup_32.S
+++ b/arch/x86/kernel/acpi/wakeup_32.S
@@ -8,8 +8,7 @@
 	.code32
 	ALIGN
 
-ENTRY(wakeup_pmode_return)
-wakeup_pmode_return:
+SYM_CODE_START(wakeup_pmode_return)
 	movw	$__KERNEL_DS, %ax
 	movw	%ax, %ss
 	movw	%ax, %fs
@@ -38,6 +37,7 @@ wakeup_pmode_return:
 	# jump to place where we left off
 	movl	saved_eip, %eax
 	jmp	*%eax
+SYM_CODE_END(wakeup_pmode_return)
 
 bogus_magic:
 	jmp	bogus_magic
@@ -71,7 +71,7 @@ restore_registers:
 	popfl
 	ret
 
-ENTRY(do_suspend_lowlevel)
+SYM_CODE_START(do_suspend_lowlevel)
 	call	save_processor_state
 	call	save_registers
 	pushl	$3
@@ -86,6 +86,7 @@ ret_point:
 	call	restore_registers
 	call	restore_processor_state
 	ret
+SYM_CODE_END(do_suspend_lowlevel)
 
 .data
 ALIGN
diff --git a/arch/x86/kernel/ftrace_32.S b/arch/x86/kernel/ftrace_32.S
index b855dc10daeb..f4dca7df8ad6 100644
--- a/arch/x86/kernel/ftrace_32.S
+++ b/arch/x86/kernel/ftrace_32.S
@@ -102,7 +102,7 @@ WEAK(ftrace_stub)
 	ret
 END(ftrace_caller)
 
-ENTRY(ftrace_regs_caller)
+SYM_CODE_START(ftrace_regs_caller)
 	/*
 	 * i386 does not save SS and ESP when coming from kernel.
 	 * Instead, to get sp, &regs->sp is used (see ptrace.h).
@@ -170,6 +170,7 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	lea	3*4(%esp), %esp			/* Skip orig_ax, ip and cs */
 
 	jmp	.Lftrace_ret
+SYM_CODE_END(ftrace_regs_caller)
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
 ENTRY(function_hook)
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 2d5390d84467..bfd713034e9b 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -64,7 +64,7 @@ RESERVE_BRK(pagetables, INIT_MAP_SIZE)
  * can.
  */
 __HEAD
-ENTRY(startup_32)
+SYM_CODE_START(startup_32)
 	movl pa(initial_stack),%ecx
 	
 	/* test KEEP_SEGMENTS flag to see if the bootloader is asking
@@ -172,6 +172,7 @@ num_subarch_entries = (. - subarch_entries) / 4
 #else
 	jmp .Ldefault_entry
 #endif /* CONFIG_PARAVIRT */
+SYM_CODE_END(startup_32)
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
diff --git a/arch/x86/power/hibernate_asm_32.S b/arch/x86/power/hibernate_asm_32.S
index 6fe383002125..a19ed3d23185 100644
--- a/arch/x86/power/hibernate_asm_32.S
+++ b/arch/x86/power/hibernate_asm_32.S
@@ -35,7 +35,7 @@ ENTRY(swsusp_arch_suspend)
 	ret
 ENDPROC(swsusp_arch_suspend)
 
-ENTRY(restore_image)
+SYM_CODE_START(restore_image)
 	/* prepare to jump to the image kernel */
 	movl	restore_jump_address, %ebx
 	movl	restore_cr3, %ebp
@@ -45,9 +45,10 @@ ENTRY(restore_image)
 	/* jump to relocated restore code */
 	movl	relocated_restore_code, %eax
 	jmpl	*%eax
+SYM_CODE_END(restore_image)
 
 /* code below has been relocated to a safe page */
-ENTRY(core_restore_code)
+SYM_CODE_START(core_restore_code)
 	movl	temp_pgt, %eax
 	movl	%eax, %cr3
 
@@ -77,6 +78,7 @@ copy_loop:
 
 done:
 	jmpl	*%ebx
+SYM_CODE_END(core_restore_code)
 
 	/* code below belongs to the image kernel */
 	.align PAGE_SIZE
diff --git a/arch/x86/realmode/rm/trampoline_32.S b/arch/x86/realmode/rm/trampoline_32.S
index e96efcd60bf7..a3b047a44c5c 100644
--- a/arch/x86/realmode/rm/trampoline_32.S
+++ b/arch/x86/realmode/rm/trampoline_32.S
@@ -29,7 +29,7 @@
 	.code16
 
 	.balign	PAGE_SIZE
-ENTRY(trampoline_start)
+SYM_CODE_START(trampoline_start)
 	wbinvd			# Needed for NUMA-Q should be harmless for others
 
 	LJMPW_RM(1f)
@@ -57,11 +57,13 @@ ENTRY(trampoline_start)
 	lmsw	%dx			# into protected mode
 
 	ljmpl	$__BOOT_CS, $pa_startup_32
+SYM_CODE_END(trampoline_start)
 
 	.section ".text32","ax"
 	.code32
-ENTRY(startup_32)			# note: also used from wakeup_asm.S
+SYM_CODE_START(startup_32)			# note: also used from wakeup_asm.S
 	jmp	*%eax
+SYM_CODE_END(startup_32)
 
 	.bss
 	.balign 8
diff --git a/arch/x86/xen/xen-asm_32.S b/arch/x86/xen/xen-asm_32.S
index c15db060a242..8b8f8355b938 100644
--- a/arch/x86/xen/xen-asm_32.S
+++ b/arch/x86/xen/xen-asm_32.S
@@ -56,7 +56,7 @@
 	_ASM_EXTABLE(1b,2b)
 .endm
 
-ENTRY(xen_iret)
+SYM_CODE_START(xen_iret)
 	/* test eflags for special cases */
 	testl $(X86_EFLAGS_VM | XEN_EFLAGS_NMI), 8(%esp)
 	jnz hyper_iret
@@ -122,6 +122,7 @@ xen_iret_end_crit:
 hyper_iret:
 	/* put this out of line since its very rarely used */
 	jmp hypercall_page + __HYPERVISOR_iret * 32
+SYM_CODE_END(xen_iret)
 
 	.globl xen_iret_start_crit, xen_iret_end_crit
 
@@ -165,7 +166,7 @@ hyper_iret:
  * SAVE_ALL state before going on, since it's usermode state which we
  * eventually need to restore.
  */
-ENTRY(xen_iret_crit_fixup)
+SYM_CODE_START(xen_iret_crit_fixup)
 	/*
 	 * Paranoia: Make sure we're really coming from kernel space.
 	 * One could imagine a case where userspace jumps into the
@@ -204,4 +205,4 @@ ENTRY(xen_iret_crit_fixup)
 
 	lea 4(%edi), %esp		/* point esp to new frame */
 2:	jmp xen_do_upcall
-
+SYM_CODE_END(xen_iret_crit_fixup)
-- 
2.20.1
