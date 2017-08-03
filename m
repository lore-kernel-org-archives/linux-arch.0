Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:41755 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751944AbdHCSa0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 3 Aug 2017 14:30:26 -0400
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu,  3 Aug 2017 12:30:13 -0600
Message-ID: <20170803183018.5889-3-logang@deltatee.com>
In-Reply-To: <20170803183018.5889-1-logang@deltatee.com>
References: <20170803183018.5889-1-logang@deltatee.com>
Subject: [PATCH v6 2/7] powerpc: io.h: move iomap.h include so that it can use readq/writeq defs
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-ntb@googlegroups.com, linux-crypto@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, Stephen Bates <sbates@raithlin.com>, Logan Gunthorpe <logang@deltatee.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Suresh Warrier <warrier@linux.vnet.ibm.com>, Oliver O'Halloran <oohall@gmail.com>
Message-ID: <20170803183013.8wkF2Y_c-zDvCnmjb7N0P3Unbx_lU0qGu3qvvLZgkZg@z>

Subsequent patches in this series makes use of the readq and writeq
defines in iomap.h. However, as is, they get missed on the powerpc
platform seeing the include comes before the define. This patch
moves the include down to fix this.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-By: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Suresh Warrier <warrier@linux.vnet.ibm.com>
Cc: "Oliver O'Halloran" <oohall@gmail.com>
---
 arch/powerpc/include/asm/io.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 422f99cf9924..af074923d598 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -33,8 +33,6 @@ extern struct pci_dev *isa_bridge_pcidev;
 #include <asm/mmu.h>
 #include <asm/ppc_asm.h>
 
-#include <asm-generic/iomap.h>
-
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 #endif
@@ -663,6 +661,8 @@ static inline void name at					\
 #define writel_relaxed(v, addr)	writel(v, addr)
 #define writeq_relaxed(v, addr)	writeq(v, addr)
 
+#include <asm-generic/iomap.h>
+
 #ifdef CONFIG_PPC32
 #define mmiowb()
 #else
-- 
2.11.0
