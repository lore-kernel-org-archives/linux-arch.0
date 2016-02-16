From: David Brown <david.brown@linaro.org>
Subject: [PATCH] ARM: vdso: Mark vDSO code as read-only
Date: Tue, 16 Feb 2016 14:36:59 -0700
Message-ID: <20160216213659.GA47194@davidb.org>
References: <1453226922-16831-1-git-send-email-keescook@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35214 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756118AbcBPVhD (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 16 Feb 2016 16:37:03 -0500
Received: by mail-io0-f180.google.com with SMTP id g203so704405iof.2
        for <linux-arch@vger.kernel.org>; Tue, 16 Feb 2016 13:37:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1453226922-16831-1-git-send-email-keescook@chromium.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, kernel-hardening@lists.openwall.com, Ingo Molnar <mingo@redhat.com>, Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, PaX Team <pageexec@freemail.hu>, Emese Revfy <re.emese@gmail.com>, linux-kernel@vger.kernel.org, linux-arch <linux-arch@vger.kernel.org>

Although the arm vDSO is cleanly separated by code/data with the code
being read-only in userspace mappings, the code page is still writable
from the kernel.  There have been exploits (such as
http://itszn.com/blog/?p=21) that take advantage of this on x86 to go
from a bad kernel write to full root.

Prevent this specific exploit on arm by putting the vDSO code page in
post-init read-only memory as well.

Before:
vdso: 1 text pages at base 80927000
root@Vexpress:/ cat /sys/kernel/debug/kernel_page_tables
---[ Modules ]---
---[ Kernel Mapping ]---
0x80000000-0x80100000           1M     RW NX SHD
0x80100000-0x80600000           5M     ro x  SHD
0x80600000-0x80800000           2M     ro NX SHD
0x80800000-0xbe000000         984M     RW NX SHD

After:
vdso: 1 text pages at base 8072b000
root@Vexpress:/ cat /sys/kernel/debug/kernel_page_tables
---[ Modules ]---
---[ Kernel Mapping ]---
0x80000000-0x80100000           1M     RW NX SHD
0x80100000-0x80600000           5M     ro x  SHD
0x80600000-0x80800000           2M     ro NX SHD
0x80800000-0xbe000000         984M     RW NX SHD

Inspired by https://lkml.org/lkml/2016/1/19/494 based on work by the
PaX Team, Brad Spengler, and Kees Cook.

Signed-off-by: David Brown <david.brown@linaro.org>
---
This patch depends on Kees Cook's series
https://lkml.org/lkml/2016/1/19/497 which adds the ro_after_init
section.

 arch/arm/vdso/vdso.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/vdso/vdso.S b/arch/arm/vdso/vdso.S
index b2b97e3..a62a7b6 100644
--- a/arch/arm/vdso/vdso.S
+++ b/arch/arm/vdso/vdso.S
@@ -23,9 +23,8 @@
 #include <linux/const.h>
 #include <asm/page.h>
 
-	__PAGE_ALIGNED_DATA
-
 	.globl vdso_start, vdso_end
+	.section .data..ro_after_init
 	.balign PAGE_SIZE
 vdso_start:
 	.incbin "arch/arm/vdso/vdso.so"
-- 
2.7.1
