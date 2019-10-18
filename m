Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:57769 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439951AbfJRQa4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Oct 2019 12:30:56 -0400
Date: Fri, 18 Oct 2019 16:30:30 -0000
From: "tip-bot2 for Jiri Slaby" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: x86/asm] x86/um: Annotate data appropriately
In-Reply-To: <20191011115108.12392-14-jslaby@suse.cz>
References: <20191011115108.12392-14-jslaby@suse.cz>
MIME-Version: 1.0
Message-ID: <157141623074.29376.16125324643950283172.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Borislav Petkov <bp@suse.de>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, linux-arch@vger.kernel.org, linux-um@lists.infradead.org, Thomas Gleixner <tglx@linutronix.de>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, x86-ml <x86@kernel.org>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
Message-ID: <20191018163030.AXKJOIKLGfxvMhvkUPXoI8pPlgZlDvY0niadPv0sjpY@z>

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     773a37b182259f5e0cdb928112431b119a6e4500
Gitweb:        https://git.kernel.org/tip/773a37b182259f5e0cdb928112431b119a6e4500
Author:        Jiri Slaby <jslaby@suse.cz>
AuthorDate:    Fri, 11 Oct 2019 13:50:53 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 18 Oct 2019 10:45:03 +02:00

x86/um: Annotate data appropriately

Use the new SYM_DATA_START and SYM_DATA_END_LABEL macros for vdso_start.

Result is:
  0000  2376 OBJECT  GLOBAL DEFAULT    4 vdso_start
  0948     0 OBJECT  GLOBAL DEFAULT    4 vdso_end

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: linux-arch@vger.kernel.org
Cc: linux-um@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20191011115108.12392-14-jslaby@suse.cz
---
 arch/x86/um/vdso/vdso.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/vdso/vdso.S b/arch/x86/um/vdso/vdso.S
index a4a3870..a6eaf29 100644
--- a/arch/x86/um/vdso/vdso.S
+++ b/arch/x86/um/vdso/vdso.S
@@ -1,11 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/init.h>
+#include <linux/linkage.h>
 
 __INITDATA
 
-	.globl vdso_start, vdso_end
-vdso_start:
+SYM_DATA_START(vdso_start)
 	.incbin "arch/x86/um/vdso/vdso.so"
-vdso_end:
+SYM_DATA_END_LABEL(vdso_start, SYM_L_GLOBAL, vdso_end)
 
 __FINIT
