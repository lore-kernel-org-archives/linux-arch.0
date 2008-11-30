From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/1] edac x38: new MC driver module
Date: Sun, 30 Nov 2008 10:24:07 +0100
Message-ID: <20081130092407.GA10802@elte.hu>
References: <200811290056.mAT0uTuk028924@terminus.zytor.com> <20081129164736.0b5a71db.h.mitake@gmail.com> <20081129093858.GC26691@elte.hu> <20081129192610.716a2d57.h.mitake@gmail.com> <20081129105229.GA9643@uranus.ravnborg.org> <20081129222449.e341f028.h.mitake@gmail.com> <20081129180144.GA15533@uranus.ravnborg.org> <20081130171604.dc3c8715.h.mitake@gmail.com> <20081130083700.GA31644@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752557AbYK3JYu@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20081130083700.GA31644@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Hitoshi Mitake <h.mitake@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "Luck, Tony" <tony.luck@intel.com>, Russell King <rmk+lkml@arm.linux.org.uk>, Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@linux-foundation.org>, Doug Thompson <norsk5@yahoo.com>, dougthompson@xmission.com, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org


the 32-bit build broke promptly - readq/writeq is a family of APIs that 
has to be either fully provided or not provided at all. The fix is below.

	Ingo

--------------->
From 16ebd68883e3583a66733d8b12ba55c8985af3f6 Mon Sep 17 00:00:00 2001
From: Ingo Molnar <mingo@elte.hu>
Date: Sun, 30 Nov 2008 10:20:20 +0100
Subject: [PATCH] x86: provide readq()/writeq() on 32-bit too, complete

if HAVE_READQ/HAVE_WRITEQ are defined, the full range of readq/writeq
APIs has to be provided to drivers:

 drivers/infiniband/hw/amso1100/c2.c: In function 'c2_tx_ring_alloc':
 drivers/infiniband/hw/amso1100/c2.c:133: error: implicit declaration of function '__raw_writeq'

So provide them on 32-bit as well. Also, map all the APIs to the
strongest ordering variant. It's way too easy to mess such details
up in drivers and the difference between "memory" and "" constrained
asm() constructs is in the noise range.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/x86/include/asm/io.h |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 3ccfaf6..9036156 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -46,16 +46,11 @@ build_mmio_write(__writel, "l", unsigned int, "r", )
 #define mmiowb() barrier()
 
 #ifdef CONFIG_X86_64
+
 build_mmio_read(readq, "q", unsigned long, "=r", :"memory")
-build_mmio_read(__readq, "q", unsigned long, "=r", )
 build_mmio_write(writeq, "q", unsigned long, "r", :"memory")
-build_mmio_write(__writeq, "q", unsigned long, "r", )
-
-#define readq_relaxed(a) __readq(a)
-#define __raw_readq __readq
-#define __raw_writeq writeq
 
-#else  /* CONFIG_X86_32 from here */
+#else
 
 static inline __u64 readq(const volatile void __iomem *addr)
 {
@@ -76,9 +71,14 @@ static inline void writeq(__u64 val, volatile void __iomem *addr)
 
 #endif
 
+#define readq_relaxed(a)	readq(a)
+
+#define __raw_readq(a)		readq(a)
+#define __raw_writeq(a)		writeq(a)
+
 /* Let people know that we have them */
-#define readq		readq
-#define writeq		writeq
+#define readq			readq
+#define writeq			writeq
 
 extern int iommu_bio_merge;
 
