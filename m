From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] include/asm-generic/io.h: add 'UML' case just like 'no-MMU'
Date: Wed, 26 Jun 2013 14:31:20 +0800
Message-ID: <51CA8AB8.7080504@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:28515 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751309Ab3FZGcN (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 26 Jun 2013 02:32:13 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Arnd Bergmann <arnd@arndb.de>
Cc: dhsharp@google.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, uml-user <user-mode-linux-user@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

=46or "User Mode Linux", it may enable 'MMU', but not need implement
ioremap and iounmap, so "include/asm-generic/io.h" need notice this
case to keep itself 'generic'.

The related error (with allmodconfig, without pcap):

    CC [M]  drivers/ptp/ptp_pch.o
  drivers/ptp/ptp_pch.c: In function =91pch_remove=92:
  drivers/ptp/ptp_pch.c:571:3: error: implicit declaration of function =
=91iounmap=92 [-Werror=3Dimplicit-function-declaration]
  drivers/ptp/ptp_pch.c: In function =91pch_probe=92:
  drivers/ptp/ptp_pch.c:621:2: error: implicit declaration of function =
=91ioremap=92 [-Werror=3Dimplicit-function-declaration]
  drivers/ptp/ptp_pch.c:621:13: warning: assignment makes pointer from =
integer without a cast [enabled by default]
  cc1: some warnings being treated as errors


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/um/include/asm/Kbuild |    1 +
 include/asm-generic/io.h   |    6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index b30f34a..a34ea5d 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -3,3 +3,4 @@ generic-y +=3D hw_irq.h irq_regs.h kdebug.h percpu.h se=
ctions.h topology.h xor.h
 generic-y +=3D ftrace.h pci.h io.h param.h delay.h mutex.h current.h e=
xec.h
 generic-y +=3D switch_to.h clkdev.h
 generic-y +=3D trace_clock.h
+generic-y +=3D io.h
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d5afe96..e80331d 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -303,10 +303,10 @@ static inline void *phys_to_virt(unsigned long ad=
dress)
 /*
  * Change "struct page" to physical address.
  *
- * This implementation is for the no-MMU case only... if you have an M=
MU
+ * This implementation is for the no-MMU or UML case only... if you ha=
ve an MMU
  * you'll need to provide your own definitions.
  */
-#ifndef CONFIG_MMU
+#if !CONFIG_MMU || CONFIG_UML
 static inline void __iomem *ioremap(phys_addr_t offset, unsigned long =
size)
 {
 	return (void __iomem*) (unsigned long)offset;
@@ -325,7 +325,7 @@ static inline void __iomem *ioremap(phys_addr_t off=
set, unsigned long size)
 static inline void iounmap(void __iomem *addr)
 {
 }
-#endif /* CONFIG_MMU */
+#endif /* !CONFIG_MMU || CONFIG_UML */
=20
 #ifdef CONFIG_HAS_IOPORT
 #ifndef CONFIG_GENERIC_IOMAP
--=20
1.7.7.6
