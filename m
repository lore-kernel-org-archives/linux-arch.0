From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv1, RFC 1/8] x86/boot/compressed/64: Detect and handle 5-level paging at boot-time
Date: Thu, 25 May 2017 23:33:27 +0300
Message-ID: <20170525203334.867-2-kirill.shutemov@linux.intel.com>
References: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <20170525203334.867-1-kirill.shutemov@linux.intel.com>
Sender: owner-linux-mm@kvack.org
To: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>, Dave Hansen <dave.hansen@intel.com>, Andy Lutomirski <luto@amacapital.net>, linux-arch@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
List-Id: linux-arch.vger.kernel.org

This patch prepare decompression code to boot-time switching between 4-
and 5-level paging.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/boot/compressed/head_64.S | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
index 3ed26769810b..89d886c95afc 100644
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@ -109,6 +109,31 @@ ENTRY(startup_32)
 	movl	$LOAD_PHYSICAL_ADDR, %ebx
 1:
 
+#ifdef CONFIG_X86_5LEVEL
+	pushl	%ebx
+
+	/* Check if leaf 7 is supported*/
+	movl	$0, %eax
+	cpuid
+	cmpl	$7, %eax
+	jb	1f
+
+	/*
+	 * Check if la57 is supported.
+	 * The feature is enumerated with CPUID.(EAX=07H, ECX=0):ECX[bit 16]
+	 */
+	movl	$7, %eax
+	movl	$0, %ecx
+	cpuid
+	andl	$(1 << 16), %ecx
+	jz	1f
+
+	/* p4d page table is not folded if la57 is present */
+	movl	$0, p4d_folded(%ebp)
+1:
+	popl %ebx
+#endif
+
 	/* Target address to relocate to for decompression */
 	movl	BP_init_size(%esi), %eax
 	subl	$_end, %eax
@@ -125,9 +150,14 @@ ENTRY(startup_32)
 	/* Enable PAE and LA57 mode */
 	movl	%cr4, %eax
 	orl	$X86_CR4_PAE, %eax
+
 #ifdef CONFIG_X86_5LEVEL
+	testl	$1, p4d_folded(%ebp)
+	jnz	1f
 	orl	$X86_CR4_LA57, %eax
+1:
 #endif
+
 	movl	%eax, %cr4
 
  /*
@@ -147,11 +177,15 @@ ENTRY(startup_32)
 	movl	%eax, 0(%edi)
 
 #ifdef CONFIG_X86_5LEVEL
+	testl	$1, p4d_folded(%ebp)
+	jnz	1f
+
 	/* Build Level 4 */
 	addl	$0x1000, %edx
 	leal	pgtable(%ebx,%edx), %edi
 	leal	0x1007 (%edi), %eax
 	movl	%eax, 0(%edi)
+1:
 #endif
 
 	/* Build Level 3 */
@@ -464,6 +498,9 @@ gdt:
 	.quad   0x0000000000000000	/* TS continued */
 gdt_end:
 
+p4d_folded:
+	.word	1
+
 #ifdef CONFIG_EFI_STUB
 efi_config:
 	.quad	0
-- 
2.11.0

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
