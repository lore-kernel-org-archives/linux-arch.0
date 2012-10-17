From: Will Deacon <will.deacon@arm.com>
Subject: [RESEND PATCH 2/4] asm-generic: io: don't perform swab during {in,out} string functions
Date: Wed, 17 Oct 2012 16:45:02 +0100
Message-ID: <1350488704-3711-3-git-send-email-will.deacon@arm.com>
References: <1350488704-3711-1-git-send-email-will.deacon@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1350488704-3711-1-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Will Deacon <will.deacon@arm.com>, Mike Frysinger <vapier@gentoo.org>, Ben Herrenschmidt <benh@kernel.crashing.org>
List-Id: linux-arch.vger.kernel.org

The {in,out}s{b,w,l} functions are designed to operate on a stream of
bytes and therefore should not perform any byte-swapping, regardless of
the CPU byte order.

This patch fixes the generic IO header so that {in,out}s{b,w,l} call
the __raw_{read,write} functions directly rather than going via the
endian-correcting accessors.

Cc: Mike Frysinger <vapier@gentoo.org>
Cc: Ben Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/io.h |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 3607921..403b861 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -148,7 +148,7 @@ static inline void insb(unsigned long addr, void *buffer, int count)
 	if (count) {
 		u8 *buf = buffer;
 		do {
-			u8 x = inb(addr);
+			u8 x = __raw_readb(addr + PCI_IOBASE);
 			*buf++ = x;
 		} while (--count);
 	}
@@ -161,7 +161,7 @@ static inline void insw(unsigned long addr, void *buffer, int count)
 	if (count) {
 		u16 *buf = buffer;
 		do {
-			u16 x = inw(addr);
+			u16 x = __raw_readw(addr + PCI_IOBASE);
 			*buf++ = x;
 		} while (--count);
 	}
@@ -174,7 +174,7 @@ static inline void insl(unsigned long addr, void *buffer, int count)
 	if (count) {
 		u32 *buf = buffer;
 		do {
-			u32 x = inl(addr);
+			u32 x = __raw_readl(addr + PCI_IOBASE);
 			*buf++ = x;
 		} while (--count);
 	}
@@ -187,7 +187,7 @@ static inline void outsb(unsigned long addr, const void *buffer, int count)
 	if (count) {
 		const u8 *buf = buffer;
 		do {
-			outb(*buf++, addr);
+			__raw_writeb(*buf++, addr + PCI_IOBASE);
 		} while (--count);
 	}
 }
@@ -199,7 +199,7 @@ static inline void outsw(unsigned long addr, const void *buffer, int count)
 	if (count) {
 		const u16 *buf = buffer;
 		do {
-			outw(*buf++, addr);
+			__raw_writew(*buf++, addr + PCI_IOBASE);
 		} while (--count);
 	}
 }
@@ -211,7 +211,7 @@ static inline void outsl(unsigned long addr, const void *buffer, int count)
 	if (count) {
 		const u32 *buf = buffer;
 		do {
-			outl(*buf++, addr);
+			__raw_writel(*buf++, addr + PCI_IOBASE);
 		} while (--count);
 	}
 }
-- 
1.7.4.1
