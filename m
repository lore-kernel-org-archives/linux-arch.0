Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36616 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932226AbeAOFyP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Jan 2018 00:54:15 -0500
From: Greentime Hu <green.hu@gmail.com>
Subject: [PATCH v6 02/36] openrisc: add ioremap_nocache declaration before include asm-generic/io.h and sync ioremap prototype with it.
Date: Mon, 15 Jan 2018 13:53:10 +0800
Message-ID: <3e5ba33674a883b56e20b35ea9ae34990ea838c8.1515766253.git.green.hu@gmail.com>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
In-Reply-To: <cover.1515766253.git.green.hu@gmail.com>
References: <cover.1515766253.git.green.hu@gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org, netdev@vger.kernel.org, deanbo422@gmail.com, devicetree@vger.kernel.org, viro@zeniv.linux.org.uk, dhowells@redhat.com, will.deacon@arm.com, daniel.lezcano@linaro.org, linux-serial@vger.kernel.org, geert.uytterhoeven@gmail.com, linus.walleij@linaro.org, mark.rutland@arm.com, greg@kroah.com, ren_guo@c-sky.com, rdunlap@infradead.org, davem@davemloft.net, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, shorne@gmail.com
Cc: green.hu@gmail.com
Message-ID: <20180115055310.nKriNDX1BoNjOurin0oBZrHzhFyDuzEcdSiwWi5wlU4@z>

From: Greentime Hu <greentime@andestech.com>

It will be built failed if commit id: d25ea659 is selected. This patch can fix this
build error.

Signed-off-by: Greentime Hu <greentime@andestech.com>
---
 arch/openrisc/include/asm/io.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index 7c69139..6709b28 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -29,13 +29,14 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
+#define ioremap_nocache ioremap_nocache
 #include <asm-generic/io.h>
 #include <asm/pgtable.h>
 
 extern void __iomem *__ioremap(phys_addr_t offset, unsigned long size,
 				pgprot_t prot);
 
-static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
+static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
 {
 	return __ioremap(offset, size, PAGE_KERNEL);
 }
-- 
1.7.9.5
