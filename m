From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH v2] include/asm-generic/iomap.h: trivial: use '__ASM_GENERIC_IOMAP_H'
 instead of '__GENERIC_IO_H'
Date: Fri, 28 Jun 2013 10:37:21 +0800
Message-ID: <51CCF6E1.3080200@asianux.com>
References: <51CCF58E.9000007@asianux.com> <51CCF659.7070908@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:38370 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754300Ab3F1CiO (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jun 2013 22:38:14 -0400
In-Reply-To: <51CCF659.7070908@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: 'Jiri Kosina' <trivial@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

Recommend to let the header file macro mark match the file name.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 include/asm-generic/iomap.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 6afd7d6..facfb39 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -1,5 +1,5 @@
-#ifndef __GENERIC_IO_H
-#define __GENERIC_IO_H
+#ifndef __ASM_GENERIC_IOMAP_H
+#define __ASM_GENERIC_IOMAP_H
 
 #include <linux/linkage.h>
 #include <asm/byteorder.h>
@@ -78,4 +78,4 @@ static inline void pci_iounmap(struct pci_dev *dev, void __iomem *addr)
 
 #include <asm-generic/pci_iomap.h>
 
-#endif
+#endif /* __ASM_GENERIC_IOMAP_H */
-- 
1.7.7.6
