From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH v2] arch: arm64: kernel: add '#ifdef CONFIG_COMPAT' for aarch32_break_handler()
Date: Mon, 24 Jun 2013 17:27:49 +0800
Message-ID: <51C81115.4070803@asianux.com>
References: <51C53C06.7050205@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:37364 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab3FXJ2m (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jun 2013 05:28:42 -0400
In-Reply-To: <51C53C06.7050205@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>
Cc: Tony Lindgren <tony@atomide.com>, "olof@lixom.net" <olof@lixom.net>, Santosh Shilimkar <santosh.shilimkar@ti.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>


If 'COMPAT' not defined, aarch32_break_handler() cannot pass compiling,
and it can work independent with 'COMPAT', so remove dummy definition.

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
 arch/arm64/include/asm/debug-monitors.h |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/inclu=
de/asm/debug-monitors.h
index ef8235c..a2232d0 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -83,14 +83,7 @@ static inline int reinstall_suspended_bps(struct pt_=
regs *regs)
 }
 #endif
=20
-#ifdef CONFIG_COMPAT
 int aarch32_break_handler(struct pt_regs *regs);
-#else
-static int aarch32_break_handler(struct pt_regs *regs)
-{
-	return -EFAULT;
-}
-#endif
=20
 #endif	/* __ASSEMBLY */
 #endif	/* __KERNEL__ */
--=20
1.7.7.6
