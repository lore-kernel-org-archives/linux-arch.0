Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:54876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730177AbfBKRpw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Feb 2019 12:45:52 -0500
From: Will Deacon <will.deacon@arm.com>
Subject: [PATCH 1/2] asm-generic/io: Pass result on inX() accessor to __io_par()
Date: Mon, 11 Feb 2019 17:45:43 +0000
Message-ID: <20190211174544.4302-2-will.deacon@arm.com>
In-Reply-To: <20190211174544.4302-1-will.deacon@arm.com>
References: <20190211174544.4302-1-will.deacon@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-arch@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, andrew.murray@arm.com, arnd@arndb.de, catalin.marinas@arm.com, Will Deacon <will.deacon@arm.com>
Message-ID: <20190211174543.1GeOGQvBXRNZDnZQ1n87W7fQRpDe4Un4vk_pfL5tMc0@z>

The inX() I/O accessors must enforce ordering against subsequent calls
to the delay() routines, so that a read-back from a device can be used
to postpone a subsequent write to the same device.

On some architectures, including arm64, this ordering can only be
achieved by creating a dependency on the value returned by the inX()
operation, so we need to pass the value we read to the __io_par()
macro in this case.

Reported-by: Andrew Murray <andrew.murray@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/io.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d356f802945a..b5737c0d8316 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -65,7 +65,7 @@
 #endif
 
 #ifndef __io_par
-#define __io_par()     __io_ar()
+#define __io_par(v)     __io_ar()
 #endif
 
 
@@ -471,7 +471,7 @@ static inline u8 inb(unsigned long addr)
 
 	__io_pbr();
 	val = __raw_readb(PCI_IOBASE + addr);
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
@@ -484,7 +484,7 @@ static inline u16 inw(unsigned long addr)
 
 	__io_pbr();
 	val = __le16_to_cpu(__raw_readw(PCI_IOBASE + addr));
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
@@ -497,7 +497,7 @@ static inline u32 inl(unsigned long addr)
 
 	__io_pbr();
 	val = __le32_to_cpu(__raw_readl(PCI_IOBASE + addr));
-	__io_par();
+	__io_par(val);
 	return val;
 }
 #endif
-- 
2.11.0
