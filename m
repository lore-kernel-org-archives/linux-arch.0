Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:57685 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439805AbfJRQar (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:47 -0400
Date: Fri, 18 Oct 2019 16:30:30 -0000
From: "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: x86/asm] xen/pvh: Annotate data appropriately
In-Reply-To: <20191011115108.12392-15-jslaby@suse.cz>
References: <20191011115108.12392-15-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623045.29376.2755641744903920106.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Juergen Gross <jgross@suse.com>, linux-arch@vger.kernel.org, platform-driver-x86@vger.kernel.org, Stefano Stabellini <sstabellini@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86-ml <x86@kernel.org>, xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Message-ID: <20191018163030.mbZVbkxgp2VU48NFXXxpMJUyOPtXQrtRCGaxX1qQ0hI@z>

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     1de5bdce0c3f8294d0aabc48fb5497814589422f
Gitweb:        https://git.kernel.org/tip/1de5bdce0c3f8294d0aabc48fb5497814589422f
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:54 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 10:46:06 +02:00

xen/pvh: Annotate data appropriately

Use the new SYM_DATA_START_LOCAL, and SYM_DATA_END* macros to get:

  0000     8 OBJECT  LOCAL  DEFAULT    6 gdt
  0008    32 OBJECT  LOCAL  DEFAULT    6 gdt_start
  0028     0 OBJECT  LOCAL  DEFAULT    6 gdt_end
  0028   256 OBJECT  LOCAL  DEFAULT    6 early_stack
  0128     0 OBJECT  LOCAL  DEFAULT    6 early_stack

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Andy Shevchenko <andy@infradead.org>
Cc: Darren Hart <dvhart@infradead.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: linux-arch@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86-ml <x86@kernel.org>
Cc: xen-devel@lists.xenproject.org
Link: https://lkml.kernel.org/r/20191011115108.12392-15-jslaby@suse.cz
---
 arch/x86/platform/pvh/head.S | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 1f8825b..4e63480 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -150,11 +150,12 @@ END(pvh_start_xen)
 
 	.section ".init.data","aw"
 	.balign 8
-gdt:
+SYM_DATA_START_LOCAL(gdt)
 	.word gdt_end - gdt_start
 	.long _pa(gdt_start)
 	.word 0
-gdt_start:
+SYM_DATA_END(gdt)
+SYM_DATA_START_LOCAL(gdt_start)
 	.quad 0x0000000000000000            /* NULL descriptor */
 #ifdef CONFIG_X86_64
 	.quad GDT_ENTRY(0xa09a, 0, 0xfffff) /* PVH_CS_SEL */
@@ -163,15 +164,14 @@ gdt_start:
 #endif
 	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* PVH_DS_SEL */
 	.quad GDT_ENTRY(0x4090, 0, 0x18)    /* PVH_CANARY_SEL */
-gdt_end:
+SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 16
-canary:
-	.fill 48, 1, 0
+SYM_DATA_LOCAL(canary, .fill 48, 1, 0)
 
-early_stack:
+SYM_DATA_START_LOCAL(early_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
-early_stack_end:
+SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
 
 	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,
 	             _ASM_PTR (pvh_start_xen - __START_KERNEL_map))
