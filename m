From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] arch: m68k: include: asm: the 3rd parameter of 'insl' and
 'outsl' need '<< 2'
Date: Thu, 30 May 2013 17:39:21 +0800
Message-ID: <51A71E49.1000707@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:56837 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666Ab3E3JkP (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 30 May 2013 05:40:15 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, gerg@uclinux.org, schmitz@debian.org, Sam Ravnborg <sam@ravnborg.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-m68k@lists.linux-m68k.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>


According to the original implementation in 2009, 'insl' and 'outsl'
need '<< 2'.

Also add '#ifdef' to avoid multiple defination, and beautify code to
pass "./scripts/checkpatch.pl"

The related git number:
  for parport.h: "4914802 m68k,m68knommu: merge header files" in 2009
  for io_mm.h: "84b16b7 m68k/atari: ROM port ISA adapter support" in Apr 6 2013

The related warning (make EXTRA_CFLAG=-W ARCH=m68k allmodconfig):
  arch/m68k/include/asm/parport.h:14:0: warning: "insl" redefined [enabled by default]
  arch/m68k/include/asm/io_mm.h:403:0: note: this is the location of the previous definition
  arch/m68k/include/asm/parport.h:15:0: warning: "outsl" redefined [enabled by default]
  arch/m68k/include/asm/io_mm.h:406:0: note: this is the location of the previous definition


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/m68k/include/asm/io_mm.h   |    5 +++--
 arch/m68k/include/asm/parport.h |    9 +++++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index ffdf54f4..66be3b2 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -400,10 +400,11 @@ static inline void isa_delay(void)
 
 #define insb(port, buf, nr)	((port) < 1024 ? isa_rom_insb((port), (buf), (nr)) : isa_insb((port), (buf), (nr)))
 #define insw(port, buf, nr)	((port) < 1024 ? isa_rom_insw((port), (buf), (nr)) : isa_insw((port), (buf), (nr)))
-#define insl			isa_insl
+#define insl(port, buf, len)	isa_insb((port), (buf), (len) << 2)
+
 #define outsb(port, buf, nr)	((port) < 1024 ? isa_rom_outsb((port), (buf), (nr)) : isa_outsb((port), (buf), (nr)))
 #define outsw(port, buf, nr)	((port) < 1024 ? isa_rom_outsw((port), (buf), (nr)) : isa_outsw((port), (buf), (nr)))
-#define outsl			isa_outsl
+#define outsl(port, buf, len)	isa_outsb((port), (buf), (len) << 2)
 
 #define readb(addr)		in_8(addr)
 #define writeb(val, addr)	out_8((addr), (val))
diff --git a/arch/m68k/include/asm/parport.h b/arch/m68k/include/asm/parport.h
index 5ea75e6..e8e4a2a 100644
--- a/arch/m68k/include/asm/parport.h
+++ b/arch/m68k/include/asm/parport.h
@@ -11,8 +11,13 @@
 #ifndef _ASM_M68K_PARPORT_H
 #define _ASM_M68K_PARPORT_H 1
 
-#define insl(port,buf,len)   isa_insb(port,buf,(len)<<2)
-#define outsl(port,buf,len)  isa_outsb(port,buf,(len)<<2)
+#ifndef insl
+#define insl(port, buf, len)   isa_insb((port), (buf), (len) << 2)
+#endif
+
+#ifndef outsl
+#define outsl(port, buf, len)  isa_outsb((port), (buf), (len) << 2)
+#endif
 
 /* no dma, or IRQ autoprobing */
 static int parport_pc_find_isa_ports (int autoirq, int autodma);
-- 
1.7.7.6
