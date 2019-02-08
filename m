Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail.skyhub.de ([5.9.137.197]:60362 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726211AbfBHTxb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 Feb 2019 14:53:31 -0500
Date: Fri, 8 Feb 2019 20:53:24 +0100
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v7 04/28] x86/asm: annotate relocate_kernel
Message-ID: <20190208195324.GM674@zn.tnic>
References: <20190130124711.12463-1-jslaby@suse.cz>
 <20190130124711.12463-5-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130124711.12463-5-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Message-ID: <20190208195324.OuZdo7q8rIgyTPIM7qjh8o41GEm6bOOTTuzmnhwsYxw@z>

On Wed, Jan 30, 2019 at 01:46:47PM +0100, Jiri Slaby wrote:
> There are functions in relocate_kernel which are not annotated. This
> makes automatic annotations rather hard. So annotate all the functions
> now.
> 
> Note that these are not C-like functions, so we do not use FUNC, but
> CODE markers. Also they are not aligned, so we use the NOALIGN versions:
> - SYM_CODE_START_NOALIGN
> - SYM_CODE_START_LOCAL_NOALIGN
> - SYM_CODE_END
> 
> In return, we get:
>   0000   108 NOTYPE  GLOBAL DEFAULT    1 relocate_kernel
>   006c   165 NOTYPE  LOCAL  DEFAULT    1 identity_mapped
>   0146   127 NOTYPE  LOCAL  DEFAULT    1 swap_pages
>   0111    53 NOTYPE  LOCAL  DEFAULT    1 virtual_mapped

Err, if those last three are local symbols, you can simply remove them
from the symtable by making them a local labels. Partial diff ontop of
yours:

---
diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
index beb78767a5b3..e15033ce246f 100644
--- a/arch/x86/kernel/relocate_kernel_64.S
+++ b/arch/x86/kernel/relocate_kernel_64.S
@@ -101,12 +101,12 @@ SYM_CODE_START_NOALIGN(relocate_kernel)
 	lea	PAGE_SIZE(%r8), %rsp
 
 	/* jump to identity mapped page */
-	addq	$(identity_mapped - relocate_kernel), %r8
+	addq	$(.Lidentity_mapped - relocate_kernel), %r8
 	pushq	%r8
 	ret
 SYM_CODE_END(relocate_kernel)
 
-SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
+.Lidentity_mapped:
 	/* set return address to 0 if not preserving context */
 	pushq	$0
 	/* store the start address on the stack */
@@ -155,7 +155,7 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 1:
 
 	movq	%rcx, %r11
-	call	swap_pages
+	call	.Lswap_pages
 
 	/*
 	 * To be certain of avoiding problems with self-modifying code
@@ -207,13 +207,12 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
 	movq	CP_PA_TABLE_PAGE(%r8), %rax
 	movq	%rax, %cr3
 	lea	PAGE_SIZE(%r8), %rsp
-	call	swap_pages
-	movq	$virtual_mapped, %rax
+	call	.Lswap_pages
+	movq	$.Lvirtual_mapped, %rax
 	pushq	%rax
 	ret
-SYM_CODE_END(identity_mapped)
 
-SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
+.Lvirtual_mapped:
 	movq	RSP(%r8), %rsp
 	movq	CR4(%r8), %rax
 	movq	%rax, %cr4
@@ -231,10 +230,9 @@ SYM_CODE_START_LOCAL_NOALIGN(virtual_mapped)
 	popq	%rbp
 	popq	%rbx
 	ret
-SYM_CODE_END(virtual_mapped)
 
 	/* Do the copies */
-SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
+.Lswap_pages:
 	movq	%rdi, %rcx 	/* Put the page_list in %rcx */
 	xorl	%edi, %edi
 	xorl	%esi, %esi
@@ -287,7 +285,6 @@ SYM_CODE_START_LOCAL_NOALIGN(swap_pages)
 	jmp	0b
 3:
 	ret
-SYM_CODE_END(swap_pages)
 
 	.globl kexec_control_code_size
 .set kexec_control_code_size, . - relocate_kernel

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
