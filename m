From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: arm64: kernel: add '#ifdef CONFIG_COMPAT' for aarch32_break_handler()
Date: Sat, 22 Jun 2013 13:54:14 +0800
Message-ID: <51C53C06.7050205@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:36771 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750775Ab3FVFzK (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 22 Jun 2013 01:55:10 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, "olof@lixom.net" <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>


If 'COMPAT' not defined, aarch32_break_handler() cannot pass compiling,
so need add '#ifdef' for it just like the header file has done.

The related make:

  make ARCH=3Darm64 randconfig
  make ARCH=3Darm64 menuconfig
  make ARCH=3Darm64 V=3D1 EXTRA_CFLAGS=3D-W

The related error:

  arch/arm64/kernel/debug-monitors.c:249:5: error: redefinition of =91a=
arch32_break_handler=92
  In file included from arch/arm64/kernel/debug-monitors.c:29:0:
  /root/linux-next/arch/arm64/include/asm/debug-monitors.h:89:12: note:=
 previous definition of =91aarch32_break_handler=92 was here


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm64/kernel/debug-monitors.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/deb=
ug-monitors.c
index 08018e3..ceedcd7 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -246,6 +246,7 @@ static int brk_handler(unsigned long addr, unsigned=
 int esr,
 	return 0;
 }
=20
+#ifdef CONFIG_COMPAT
 int aarch32_break_handler(struct pt_regs *regs)
 {
 	siginfo_t info;
@@ -285,6 +286,7 @@ int aarch32_break_handler(struct pt_regs *regs)
 	force_sig_info(SIGTRAP, &info, current);
 	return 0;
 }
+#endif
=20
 static int __init debug_traps_init(void)
 {
--=20
1.7.7.6
