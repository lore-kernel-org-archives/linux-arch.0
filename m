From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend 03/27] x86: assembly, annotate relocate_kernel
Date: Thu, 10 May 2018 10:06:20 +0200
Message-ID: <20180510080644.19752-4-jslaby@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

There are functions in relocate_kernel which are not annotated. This
will not allow for automatic DWARF annotations. So annotate all the
functions now.

Note that these are not C-like functions, so we do not use FUNC, but
CODE. Also they are not aligned, so we use NOALIGN versions:
- SYM_CODE_START_NOALIGN
- SYM_FUNC_START_LOCAL_NOALIGN
- SYM_FUNC_END

In return, we get:
  0000   108 NOTYPE  GLOBAL DEFAULT    1 relocate_kernel
  006c   165 NOTYPE  LOCAL  DEFAULT    1 identity_mapped
  0146   127 NOTYPE  LOCAL  DEFAULT    1 swap_pages
  0111    53 NOTYPE  LOCAL  DEFAULT    1 virtual_mapped

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
---
 arch/x86/kernel/relocate_kernel_32.S | 13 ++++++++-----
 arch/x86/kernel/relocate_kernel_64.S | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/relocate_kernel_32.S b/arch/x86/kernel/relocate_kernel_32.S
index 77630d57e7bf..74d7891fc026 100644
--- a/arch/x86/kernel/relocate_kernel_32.S
+++ b/arch/x86/kernel/relocate_kernel_32.S
@@ -37,8 +37,7 @@
 #define CP_PA_BACKUP_PAGES_MAP	DATA(0x1c)
 
 	.text
-	.globl relocate_kernel
-relocate_kernel:
+SYM_CODE_START_NOALIGN(relocate_kernel)
 	/* Save the CPU context, used for jumping back */
 
 	pushl	%ebx
@@ -95,8 +94,9 @@ relocate_kernel:
 	addl    $(identity_mapped - relocate_kernel), %eax
 	pushl   %eax
 	ret
+SYM_CODE_END(relocate_kernel)
 
-identity_mapped:
+SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* set return address to 0 if not preserving context */
 	pushl	$0
 	/* store the start address on the stack */
@@ -193,8 +193,9 @@ identity_mapped:
 	addl	$(virtual_mapped - relocate_kernel), %eax
 	pushl	%eax
 	ret
+SYM_CODE_END(identity_mapped)
 
-virtual_mapped:
+SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	movl	CR4(%edi), %eax
 	movl	%eax, %cr4
 	movl	CR3(%edi), %eax
@@ -210,9 +211,10 @@ virtual_mapped:
 	popl	%esi
 	popl	%ebx
 	ret
+SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
-swap_pages:
+SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movl	8(%esp), %edx
 	movl	4(%esp), %ecx
 	pushl	%ebp
@@ -272,6 +274,7 @@ swap_pages:
 	popl	%ebx
 	popl	%ebp
 	ret
+SYM_CODE_END(swap_pages)
 
 	.globl kexec_control_code_size
 .set kexec_control_code_size, . - relocate_kernel
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index 11eda21eb697..beb78767a5b3 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -40,8 +40,7 @@
 	.text
 	.align PAGE_SIZE
 	.code64
-	.globl relocate_kernel
-relocate_kernel:
+SYM_CODE_START_NOALIGN(relocate_kernel)
 	/*
 	 * %rdi indirection_page
 	 * %rsi page_list
@@ -105,8 +104,9 @@ relocate_kernel:
 	addq	$(identity_mapped - relocate_kernel), %r8
 	pushq	%r8
 	ret
+SYM_CODE_END(relocate_kernel)
 
-identity_mapped:
+SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	/* set return address to 0 if not preserving context */
 	pushq	$0
 	/* store the start address on the stack */
@@ -211,8 +211,9 @@ identity_mapped:
 	movq	$virtual_mapped, %rax
 	pushq	%rax
 	ret
+SYM_CODE_END(identity_mapped)
 
-virtual_mapped:
+SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	movq	RSP(%r8), %rsp
 	movq	CR4(%r8), %rax
 	movq	%rax, %cr4
@@ -230,9 +231,10 @@ virtual_mapped:
 	popq	%rbp
 	popq	%rbx
 	ret
+SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
-swap_pages:
+SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	movq	%rdi, %rcx 	/* Put the page_list in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
@@ -285,6 +287,7 @@ swap_pages:
 	jmp	0b
 3:
 	ret
+SYM_CODE_END(swap_pages)
 
 	.globl kexec_control_code_size
 .set kexec_control_code_size, . - relocate_kernel
-- 
2.16.3
