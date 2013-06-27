From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] include/asm-generic/pci.h: include generic "pci-dma-compat.h"
Date: Thu, 27 Jun 2013 12:03:25 +0800
Message-ID: <51CBB98D.3040304@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:30924 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750800Ab3F0EES (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 00:04:18 -0400
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hirokazu Takata <takata@linux-m32r.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-m32r-ja@ml.linux-m32r.org, linux-m32r@ml.linux-m32r.org

If an architecture need "generic pci.h", it also need generic "pci-dma-
compat.h",  so recommend to include it in asm-generic directly.

And now, for arm64 and m32r, may cause compiling error about it.

The related error (with allmodconfig):

  drivers/media/usb/b2c2/flexcop-usb.c: In function =91flexcop_usb_tran=
sfer_exit=92:
  drivers/media/usb/b2c2/flexcop-usb.c:393:3: error: implicit declarati=
on of function =91pci_free_consistent=92 [-Werror=3Dimplicit-function-d=
eclaration]
  drivers/media/usb/b2c2/flexcop-usb.c: In function =91flexcop_usb_tran=
sfer_init=92:
  drivers/media/usb/b2c2/flexcop-usb.c:410:2: error: implicit declarati=
on of function =91pci_alloc_consistent=92 [-Werror=3Dimplicit-function-=
declaration]
  drivers/media/usb/b2c2/flexcop-usb.c:410:21: warning: assignment make=
s pointer from integer without a cast [enabled by default]
  cc1: some warnings being treated as errors


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 include/asm-generic/pci.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/asm-generic/pci.h b/include/asm-generic/pci.h
index e80a049..64e2a15 100644
--- a/include/asm-generic/pci.h
+++ b/include/asm-generic/pci.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_GENERIC_PCI_H
 #define _ASM_GENERIC_PCI_H
=20
+#include <asm-generic/pci-dma-compat.h>
+
 static inline struct resource *
 pcibios_select_root(struct pci_dev *pdev, struct resource *res)
 {
--=20
1.7.7.6
