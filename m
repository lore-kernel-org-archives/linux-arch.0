Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756775AbeEJIHC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 May 2018 04:07:02 -0400
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH -resend 13/27] x86: xen-pvh, annotate data appropriatelly
Date: Thu, 10 May 2018 10:06:30 +0200
Message-ID: <20180510080644.19752-14-jslaby@suse.cz>
In-Reply-To: <20180510080644.19752-1-jslaby@suse.cz>
References: <20180510080644.19752-1-jslaby@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: mingo@redhat.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, xen-devel@lists.xenproject.org
Message-ID: <20180510080630.GTHolQ-g9hwsahlt5yIJlNJ37Ur3wIvsui2SNTbE3uc@z>

Use the new SYM_DATA_START_LOCAL, and SYM_DATA_END* macros:
  0000     8 OBJECT  LOCAL  DEFAULT    6 gdt
  0008    32 OBJECT  LOCAL  DEFAULT    6 gdt_start
  0028     0 OBJECT  LOCAL  DEFAULT    6 gdt_end
  0028   256 OBJECT  LOCAL  DEFAULT    6 early_stack
  0128     0 OBJECT  LOCAL  DEFAULT    6 early_stack

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: xen-devel@lists.xenproject.org
---
 arch/x86/xen/xen-pvh.S | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/x86/xen/xen-pvh.S b/arch/x86/xen/xen-pvh.S
index e1a5fbeae08d..52b28793a625 100644
--- a/arch/x86/xen/xen-pvh.S
+++ b/arch/x86/xen/xen-pvh.S
@@ -137,11 +137,12 @@ END(pvh_start_xen)
 
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
 	.quad 0x0000000000000000            /* reserved */
 #ifdef CONFIG_X86_64
@@ -150,12 +151,12 @@ gdt_start:
 	.quad GDT_ENTRY(0xc09a, 0, 0xfffff) /* __KERNEL_CS */
 #endif
 	.quad GDT_ENTRY(0xc092, 0, 0xfffff) /* __KERNEL_DS */
-gdt_end:
+SYM_DATA_END_LABEL(gdt_start, SYM_L_LOCAL, gdt_end)
 
 	.balign 4
-early_stack:
+SYM_DATA_START_LOCAL(early_stack)
 	.fill 256, 1, 0
-early_stack_end:
+SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
 
 	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,
 	             _ASM_PTR (pvh_start_xen - __START_KERNEL_map))
-- 
2.16.3
